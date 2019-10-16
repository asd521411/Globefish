#import "RACSignal.h"
@interface RACDynamicSignal : RACSignal
+ (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe;
@end
