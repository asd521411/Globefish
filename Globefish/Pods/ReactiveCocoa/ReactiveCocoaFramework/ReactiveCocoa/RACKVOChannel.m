#import "RACKVOChannel.h"
#import "RACEXTScope.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACKVOWrapper.h"
#import "NSString+RACKeyPathUtilities.h"
#import "RACChannel.h"
#import "RACCompoundDisposable.h"
#import "RACDisposable.h"
#import "RACSignal+Operations.h"
static NSString * const RACKVOChannelDataDictionaryKey = @"RACKVOChannelKey";
@interface RACKVOChannelData : NSObject
@property (nonatomic, assign) BOOL ignoreNextUpdate;
@property (nonatomic, assign) void *owner;
+ (instancetype)dataForChannel:(RACKVOChannel *)channel;
@end
@interface RACKVOChannel ()
@property (atomic, unsafe_unretained) NSObject *target;
@property (nonatomic, copy, readonly) NSString *keyPath;
@property (nonatomic, strong, readonly) RACKVOChannelData *currentThreadData;
- (void)createCurrentThreadData;
- (void)destroyCurrentThreadData;
@end
@implementation RACKVOChannel
#pragma mark Properties
- (RACKVOChannelData *)currentThreadData {
	NSMutableArray *dataArray = NSThread.currentThread.threadDictionary[RACKVOChannelDataDictionaryKey];
	for (RACKVOChannelData *data in dataArray) {
		if (data.owner == (__bridge void *)self) return data;
	}
	return nil;
}
#pragma mark Lifecycle
- (id)initWithTarget:(NSObject *)target keyPath:(NSString *)keyPath nilValue:(id)nilValue {
	NSCParameterAssert(keyPath.rac_keyPathComponents.count > 0);
	self = [super init];
	if (self == nil) return nil;
	_target = target;
	_keyPath = [keyPath copy];
	[self.leadingTerminal setNameWithFormat:@"[-initWithTarget: %@ keyPath: %@ nilValue: %@] -leadingTerminal", target, keyPath, nilValue];
	[self.followingTerminal setNameWithFormat:@"[-initWithTarget: %@ keyPath: %@ nilValue: %@] -followingTerminal", target, keyPath, nilValue];
	RACDisposable *observationDisposable = [target rac_observeKeyPath:keyPath options:NSKeyValueObservingOptionInitial observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
		if (!causedByDealloc && affectedOnlyLastComponent && self.currentThreadData.ignoreNextUpdate) {
			[self destroyCurrentThreadData];
			return;
		}
		[self.leadingTerminal sendNext:value];
	}];
	NSString *keyPathByDeletingLastKeyPathComponent = keyPath.rac_keyPathByDeletingLastKeyPathComponent;
	NSArray *keyPathComponents = keyPath.rac_keyPathComponents;
	NSUInteger keyPathComponentsCount = keyPathComponents.count;
	NSString *lastKeyPathComponent = keyPathComponents.lastObject;
	[[self.leadingTerminal
		finally:^{
			[observationDisposable dispose];
		}]
		subscribeNext:^(id x) {
			NSObject *object = (keyPathComponentsCount > 1 ? [self.target valueForKeyPath:keyPathByDeletingLastKeyPathComponent] : self.target);
			if (object == nil) return;
			[self createCurrentThreadData];
			self.currentThreadData.ignoreNextUpdate = YES;
			[object setValue:x ?: nilValue forKey:lastKeyPathComponent];
		} error:^(NSError *error) {
			NSCAssert(NO, @"Received error in %@: %@", self, error);
			NSLog(@"Received error in %@: %@", self, error);
		}];
	@weakify(self);
	[target.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^{
		@strongify(self);
		[self.leadingTerminal sendCompleted];
		self.target = nil;
	}]];
	return self;
}
- (void)createCurrentThreadData {
	NSMutableArray *dataArray = NSThread.currentThread.threadDictionary[RACKVOChannelDataDictionaryKey];
	if (dataArray == nil) {
		dataArray = [NSMutableArray array];
		NSThread.currentThread.threadDictionary[RACKVOChannelDataDictionaryKey] = dataArray;
		[dataArray addObject:[RACKVOChannelData dataForChannel:self]];
		return;
	}
	for (RACKVOChannelData *data in dataArray) {
		if (data.owner == (__bridge void *)self) return;
	}
	[dataArray addObject:[RACKVOChannelData dataForChannel:self]];
}
- (void)destroyCurrentThreadData {
	NSMutableArray *dataArray = NSThread.currentThread.threadDictionary[RACKVOChannelDataDictionaryKey];
	NSUInteger index = [dataArray indexOfObjectPassingTest:^ BOOL (RACKVOChannelData *data, NSUInteger idx, BOOL *stop) {
		return data.owner == (__bridge void *)self;
	}];
	if (index != NSNotFound) [dataArray removeObjectAtIndex:index];
}
@end
@implementation RACKVOChannel (RACChannelTo)
- (RACChannelTerminal *)objectForKeyedSubscript:(NSString *)key {
	NSCParameterAssert(key != nil);
	RACChannelTerminal *terminal = [self valueForKey:key];
	NSCAssert([terminal isKindOfClass:RACChannelTerminal.class], @"Key \"%@\" does not identify a channel terminal", key);
	return terminal;
}
- (void)setObject:(RACChannelTerminal *)otherTerminal forKeyedSubscript:(NSString *)key {
	NSCParameterAssert(otherTerminal != nil);
	RACChannelTerminal *selfTerminal = [self objectForKeyedSubscript:key];
	[otherTerminal subscribe:selfTerminal];
	[[selfTerminal skip:1] subscribe:otherTerminal];
}
@end
@implementation RACKVOChannelData
+ (instancetype)dataForChannel:(RACKVOChannel *)channel {
	RACKVOChannelData *data = [[self alloc] init];
	data->_owner = (__bridge void *)channel;
	return data;
}
@end
