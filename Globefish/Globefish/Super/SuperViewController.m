#import "SuperViewController.h"
@interface SuperViewController ()
@end
@implementation SuperViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColor_BackGround;
}
- (void)popSuperView {
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}
@end
