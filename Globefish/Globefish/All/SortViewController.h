#import <UIKit/UIKit.h>
typedef void(^currentSelectItemTitle)(NSString *title);
@interface SortViewController : UIViewController
@property (nonatomic, copy) currentSelectItemTitle currentSelectItemTitle;
@end
