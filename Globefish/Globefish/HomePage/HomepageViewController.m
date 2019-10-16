#import "HomepageViewController.h"
#import "SDCycleScrollView.h"
#import "CommonTableViewCell.h"
#import "HWAFNetworkManager.h"
#import "CommonModel.h"
#import "CommonImgModel.h"
#import "GFCDetailsViewController.h"
#import "GFCViewController.h"
@interface HomepageViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIView *headV;
@property (nonatomic, strong) SDCycleScrollView *bannerScroV;
@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *tableVMutArr;
@property (nonatomic, assign) BOOL upOrDownMark;
@property (nonatomic, strong) NSMutableArray *imgUrlArr;
@end
@implementation HomepageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self refreshData];
    [self.tableV.mj_header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableV.mj_header endRefreshing];
}
- (void)refreshData {
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDownMark = YES;
        [self loadData];
    }];
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.upOrDownMark = NO;
        [self loadData];
    }];
}
- (void)loadData {
    NSDictionary *para = @{@"positionStatus":@"推荐"};
    [[HWAFNetworkManager shareManager] position:para postion:^(BOOL success, id  _Nonnull request) {
        NSArray *arr = (NSArray *)request;
        if (success) {
            if (self.upOrDownMark) {
                [self.tableVMutArr removeAllObjects];
                self.tableVMutArr = [CommonModel mj_objectArrayWithKeyValuesArray:arr];
                [self.tableV reloadData];
            }else {
            }
        }
        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
    }];
    [[HWAFNetworkManager shareManager] commonAcquireImg:@{@"imgtype":@"首页"} firstImg:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            if (self.upOrDownMark) {
                self.imgUrlArr = [CommonImgModel mj_objectArrayWithKeyValuesArray:dic[@"img"]];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (CommonImgModel *img in self.imgUrlArr) {
                    [arr addObject:img.imgpath];
                }
                self.bannerScroV.imageURLStringsGroup = arr;
            }
        };
        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
    }];
}
- (void)setupSubViews {
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 321)];
    [self.view addSubview:self.headV];
    self.bannerScroV = [[SDCycleScrollView alloc] init];
    self.bannerScroV.delegate = self;
    [self.headV addSubview:self.bannerScroV];
    CGFloat banW = KSCREEN_WIDTH - 30;
    CGFloat banH = banW / 690 * 210;
    [self.bannerScroV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(banH);
    }];
    self.bannerScroV.layer.cornerRadius = 15;
    self.bannerScroV.layer.masksToBounds = YES;
    [self.bannerScroV.superview layoutIfNeeded];
    CGFloat itemW = (KSCREEN_WIDTH - 15 * 4) / 3;
    CGFloat itemH = itemW / 210 * 220;
    for (int i = 0; i < self.itemArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15 + (i % 3) * (itemW + 15), self.bannerScroV.bottom + 10, itemW, itemH);
        [self.headV addSubview:btn];
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;
        btn.tag = 888 + i;
        btn.adjustsImageWhenHighlighted = NO;
        [btn setBackgroundImage:[UIImage imageNamed:self.itemArr[i][@"imgName"]] forState:UIControlStateNormal];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            UIButton *btn = (UIButton *)x;
            GFCViewController *common = [[GFCViewController alloc] init];
            common.titleStr = self.itemArr[btn.tag-888][@"title"];
            [self.navigationController pushViewController:common animated:YES];
        }];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.bannerScroV.bottom + 10 + itemH + 10, KSCREEN_WIDTH - 30, 20)];
    lab.textColor = KColor_Font_2f2f2f;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = @"推荐岗位";
    lab.font = [UIFont boldSystemFontOfSize:18];
    [self.headV addSubview:lab];
    self.headV.height = 10 + banH + 10 + itemH + 10 + 20 + 10;
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, [HWStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [HWStyle navigationbarHeight]) style:UITableViewStylePlain];
    self.tableV.backgroundColor = KColor_BackGround;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableV];
    self.tableV.tableHeaderView = self.headV;
    [self.tableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
    if (@available(iOS 11.0, *)) {
        self.tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
#pragma mark delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    GFCDetailsViewController *detail = [[GFCDetailsViewController alloc] init];
    CommonModel *model = self.imgUrlArr[index];
    detail.positionid = model.positionid;
    [self.navigationController pushViewController:detail animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableVMutArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    if (self.tableVMutArr.count > indexPath.row) {
        cell.commonModel = self.tableVMutArr[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GFCDetailsViewController *detail = [[GFCDetailsViewController alloc] init];
    CommonModel *model = self.tableVMutArr[indexPath.row];
    detail.positionid = model.positionid;
    [self.navigationController pushViewController:detail animated:YES];
}
- (NSMutableArray *)imgUrlArr {
    if (!_imgUrlArr) {
        _imgUrlArr = [[NSMutableArray alloc] init];
    }
    return _imgUrlArr;
}
- (NSArray *)itemArr {
    if (!_itemArr) {
        _itemArr = @[@{@"title":@"认证专区", @"imgName":@"renzhengzhuanqu"},
                     @{@"title":@"高薪招聘", @"imgName":@"gaoxinzhaopin"},
                     @{@"title":@"当日结算", @"imgName":@"dangrijiesuan"}];
    }
    return _itemArr;
}
- (NSMutableArray *)tableVMutArr {
    if (!_tableVMutArr) {
        _tableVMutArr = [[NSMutableArray alloc] init];
    }
    return _tableVMutArr;
}
@end
