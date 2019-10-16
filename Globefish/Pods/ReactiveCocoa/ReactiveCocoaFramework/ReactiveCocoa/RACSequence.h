#import <Foundation/Foundation.h>
#import "RACStream.h"
@class RACScheduler;
@class RACSignal;
@interface RACSequence : RACStream <NSCoding, NSCopying, NSFastEnumeration>
@property (nonatomic, strong, readonly) id head;
@property (nonatomic, strong, readonly) RACSequence *tail;
@property (nonatomic, copy, readonly) NSArray *array;
@property (nonatomic, copy, readonly) NSEnumerator *objectEnumerator;
@property (nonatomic, copy, readonly) RACSequence *eagerSequence;
@property (nonatomic, copy, readonly) RACSequence *lazySequence;
- (RACSignal *)signal;
- (RACSignal *)signalWithScheduler:(RACScheduler *)scheduler;
- (id)foldLeftWithStart:(id)start reduce:(id (^)(id accumulator, id value))reduce;
- (id)foldRightWithStart:(id)start reduce:(id (^)(id first, RACSequence *rest))reduce;
- (BOOL)any:(BOOL (^)(id value))block;
- (BOOL)all:(BOOL (^)(id value))block;
- (id)objectPassingTest:(BOOL (^)(id value))block;
+ (RACSequence *)sequenceWithHeadBlock:(id (^)(void))headBlock tailBlock:(RACSequence *(^)(void))tailBlock;
@end
@interface RACSequence (Deprecated)
- (id)foldLeftWithStart:(id)start combine:(id (^)(id accumulator, id value))combine __attribute__((deprecated("Renamed to -foldLeftWithStart:reduce:")));
- (id)foldRightWithStart:(id)start combine:(id (^)(id first, RACSequence *rest))combine __attribute__((deprecated("Renamed to -foldRightWithStart:reduce:")));
@end
