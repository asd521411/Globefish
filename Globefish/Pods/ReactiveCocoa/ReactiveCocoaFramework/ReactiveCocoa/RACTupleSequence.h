#import "RACSequence.h"
@interface RACTupleSequence : RACSequence
+ (instancetype)sequenceWithTupleBackingArray:(NSArray *)backingArray offset:(NSUInteger)offset;
@end
