#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (HWUtilView)
+ (void)HWShadowDraw:(UIView *)aim shadowColor:(UIColor *)color shadowOffset:(CGSize)size shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius;
@end
NS_ASSUME_NONNULL_END
