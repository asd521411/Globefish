#import <Foundation/Foundation.h>
#import "RACSubscriber.h"
@class RACCompoundDisposable;
@class RACSignal;
@interface RACPassthroughSubscriber : NSObject <RACSubscriber>
- (instancetype)initWithSubscriber:(id<RACSubscriber>)subscriber signal:(RACSignal *)signal disposable:(RACCompoundDisposable *)disposable;
@end
