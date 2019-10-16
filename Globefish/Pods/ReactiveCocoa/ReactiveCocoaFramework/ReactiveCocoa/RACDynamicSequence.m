#import "RACDynamicSequence.h"
#import <libkern/OSAtomic.h>
#define DEALLOC_OVERFLOW_GUARD 100
@interface RACDynamicSequence () {
	id _head;
	RACSequence *_tail;
	id _dependency;
}
@property (nonatomic, strong) id headBlock;
@property (nonatomic, strong) id tailBlock;
@property (nonatomic, assign) BOOL hasDependency;
@property (nonatomic, strong) id (^dependencyBlock)(void);
@end
@implementation RACDynamicSequence
#pragma mark Lifecycle
+ (RACSequence *)sequenceWithHeadBlock:(id (^)(void))headBlock tailBlock:(RACSequence *(^)(void))tailBlock {
	NSCParameterAssert(headBlock != nil);
	RACDynamicSequence *seq = [[RACDynamicSequence alloc] init];
	seq.headBlock = [headBlock copy];
	seq.tailBlock = [tailBlock copy];
	seq.hasDependency = NO;
	return seq;
}
+ (RACSequence *)sequenceWithLazyDependency:(id (^)(void))dependencyBlock headBlock:(id (^)(id dependency))headBlock tailBlock:(RACSequence *(^)(id dependency))tailBlock {
	NSCParameterAssert(dependencyBlock != nil);
	NSCParameterAssert(headBlock != nil);
	RACDynamicSequence *seq = [[RACDynamicSequence alloc] init];
	seq.headBlock = [headBlock copy];
	seq.tailBlock = [tailBlock copy];
	seq.dependencyBlock = [dependencyBlock copy];
	seq.hasDependency = YES;
	return seq;
}
- (void)dealloc {
	static volatile int32_t directDeallocCount = 0;
	if (OSAtomicIncrement32(&directDeallocCount) >= DEALLOC_OVERFLOW_GUARD) {
		OSAtomicAdd32(-DEALLOC_OVERFLOW_GUARD, &directDeallocCount);
		__autoreleasing RACSequence *tail __attribute__((unused)) = _tail;
	}
	_tail = nil;
}
#pragma mark RACSequence
- (id)head {
	@synchronized (self) {
		id untypedHeadBlock = self.headBlock;
		if (untypedHeadBlock == nil) return _head;
		if (self.hasDependency) {
			if (self.dependencyBlock != nil) {
				_dependency = self.dependencyBlock();
				self.dependencyBlock = nil;
			}
			id (^headBlock)(id) = untypedHeadBlock;
			_head = headBlock(_dependency);
		} else {
			id (^headBlock)(void) = untypedHeadBlock;
			_head = headBlock();
		}
		self.headBlock = nil;
		return _head;
	}
}
- (RACSequence *)tail {
	@synchronized (self) {
		id untypedTailBlock = self.tailBlock;
		if (untypedTailBlock == nil) return _tail;
		if (self.hasDependency) {
			if (self.dependencyBlock != nil) {
				_dependency = self.dependencyBlock();
				self.dependencyBlock = nil;
			}
			RACSequence * (^tailBlock)(id) = untypedTailBlock;
			_tail = tailBlock(_dependency);
		} else {
			RACSequence * (^tailBlock)(void) = untypedTailBlock;
			_tail = tailBlock();
		}
		if (_tail.name == nil) _tail.name = self.name;
		self.tailBlock = nil;
		return _tail;
	}
}
#pragma mark NSObject
- (NSString *)description {
	id head = @"(unresolved)";
	id tail = @"(unresolved)";
	@synchronized (self) {
		if (self.headBlock == nil) head = _head;
		if (self.tailBlock == nil) {
			tail = _tail;
			if (tail == self) tail = @"(self)";
		}
	}
	return [NSString stringWithFormat:@"<%@: %p>{ name = %@, head = %@, tail = %@ }", self.class, self, self.name, head, tail];
}
@end
