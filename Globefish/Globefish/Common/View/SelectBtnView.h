#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectBtnActionBlock)(NSString *btnTitle);
@interface SelectBtnView : UIView
@property (nonatomic, copy) SelectBtnActionBlock  selectBtnActionBlock;
- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString *)title itemStyle:(NSArray *)itemArr;
@end
NS_ASSUME_NONNULL_END
