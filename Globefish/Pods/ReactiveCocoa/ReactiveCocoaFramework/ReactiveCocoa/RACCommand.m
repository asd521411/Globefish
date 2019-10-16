#import "RACCommand.h"
#import "RACEXTScope.h"
#import "NSArray+RACSequenceAdditions.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACDescription.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACMulticastConnection.h"
#import "RACReplaySubject.h"
#import "RACScheduler.h"
#import "RACSequence.h"
#import "RACSignal+Operations.h"
#import <libkern/OSAtomic.h>
NSString * const RACCommandErrorDomain = @"RACCommandErrorDomain";
NSString * const RACUnderlyingCommandErrorKey = @"RACUnderlyingCommandErrorKey";
const NSInteger RACCommandErrorNotEnabled = 1;
@interface RACCommand () {
	NSMutableArray *_activeExecutionSignals;
	volatile uint32_t _allowsConcurrentExecution;
}
@property (atomic, copy, readonly) NSArray *activeExecutionSignals;
@property (nonatomic, strong, readonly) RACSignal *immediateEnabled;
@property (nonatomic, copy, readonly) RACSignal * (^signalBlock)(id input);
- (void)addActiveExecutionSignal:(RACSignal *)signal;
- (void)removeActiveExecutionSignal:(RACSignal *)signal;
@end
@implementation RACCommand
#pragma mark Properties
- (BOOL)allowsConcurrentExecution {
	return _allowsConcurrentExecution != 0;
}
- (void)setAllowsConcurrentExecution:(BOOL)allowed {
	[self willChangeValueForKey:@keypath(self.allowsConcurrentExecution)];
	if (allowed) {
		OSAtomicOr32Barrier(1, &_allowsConcurrentExecution);
	} else {
		OSAtomicAnd32Barrier(0, &_allowsConcurrentExecution);
	}
	[self didChangeValueForKey:@keypath(self.allowsConcurrentExecution)];
}
- (NSArray *)activeExecutionSignals {
	@synchronized (self) {
		return [_activeExecutionSignals copy];
	}
}
- (void)addActiveExecutionSignal:(RACSignal *)signal {
	NSCParameterAssert([signal isKindOfClass:RACSignal.class]);
	@synchronized (self) {
		NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:_activeExecutionSignals.count];
		[self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@keypath(self.activeExecutionSignals)];
		[_activeExecutionSignals addObject:signal];
		[self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@keypath(self.activeExecutionSignals)];
	}
}
- (void)removeActiveExecutionSignal:(RACSignal *)signal {
	NSCParameterAssert([signal isKindOfClass:RACSignal.class]);
	@synchronized (self) {
		NSIndexSet *indexes = [_activeExecutionSignals indexesOfObjectsPassingTest:^ BOOL (RACSignal *obj, NSUInteger index, BOOL *stop) {
			return obj == signal;
		}];
		if (indexes.count == 0) return;
		[self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@keypath(self.activeExecutionSignals)];
		[_activeExecutionSignals removeObjectsAtIndexes:indexes];
		[self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@keypath(self.activeExecutionSignals)];
	}
}
#pragma mark Lifecycle
- (id)init {
	NSCAssert(NO, @"Use -initWithSignalBlock: instead");
	return nil;
}
- (id)initWithSignalBlock:(RACSignal * (^)(id input))signalBlock {
	return [self initWithEnabled:nil signalBlock:signalBlock];
}
- (id)initWithEnabled:(RACSignal *)enabledSignal signalBlock:(RACSignal * (^)(id input))signalBlock {
	NSCParameterAssert(signalBlock != nil);
	self = [super init];
	if (self == nil) return nil;
	_activeExecutionSignals = [[NSMutableArray alloc] init];
	_signalBlock = [signalBlock copy];
	RACSignal *newActiveExecutionSignals = [[[[[self
		rac_valuesAndChangesForKeyPath:@keypath(self.activeExecutionSignals) options:NSKeyValueObservingOptionNew observer:nil]
		reduceEach:^(id _, NSDictionary *change) {
			NSArray *signals = change[NSKeyValueChangeNewKey];
			if (signals == nil) return [RACSignal empty];
			return [signals.rac_sequence signalWithScheduler:RACScheduler.immediateScheduler];
		}]
		concat]
		publish]
		autoconnect];
	_executionSignals = [[[newActiveExecutionSignals
		map:^(RACSignal *signal) {
			return [signal catchTo:[RACSignal empty]];
		}]
		deliverOn:RACScheduler.mainThreadScheduler]
		setNameWithFormat:@"%@ -executionSignals", self];
	RACMulticastConnection *errorsConnection = [[[newActiveExecutionSignals
		flattenMap:^(RACSignal *signal) {
			return [[signal
				ignoreValues]
				catch:^(NSError *error) {
					return [RACSignal return:error];
				}];
		}]
		deliverOn:RACScheduler.mainThreadScheduler]
		publish];
	_errors = [errorsConnection.signal setNameWithFormat:@"%@ -errors", self];
	[errorsConnection connect];
	RACSignal *immediateExecuting = [RACObserve(self, activeExecutionSignals) map:^(NSArray *activeSignals) {
		return @(activeSignals.count > 0);
	}];
	_executing = [[[[[immediateExecuting
		deliverOn:RACScheduler.mainThreadScheduler]
		startWith:@NO]
		distinctUntilChanged]
		replayLast]
		setNameWithFormat:@"%@ -executing", self];
	RACSignal *moreExecutionsAllowed = [RACSignal
		if:RACObserve(self, allowsConcurrentExecution)
		then:[RACSignal return:@YES]
		else:[immediateExecuting not]];
	if (enabledSignal == nil) {
		enabledSignal = [RACSignal return:@YES];
	} else {
		enabledSignal = [[[enabledSignal
			startWith:@YES]
			takeUntil:self.rac_willDeallocSignal]
			replayLast];
	}
	_immediateEnabled = [[RACSignal
		combineLatest:@[ enabledSignal, moreExecutionsAllowed ]]
		and];
	_enabled = [[[[[self.immediateEnabled
		take:1]
		concat:[[self.immediateEnabled skip:1] deliverOn:RACScheduler.mainThreadScheduler]]
		distinctUntilChanged]
		replayLast]
		setNameWithFormat:@"%@ -enabled", self];
	return self;
}
#pragma mark Execution
- (RACSignal *)execute:(id)input {
	BOOL enabled = [[self.immediateEnabled first] boolValue];
	if (!enabled) {
		NSError *error = [NSError errorWithDomain:RACCommandErrorDomain code:RACCommandErrorNotEnabled userInfo:@{
			NSLocalizedDescriptionKey: NSLocalizedString(@"The command is disabled and cannot be executed", nil),
			RACUnderlyingCommandErrorKey: self
		}];
		return [RACSignal error:error];
	}
	RACSignal *signal = self.signalBlock(input);
	NSCAssert(signal != nil, @"nil signal returned from signal block for value: %@", input);
	RACMulticastConnection *connection = [[signal
		subscribeOn:RACScheduler.mainThreadScheduler]
		multicast:[RACReplaySubject subject]];
	@weakify(self);
	[self addActiveExecutionSignal:connection.signal];
	[connection.signal subscribeError:^(NSError *error) {
		@strongify(self);
		[self removeActiveExecutionSignal:connection.signal];
	} completed:^{
		@strongify(self);
		[self removeActiveExecutionSignal:connection.signal];
	}];
	[connection connect];
	return [connection.signal setNameWithFormat:@"%@ -execute: %@", self, [input rac_description]];
}
#pragma mark NSKeyValueObserving
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
	return NO;
}
@end
