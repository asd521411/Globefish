#import "RACSubscriber.h"
@interface RACSubscriber : NSObject <RACSubscriber>
+ (instancetype)subscriberWithNext:(void (^)(id x))next error:(void (^)(NSError *error))error completed:(void (^)(void))completed;
@end
