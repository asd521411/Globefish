#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (YYText)
@property (nullable, nonatomic, readonly) UIViewController *yy_viewController;
@property (nonatomic, readonly) CGFloat yy_visibleAlpha;
- (CGPoint)yy_convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view;
- (CGPoint)yy_convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view;
- (CGRect)yy_convertRect:(CGRect)rect toViewOrWindow:(UIView *)view;
- (CGRect)yy_convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view;
@end
NS_ASSUME_NONNULL_END
