#import <UIKit/UIKit.h>
@class RACDelegateProxy;
@class RACSignal;
@interface UITextView (RACSignalSupport)
@property (nonatomic, strong, readonly) RACDelegateProxy *rac_delegateProxy;
- (RACSignal *)rac_textSignal;
@end
@interface UITextView (RACSignalSupportUnavailable)
- (RACSignal *)rac_signalForDelegateMethod:(SEL)method __attribute__((unavailable("Use -rac_signalForSelector:fromProtocol: instead")));
@end
