#import "FeedbackViewController.h"
@interface FeedbackViewController ()
@end
@implementation FeedbackViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self popSuperView];
}
@end
