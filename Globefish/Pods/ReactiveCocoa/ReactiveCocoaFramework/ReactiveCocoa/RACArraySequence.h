#import "RACSequence.h"
@interface RACArraySequence : RACSequence
+ (instancetype)sequenceWithArray:(NSArray *)array offset:(NSUInteger)offset;
@end
