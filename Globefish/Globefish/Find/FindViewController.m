#import "FindViewController.h"
#import "GFCDetailsViewController.h"
#import "FastPositionTableViewCell.h"
#import "CommonModel.h"
#import "HotPositionTableViewCell.h"
#import "HWAFNetworkManager.h"
#import "CommonTableViewHeaderFooterView.h"
#import "CommonTableViewCell.h"
#import "GFTopWeekTableViewCell.h"
#import "GFCViewController.h"
@interface FindViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionTitleArr;
@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *hotweekPosition;
@property (nonatomic, strong) NSMutableArray *fastPosition;
@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) NSMutableArray *hotPosition;
@property (nonatomic, assign) BOOL upOrDown;
@property (nonatomic, assign) NSInteger colorCount;
@end
@implementation FindViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self tableViewRefresh];
    [self.tableView.mj_header beginRefreshing];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        self.upOrDown = NO;
        [self loadData];
    }];
}
- (void)loadData {
    [[HWAFNetworkManager shareManager] discover:@{} defaultFound:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            if (self.upOrDown) {
                [self.sectionArr removeAllObjects];
                [self.hotPosition removeAllObjects];
                [self.hotweekPosition removeAllObjects];
                [self.fastPosition removeAllObjects];
                self.hotPosition = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"hotPosition"]];
                [self.hotPosition addObjectsFromArray:self.hotPosition];
                [self.hotPosition addObjectsFromArray:self.hotPosition];
                self.hotweekPosition = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"hotweekPosition"]];
                self.fastPosition = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"fastPosition"]];
                [self.sectionArr addObject:self.hotPosition];
                [self.sectionArr addObject:self.fastPosition];
                [self.sectionArr addObject:self.hotweekPosition];
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
            }else {
            }
        }
    }];
    [self.tableView.mj_header endRefreshing];
}
- (void)setupSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = KColor_BackGround;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[CommonTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"CommonTableViewHeaderFooterView"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        if (self.fastPosition.count > 3) {
            return 3;
        }else {
            return self.fastPosition.count;
        }
    }else if (section == 2) {
        return 1;
    }else {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommonTableViewHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CommonTableViewHeaderFooterView"];
    head.titleLab.text = self.sectionTitleArr[section][@"title"];
    head.commonHeaderActionBlock = ^{
        GFCViewController *com = [[GFCViewController alloc] init];
        com.titleStr = self.sectionTitleArr[section][@"title"];
        [self.navigationController pushViewController:com animated:YES];
    };
    return head;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"无数据";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        HotPositionTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"HotPositionTableViewCell"];
        if (!cell1) {
            cell1 = [[HotPositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotPositionTableViewCell"];
        }
        cell1.cellArr = weakSelf.hotPosition;
        cell1.collectionDidSelectItemBlock = ^(CommonModel * _Nonnull common) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            GFCDetailsViewController *detail = [[GFCDetailsViewController alloc] init];
            detail.positionid = common.positionid;
            [strongSelf.navigationController pushViewController:detail animated:YES];
        };
        return cell1;
    }else if (indexPath.section == 1) {
        FastPositionTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"FastPositionTableViewCell"];
        if (!cell2) {
            cell2 = [[FastPositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FastPositionTableViewCell"];
        }
        if (self.fastPosition.count > indexPath.row) {
            cell2.commonModel = self.fastPosition[indexPath.row];
            cell2.backV2.image = [UIImage imageNamed:self.colorArr[indexPath.row]];
        }
        return cell2;
    }else if (indexPath.section == 2) {
        GFTopWeekTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"TopWeekTableViewCell"];
        if (!cell3) {
            cell3 = [[GFTopWeekTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TopWeekTableViewCell"];
        }
        if (self.hotweekPosition.count > indexPath.row) {
            cell3.commonModel = self.hotweekPosition[indexPath.row];
        }
        cell3.cellArr = self.hotweekPosition;
        return cell3;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 130;
    }else if (indexPath.section == 1) {
        return 84;
    }else {
        return 162;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        GFCDetailsViewController *detail = [[GFCDetailsViewController alloc] init];
        CommonModel *model = self.fastPosition[indexPath.row];
        detail.positionid = model.positionid;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (indexPath.section == 2) {
        GFCDetailsViewController *detail = [[GFCDetailsViewController alloc] init];
        CommonModel *model = self.hotweekPosition[indexPath.row];
        detail.positionid = model.positionid;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
- (NSMutableArray *)sectionArr {
    if (!_sectionArr) {
        _sectionArr = [[NSMutableArray alloc] init];
    }
    return _sectionArr;
}
- (NSMutableArray *)hotPosition {
    if (!_hotPosition) {
        _hotPosition = [[NSMutableArray alloc] init];
    }
    return _hotPosition;
}
- (NSArray *)colorArr {
    if (!_colorArr) {
        _colorArr = @[@"hongbao1", @"hongbao2", @"hongbao3"];
    }
    return _colorArr;
}
- (NSMutableArray *)hotweekPosition {
    if (!_hotweekPosition) {
        _hotweekPosition = [[NSMutableArray alloc] init];
    }
    return _hotweekPosition;
}
- (NSMutableArray *)fastPosition {
    if (!_fastPosition) {
        _fastPosition = [[NSMutableArray alloc] init];
    }
    return _fastPosition;
}
- (NSArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr = @[@{@"title":@"热门岗位"}, @{@"title":@"今日急聘"}, @{@"title":@"每周排行"}];
    }
    return _sectionTitleArr;
}
@end
