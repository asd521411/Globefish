#import <UIKit/UIKit.h>
@class RACSignal;
@interface UIGestureRecognizer (RACSignalSupport)
- (RACSignal *)rac_gestureSignal;
@end
