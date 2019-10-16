#import "GFCViewController.h"
#import "CommonTableViewCell.h"
#import "GFCDetailsViewController.h"
#import "CommonModel.h"
#import "HWAFNetworkManager.h"
@interface GFCViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *commonTableV;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) BOOL upOrDown;
@end
@implementation GFCViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    [self setupSubViews];
    [self tableViewRefresh];
    [self.commonTableV.mj_header beginRefreshing];
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
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.commonTableV.mj_header endRefreshing];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.commonTableV.mj_header endRefreshing];
    [self.commonTableV.mj_footer endRefreshing];
}
- (void)setupSubViews {
    self.commonTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, [HWStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.commonTableV.delegate = self;
    self.commonTableV.dataSource = self;
    self.commonTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.commonTableV];
    [self.commonTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
}
- (void)tableViewRefresh {
    self.commonTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDown = YES;
        [self loadData];
    }];
    self.commonTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.upOrDown = NO;
        [self loadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listArr.count == 0) {
        return 1;
    }
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArr.count > 0) {
        CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
        cell.commonModel = self.listArr[indexPath.row];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.textLabel.text = @"无数据";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GFCDetailsViewController *detail = [[GFCDetailsViewController alloc] init];
    CommonModel *model = self.listArr[indexPath.row];
    detail.positionid = model.positionid;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)loadData {
    NSDictionary *para = @{@"positionStatus":![HWUtil isBlankString:self.titleStr]?self.titleStr:@""};
    [[HWAFNetworkManager shareManager] position:para postion:^(BOOL success, id  _Nonnull request) {
        NSArray *arr = request;
        if (success) {
            if (self.upOrDown == YES) {
                [self.listArr removeAllObjects];
                self.listArr = [CommonModel mj_objectArrayWithKeyValuesArray:arr];
                [self.commonTableV reloadData];
            }else {
            }
            [self.commonTableV.mj_header endRefreshing];
            [self.commonTableV.mj_footer endRefreshing];
        }
        [self.commonTableV.mj_header endRefreshing];
        [self.commonTableV.mj_footer endRefreshing];
    }];
}
- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}
@end
