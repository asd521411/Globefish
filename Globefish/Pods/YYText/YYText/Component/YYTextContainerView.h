#import <UIKit/UIKit.h>
#if __has_include(<YYText/YYText.h>)
#import <YYText/YYTextLayout.h>
#else
#import "YYTextLayout.h"
#endif
NS_ASSUME_NONNULL_BEGIN
@interface YYTextContainerView : UIView
@property (nullable, nonatomic, weak) UIView *hostView;
@property (nullable, nonatomic, copy) YYTextDebugOption *debugOption;
@property (nonatomic) YYTextVerticalAlignment textVerticalAlignment;
@property (nullable, nonatomic, strong) YYTextLayout *layout;
@property (nonatomic) NSTimeInterval contentsFadeDuration;
- (void)setLayout:(nullable YYTextLayout *)layout withFadeDuration:(NSTimeInterval)fadeDuration;
@end
NS_ASSUME_NONNULL_END
