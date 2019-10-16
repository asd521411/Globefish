#import <Foundation/Foundation.h>
@class RACSignal;
extern NSString * const RACSelectorSignalErrorDomain;
extern const NSInteger RACSelectorSignalErrorMethodSwizzlingRace;
@interface NSObject (RACSelectorSignal)
- (RACSignal *)rac_signalForSelector:(SEL)selector;
- (RACSignal *)rac_signalForSelector:(SEL)selector fromProtocol:(Protocol *)protocol;
@end
