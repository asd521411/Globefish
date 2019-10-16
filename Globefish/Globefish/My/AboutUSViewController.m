#import "AboutUSViewController.h"
@interface AboutUSViewController ()
@end
@implementation AboutUSViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self popSuperView];
}
@end
