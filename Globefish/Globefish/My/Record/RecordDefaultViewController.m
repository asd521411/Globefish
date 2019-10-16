#import "RecordDefaultViewController.h"
#import "GFCTableViewController.h"
#import "LimitOneTableViewController.h"
#import "LimitTwoTableViewController.h"
#import "LimitThreeTableViewController.h"
#import "LimitFourTableViewController.h"
#import "LimitFiveTableViewController.h"
#import "MJRefresh.h"
@interface RecordDefaultViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LimitOneTableViewController *tableViewController1;
@property (nonatomic, strong) LimitTwoTableViewController *tableViewController2;
@property (nonatomic, strong) LimitThreeTableViewController *tableViewController3;
@property (nonatomic, strong) LimitFourTableViewController *tableViewController4;
@property (nonatomic, strong) LimitFiveTableViewController *tableViewController5;
@property (nonatomic, strong) NSMutableArray *parametersArr;
@end
@implementation RecordDefaultViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)setupSubViews {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.items];
    self.segmentedControl.frame = CGRectMake(0, [HWStyle navigationbarHeight], SCREENWIDTH, 40);
    self.segmentedControl.selectedSegmentIndex = self.typeInteger;
    [self.view addSubview:self.segmentedControl];
    self.segmentedControl.tintColor = [UIColor clearColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KFontNormalSize12,
                         NSFontAttributeName, KColor_212121, NSForegroundColorAttributeName, nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:KFontNormalSize14, NSFontAttributeName, KColorMain_FF4457, NSForegroundColorAttributeName, nil];
    [self.segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.bottom, SCREENWIDTH, SCREENHEIGHT - [HWStyle navigationbarHeight] - self.segmentedControl.height - [HWStyle tabbarExtensionHeight])];
    self.scrollView.backgroundColor = [HWRandomColor randomColor];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * self.items.count, SCREENHEIGHT - [HWStyle navigationbarHeight] - self.segmentedControl.height);
    self.tableViewController1 = [[LimitOneTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController1.view.frame = CGRectMake(0, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController1.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController1.view];
    self.tableViewController2 = [[LimitTwoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController2.view.frame = CGRectMake(KSCREEN_WIDTH, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController2.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController2.view];
    self.tableViewController3 = [[LimitThreeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController3.view.frame = CGRectMake(KSCREEN_WIDTH * 2, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController3.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController3.view];
    self.tableViewController4 = [[LimitFourTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController4.view.frame = CGRectMake(KSCREEN_WIDTH * 3, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController3.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController4.view];
    self.tableViewController5 = [[LimitFiveTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController5.view.frame = CGRectMake(KSCREEN_WIDTH * 4, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController5.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController5.view];
}
#pragma action
- (void)segmentedControlAction:(UISegmentedControl *)segment {
    self.scrollView.contentOffset = CGPointMake(SCREENWIDTH * segment.selectedSegmentIndex, 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollView == scrollView) {
        self.segmentedControl.selectedSegmentIndex = self.scrollView.contentOffset.x / SCREENWIDTH;
    }
}
- (NSMutableArray *)parametersArr {
    if (!_parametersArr) {
        _parametersArr = [[NSMutableArray alloc] initWithObjects:@"看过我", @"我看过", @"已申请", @"待面试", @"收藏", nil];
    }
    return _parametersArr;
}
- (NSArray *)items {
    if (!_items) {
        _items = @[@"看过我", @"我看过", @"已申请", @"待面试", @"收藏"];;
    }
    return _items;
}
@end
