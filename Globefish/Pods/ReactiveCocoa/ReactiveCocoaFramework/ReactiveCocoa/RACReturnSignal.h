#import "RACSignal.h"
@interface RACReturnSignal : RACSignal
+ (RACSignal *)return:(id)value;
@end
