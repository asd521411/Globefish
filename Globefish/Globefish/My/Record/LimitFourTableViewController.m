#import "LimitFourTableViewController.h"
#import "CommonTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "GFCDetailsViewController.h"
@interface LimitFourTableViewController ()
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) BOOL upOrDown;
@end
@implementation LimitFourTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
    [self tableViewRefresh];
}
#pragma mark - Table view data source
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView.mj_header endRefreshing];
}
- (void)tableViewRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDown = YES;
        [self loadData];
    }];
}
- (void)loadData {
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"userid":[HWUtil isBlankString:userid]?@"":userid, @"relationtype":@"待面试"};
    [[HWAFNetworkManager shareManager] userLimitPositionRequest:para userPosition:^(BOOL success, id  _Nonnull request) {
        if (success) {
            NSArray *dicArr = request;
            if (self.upOrDown) {
                [self.listArr removeAllObjects];
                self.listArr = [CommonModel mj_objectArrayWithKeyValuesArray:dicArr];
            }else {
                self.listArr = [CommonModel mj_objectArrayWithKeyValuesArray:dicArr];
            }
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    cell.commonModel = self.listArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}
@end
