#import <Foundation/Foundation.h>
@class RACSignal;
@interface RACDelegateProxy : NSObject
@property (nonatomic, unsafe_unretained) id rac_proxiedDelegate;
- (instancetype)initWithProtocol:(Protocol *)protocol;
- (RACSignal *)signalForSelector:(SEL)selector;
@end
