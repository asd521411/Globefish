#import "RACSignal.h"
#import "RACSubscriber.h"
@interface RACSubject : RACSignal <RACSubscriber>
+ (instancetype)subject;
@end
