#import "GFCTableViewController.h"
#import "commonTableViewCell.h"
#import "MJRefresh.h"
#import "CommonModel.h"
#import "NSUserDefaultMemory.h"
#import "HWAFNetworkManager.h"
@interface GFCTableViewController ()
@property (nonatomic, strong) NSMutableArray *listArr;
@end
@implementation GFCTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
    [self tableViewRefresh];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)tableViewRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
    }];
}
- (void)loadData {
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"userid":[HWUtil isBlankString:userid]?@"":userid, @"selectPayType":@"看过我"};
    [[HWAFNetworkManager shareManager] userLimitPositionRequest:para userPosition:^(BOOL success, id  _Nonnull request) {
        if (success) {
            [self.tableView reloadData];
        }
    }];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    cell.tagImgV.image = [UIImage imageNamed:@""];
    cell.titleLab.text = @"大望路服务员收银员";
    cell.locationLab.text = @"朝阳";
    cell.accountStyleLab.text = @"月结";
    cell.princeLab.text = @"180/天";
    cell.tagLab.text = @"可长期";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3"]];
    }
    return _listArr;
}
@end
