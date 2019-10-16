#import "CollectViewController.h"
@interface CollectViewController ()
@end
@implementation CollectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self popSuperView];
}
@end
