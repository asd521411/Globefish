#import "PersonalSetViewController.h"
@interface PersonalSetViewController ()
@end
@implementation PersonalSetViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self popSuperView];
}

- (void)setupSubViews {
    UIButton *exit = [UIButton buttonWithType:UIButtonTypeCustom];
    exit.frame = CGRectMake(95, [HWStyle navigationbarHeight] + 100, KSCREEN_WIDTH - 95 * 2, 44);
    exit.layer.cornerRadius = 22;
    exit.layer.masksToBounds = YES;
    [self.view addSubview:exit];
    [exit setTitle:@"退出登录" forState:UIControlStateNormal];
    [HWUtil gradientLayer:exit startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [exit addTarget:self action:@selector(exitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)exitBtnAction:(UIButton *)send {
    [NSUserDefaultMemory defaultSetMemory:@"" unityKey:USERID];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
