#import "RACSignal.h"
@interface RACErrorSignal : RACSignal
+ (RACSignal *)error:(NSError *)error;
@end
