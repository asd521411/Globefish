#import "WorkInviteController.h"
@implementation WorkInviteController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}
@end
