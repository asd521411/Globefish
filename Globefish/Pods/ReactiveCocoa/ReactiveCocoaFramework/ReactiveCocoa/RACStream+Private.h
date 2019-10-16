#import "RACStream.h"
@interface RACStream ()
+ (instancetype)join:(id<NSFastEnumeration>)streams block:(RACStream * (^)(id, id))block;
@end
