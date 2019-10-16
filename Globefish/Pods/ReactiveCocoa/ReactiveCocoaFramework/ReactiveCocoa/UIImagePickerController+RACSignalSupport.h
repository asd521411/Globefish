#import <UIKit/UIKit.h>
@class RACDelegateProxy;
@class RACSignal;
@interface UIImagePickerController (RACSignalSupport)
@property (nonatomic, strong, readonly) RACDelegateProxy *rac_delegateProxy;
- (RACSignal *)rac_imageSelectedSignal;
@end
