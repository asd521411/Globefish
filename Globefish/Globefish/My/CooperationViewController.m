#import "CooperationViewController.h"
@interface CooperationViewController ()
@end
@implementation CooperationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self popSuperView];
}
@end
