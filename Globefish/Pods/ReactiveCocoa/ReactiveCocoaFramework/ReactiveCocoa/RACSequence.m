#import "RACSequence.h"
#import "RACArraySequence.h"
#import "RACDynamicSequence.h"
#import "RACEagerSequence.h"
#import "RACEmptySequence.h"
#import "RACScheduler.h"
#import "RACSignal.h"
#import "RACSubscriber.h"
#import "RACTuple.h"
#import "RACUnarySequence.h"
@interface RACSequenceEnumerator : NSEnumerator
@property (nonatomic, strong) RACSequence *sequence;
@end
@interface RACSequence ()
- (instancetype)bind:(RACStreamBindBlock)block passingThroughValuesFromSequence:(RACSequence *)current;
@end
@implementation RACSequenceEnumerator
- (id)nextObject {
	id object = nil;
	@synchronized (self) {
		object = self.sequence.head;
		self.sequence = self.sequence.tail;
	}
	return object;
}
@end
@implementation RACSequence
#pragma mark Lifecycle
+ (RACSequence *)sequenceWithHeadBlock:(id (^)(void))headBlock tailBlock:(RACSequence *(^)(void))tailBlock {
	return [[RACDynamicSequence sequenceWithHeadBlock:headBlock tailBlock:tailBlock] setNameWithFormat:@"+sequenceWithHeadBlock:tailBlock:"];
}
#pragma mark Class cluster primitives
- (id)head {
	NSCAssert(NO, @"%s must be overridden by subclasses", __func__);
	return nil;
}
- (RACSequence *)tail {
	NSCAssert(NO, @"%s must be overridden by subclasses", __func__);
	return nil;
}
#pragma mark RACStream
+ (instancetype)empty {
	return RACEmptySequence.empty;
}
+ (instancetype)return:(id)value {
	return [RACUnarySequence return:value];
}
- (instancetype)bind:(RACStreamBindBlock (^)(void))block {
	RACStreamBindBlock bindBlock = block();
	return [[self bind:bindBlock passingThroughValuesFromSequence:nil] setNameWithFormat:@"[%@] -bind:", self.name];
}
- (instancetype)bind:(RACStreamBindBlock)bindBlock passingThroughValuesFromSequence:(RACSequence *)passthroughSequence {
	__block RACSequence *valuesSeq = self;
	__block RACSequence *current = passthroughSequence;
	__block BOOL stop = NO;
	RACSequence *sequence = [RACDynamicSequence sequenceWithLazyDependency:^ id {
		while (current.head == nil) {
			if (stop) return nil;
			id value = valuesSeq.head;
			if (value == nil) {
				stop = YES;
				return nil;
			}
			current = (id)bindBlock(value, &stop);
			if (current == nil) {
				stop = YES;
				return nil;
			}
			valuesSeq = valuesSeq.tail;
		}
		NSCAssert([current isKindOfClass:RACSequence.class], @"-bind: block returned an object that is not a sequence: %@", current);
		return nil;
	} headBlock:^(id _) {
		return current.head;
	} tailBlock:^ id (id _) {
		if (stop) return nil;
		return [valuesSeq bind:bindBlock passingThroughValuesFromSequence:current.tail];
	}];
	sequence.name = self.name;
	return sequence;
}
- (instancetype)concat:(RACStream *)stream {
	NSCParameterAssert(stream != nil);
	return [[[RACArraySequence sequenceWithArray:@[ self, stream ] offset:0]
		flatten]
		setNameWithFormat:@"[%@] -concat: %@", self.name, stream];
}
- (instancetype)zipWith:(RACSequence *)sequence {
	NSCParameterAssert(sequence != nil);
	return [[RACSequence
		sequenceWithHeadBlock:^ id {
			if (self.head == nil || sequence.head == nil) return nil;
			return RACTuplePack(self.head, sequence.head);
		} tailBlock:^ id {
			if (self.tail == nil || [[RACSequence empty] isEqual:self.tail]) return nil;
			if (sequence.tail == nil || [[RACSequence empty] isEqual:sequence.tail]) return nil;
			return [self.tail zipWith:sequence.tail];
		}]
		setNameWithFormat:@"[%@] -zipWith: %@", self.name, sequence];
}
#pragma mark Extended methods
- (NSArray *)array {
	NSMutableArray *array = [NSMutableArray array];
	for (id obj in self) {
		[array addObject:obj];
	}
	return [array copy];
}
- (NSEnumerator *)objectEnumerator {
	RACSequenceEnumerator *enumerator = [[RACSequenceEnumerator alloc] init];
	enumerator.sequence = self;
	return enumerator;
}
- (RACSignal *)signal {
	return [[self signalWithScheduler:[RACScheduler scheduler]] setNameWithFormat:@"[%@] -signal", self.name];
}
- (RACSignal *)signalWithScheduler:(RACScheduler *)scheduler {
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		__block RACSequence *sequence = self;
		return [scheduler scheduleRecursiveBlock:^(void (^reschedule)(void)) {
			if (sequence.head == nil) {
				[subscriber sendCompleted];
				return;
			}
			[subscriber sendNext:sequence.head];
			sequence = sequence.tail;
			reschedule();
		}];
	}] setNameWithFormat:@"[%@] -signalWithScheduler:", self.name];
}
- (id)foldLeftWithStart:(id)start reduce:(id (^)(id, id))reduce {
	NSCParameterAssert(reduce != NULL);
	if (self.head == nil) return start;
	for (id value in self) {
		start = reduce(start, value);
	}
	return start;
}
- (id)foldRightWithStart:(id)start reduce:(id (^)(id, RACSequence *))reduce {
	NSCParameterAssert(reduce != NULL);
	if (self.head == nil) return start;
	RACSequence *rest = [RACSequence sequenceWithHeadBlock:^{
		return [self.tail foldRightWithStart:start reduce:reduce];
	} tailBlock:nil];
	return reduce(self.head, rest);
}
- (BOOL)any:(BOOL (^)(id))block {
	NSCParameterAssert(block != NULL);
	return [self objectPassingTest:block] != nil;
}
- (BOOL)all:(BOOL (^)(id))block {
	NSCParameterAssert(block != NULL);
	NSNumber *result = [self foldLeftWithStart:@YES reduce:^(NSNumber *accumulator, id value) {
		return @(accumulator.boolValue && block(value));
	}];
	return result.boolValue;
}
- (id)objectPassingTest:(BOOL (^)(id))block {
	NSCParameterAssert(block != NULL);
	return [self filter:block].head;
}
- (RACSequence *)eagerSequence {
	return [RACEagerSequence sequenceWithArray:self.array offset:0];
}
- (RACSequence *)lazySequence {
	return self;
}
#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
	return self;
}
#pragma mark NSCoding
- (Class)classForCoder {
	return RACArraySequence.class;
}
- (id)initWithCoder:(NSCoder *)coder {
	if (![self isKindOfClass:RACArraySequence.class]) return [[RACArraySequence alloc] initWithCoder:coder];
	return [super init];
}
- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.array forKey:@"array"];
}
#pragma mark NSFastEnumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id *)stackbuf count:(NSUInteger)len {
	if (state->state == ULONG_MAX) {
		return 0;
	}
	RACSequence *(^getSequence)(void) = ^{
		return (__bridge RACSequence *)(void *)state->state;
	};
	void (^setSequence)(RACSequence *) = ^(RACSequence *sequence) {
		CFBridgingRelease((void *)state->state);
		state->state = (unsigned long)CFBridgingRetain(sequence);
	};
	void (^complete)(void) = ^{
		setSequence(nil);
		state->state = ULONG_MAX;
	};
	if (state->state == 0) {
		state->mutationsPtr = state->extra;
		setSequence(self);
	}
	state->itemsPtr = stackbuf;
	NSUInteger enumeratedCount = 0;
	while (enumeratedCount < len) {
		RACSequence *seq = getSequence();
		__autoreleasing id obj = seq.head;
		if (obj == nil) {
			complete();
			break;
		}
		stackbuf[enumeratedCount++] = obj;
		if (seq.tail == nil) {
			complete();
			break;
		}
		setSequence(seq.tail);
	}
	return enumeratedCount;
}
#pragma mark NSObject
- (NSUInteger)hash {
	return [self.head hash];
}
- (BOOL)isEqual:(RACSequence *)seq {
	if (self == seq) return YES;
	if (![seq isKindOfClass:RACSequence.class]) return NO;
	for (id<NSObject> selfObj in self) {
		id<NSObject> seqObj = seq.head;
		if (![seqObj isEqual:selfObj]) return NO;
		seq = seq.tail;
	}
	return (seq.head == nil);
}
@end
@implementation RACSequence (Deprecated)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (id)foldLeftWithStart:(id)start combine:(id (^)(id accumulator, id value))combine {
	return [self foldLeftWithStart:start reduce:combine];
}
- (id)foldRightWithStart:(id)start combine:(id (^)(id first, RACSequence *rest))combine {
	return [self foldRightWithStart:start reduce:combine];
}
#pragma clang diagnostic pop
@end
