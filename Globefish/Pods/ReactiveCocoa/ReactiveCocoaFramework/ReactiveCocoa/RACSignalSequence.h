#import "RACSequence.h"
@class RACSignal;
@interface RACSignalSequence : RACSequence
+ (RACSequence *)sequenceWithSignal:(RACSignal *)signal;
@end
