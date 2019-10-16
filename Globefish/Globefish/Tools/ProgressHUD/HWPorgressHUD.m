#import "HWPorgressHUD.h"
@implementation HWPorgressHUD
+ (void)HWHudShowStatus:(NSString *)status {
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:status];
    [SVProgressHUD dismissWithDelay:1];
}
@end
