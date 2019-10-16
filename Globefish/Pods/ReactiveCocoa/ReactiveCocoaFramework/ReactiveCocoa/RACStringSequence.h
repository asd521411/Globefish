#import "RACSequence.h"
@interface RACStringSequence : RACSequence
+ (RACSequence *)sequenceWithString:(NSString *)string offset:(NSUInteger)offset;
@end
