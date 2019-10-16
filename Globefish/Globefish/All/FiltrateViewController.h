#import "SuperViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^currentSelectItemTitle)(NSString *title);
@interface FiltrateViewController : SuperViewController
@property (nonatomic, copy) currentSelectItemTitle currentSelectItemTitle;
@end
NS_ASSUME_NONNULL_END
