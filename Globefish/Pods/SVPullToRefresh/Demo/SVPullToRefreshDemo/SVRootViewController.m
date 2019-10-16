#import "SVRootViewController.h"
#import "SVViewController.h"
@interface SVRootViewController ()
@end
@implementation SVRootViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)showTableView:(id)sender
{
    [self.navigationController pushViewController:[[SVViewController alloc] initWithNibName:@"SVViewController" bundle:nil] animated:YES];
}
@end
