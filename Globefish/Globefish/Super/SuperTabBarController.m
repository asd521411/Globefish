#import "SuperTabBarController.h"
#import "SuperNavigationController.h"
#import "HomepageViewController.h"
@interface SuperTabBarController ()
@property (nonatomic, strong) NSArray *controllerArr;
@end
@implementation SuperTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColor_BackGround;
    NSMutableArray *naArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.controllerArr.count; i++) {
        UIViewController *vc = [[NSClassFromString(self.controllerArr[i][@"vcName"]) alloc] init];
        SuperNavigationController *na = [[SuperNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = [[UITabBarItem alloc] init];
        item.title = self.controllerArr[i][@"title"];
        item.image = [[UIImage imageNamed:self.controllerArr[i][@"img"]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:self.controllerArr[i][@"imgsele"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[HWUtil colorWithHexString:@"a0a4b0"], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[HWUtil colorWithHexString:@"58d3f5"], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        na.tabBarItem = item;
        [naArr addObject:na];
    }
    [self setViewControllers:naArr];
}
- (NSArray *)controllerArr {
    if (!_controllerArr) {
        _controllerArr = @[@{@"img":@"tab1",
                             @"imgsele":@"tabsel1",
                             @"title":@"首页",
                             @"vcName":@"HomepageViewController"},
                           @{@"img":@"tab2",
                             @"imgsele":@"tabsel2",
                             @"title":@"发现",
                             @"vcName":@"FindViewController"},
                           @{@"img":@"tab3",
                             @"imgsele":@"tabsel3",
                             @"title":@"全部",
                             @"vcName":@"AllViewController"},
                           @{@"img":@"tab4",
                             @"imgsele":@"tabsel4",
                             @"title":@"消息",
                             @"vcName":@"MessageViewController"},
                           @{@"img":@"tab5",
                             @"imgsele":@"tabsel5",
                             @"title":@"我的",
                             @"vcName":@"MyViewController"}];
    }
    return _controllerArr;
}
@end
