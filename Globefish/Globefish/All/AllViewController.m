#import "AllViewController.h"
#import "StyleCollectionViewCell.h"
#import "GFCViewController.h"
#import "CommonModel.h"
#import "CommonTableViewCell.h"
#import "HWAFNetworkManager.h"
#import "TitleSelectItemControl.h"
#import "SortViewController.h"
#import "FiltrateViewController.h"
#import "TypeSelectViewController.h"
#import "GFCDetailsViewController.h"
#import "UIView+HWUtilView.h"
@interface AllViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *headBackV;
@property (nonatomic, strong) UIView *headV;
@property (nonatomic, strong) NSArray *styleArr;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIView *titleSelectItemBackView;
@property (nonatomic, strong) TitleSelectItemControl *titleSelect1;
@property (nonatomic, strong) TitleSelectItemControl *titleSelect2;
@property (nonatomic, strong) TitleSelectItemControl *titleSelect3;
@property (nonatomic, strong) UIView *blackBackGroundView1;
@property (nonatomic, strong) UIView *blackBackGroundView2;
@property (nonatomic, strong) UIView *blackBackGroundView3;
@property (nonatomic, strong) SortViewController *sortViewController;
@property (nonatomic, strong) FiltrateViewController *filtrateViewController;
@property (nonatomic, strong) TypeSelectViewController *typeSelectViewController;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *tableListMutArr;
@property (nonatomic, assign) BOOL upOrDownRefresh;
@end
@implementation AllViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self refreshTablev];
     [self.tableV.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//           [self.tableV.mj_header beginRefreshing];
//        });
//    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableV.mj_header endRefreshing];
}
- (void)refreshTablev {
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDownRefresh = YES;
        [self loadData];
    }];
//    self.tableV.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//        self.upOrDownRefresh = NO;
//        [self loadData];
//    }];
}
- (void)loadData {
//    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
        [[HWAFNetworkManager shareManager] position:@{} postion:^(BOOL success, id  _Nonnull request) {
            NSArray *arr = (NSArray *)request;
            if (success) {
                if (self.upOrDownRefresh) {
                    [self.tableListMutArr removeAllObjects];
                    [SVProgressHUD showWithStatus:@"加载中..."];
                    [SVProgressHUD dismissWithDelay:1];
                    self.tableListMutArr = [CommonModel mj_objectArrayWithKeyValuesArray:arr];
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.tableV reloadData];
//                        });
//                    });
                }else {
                }
                [self.tableV.mj_header endRefreshing];
                [self.tableV.mj_footer endRefreshing];
                [self.tableV reloadData];
            }
            [self.tableV.mj_header endRefreshing];
            [self.tableV.mj_footer endRefreshing];
        }];
//    });
    
}
- (void)setupSubViews {
    [self.view addSubview:self.headBackV];
    [self.headBackV addSubview:self.headV];
    [self.headV addSubview:self.collectionV];
    
//    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headBackV.bottom + 10, KSCREEN_WIDTH, KSCREEN_HEIGHT - [HWStyle navigationbarHeight] - self.headV.height - [HWStyle toolbarHeight]) style:UITableViewStylePlain];
//    _tableV.backgroundColor = KColor_BackGround;
//    _tableV.delegate = self;
//    _tableV.dataSource = self;
//    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableV.showsVerticalScrollIndicator = NO;
//    [_tableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
//    if (@available(iOS 11.0, *)) {
//        _tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
    [self.view addSubview:self.tableV];
    double w = (KSCREEN_WIDTH - 30 - 70*2) / 3;
    double h = 40;
    self.titleSelectItemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectionV.bottom + 10, KSCREEN_WIDTH, h)];
    [self.headV addSubview:self.titleSelectItemBackView];
    _titleSelect1 = [[TitleSelectItemControl alloc] initWithFrame:CGRectMake(15, 0, w, h) title:self.titleArray[0] imageName:@"btn_close_search" selectImage:@"btn_open_search"];
    [_titleSelect1 addTarget:self action:@selector(titleSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleSelectItemBackView addSubview:_titleSelect1];
    _titleSelect2 = [[TitleSelectItemControl alloc] initWithFrame:CGRectMake(_titleSelect1.right + w, 0, w, h) title:self.titleArray[1] imageName:@"btn_close_search" selectImage:@"btn_open_search"];
    [_titleSelect2 addTarget:self action:@selector(titleSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleSelectItemBackView addSubview:_titleSelect2];
    _titleSelect3 = [[TitleSelectItemControl alloc] initWithFrame:CGRectMake(_titleSelect2.right + w, 0, w, h) title:self.titleArray[2] imageName:@"btn_close_search" selectImage:@"btn_open_search"];
    [_titleSelect3 addTarget:self action:@selector(titleSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleSelectItemBackView addSubview:_titleSelect3];
    self.blackBackGroundView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackV.bottom, self.view.width, self.view.height - 44)];
    self.blackBackGroundView1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView1.hidden = YES;
    [self.view addSubview:self.blackBackGroundView1];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView1tap:)];
    tap1.delegate = self;
    [self.blackBackGroundView1 addGestureRecognizer:tap1];
    self.filtrateViewController = [[FiltrateViewController alloc] init];
    self.filtrateViewController.view.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 152);
    [self addChildViewController:self.filtrateViewController];
    [self.blackBackGroundView1 addSubview:self.filtrateViewController.view];
    __weak typeof(self) weakSelf = self;
    self.filtrateViewController.currentSelectItemTitle = ^(NSString *titleName1) {
        weakSelf.titleSelect1.selected = NO;
        weakSelf.blackBackGroundView1.hidden = YES;
        [weakSelf.tableV.mj_header beginRefreshing];
    };
    self.blackBackGroundView2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackV.bottom, self.view.width, self.view.height - 44)];
    self.blackBackGroundView2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView2.hidden = YES;
    [self.view addSubview:self.blackBackGroundView2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView2tap:)];
    tap2.delegate = self;
    [self.blackBackGroundView2 addGestureRecognizer:tap2];
    self.sortViewController = [[SortViewController alloc] init];
    self.sortViewController.view.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 44 * 3);
    [self addChildViewController:self.sortViewController];
    [self.blackBackGroundView2 addSubview:self.sortViewController.view];
    self.sortViewController.currentSelectItemTitle = ^(NSString *title) {
        weakSelf.titleSelect2.selected = NO;
        weakSelf.blackBackGroundView2.hidden = YES;
        [weakSelf.tableV.mj_header beginRefreshing];
    };
    self.blackBackGroundView3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackV.bottom, self.view.width, self.view.height - 44)];
    self.blackBackGroundView3.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView3.hidden = YES;
    [self.view addSubview:self.blackBackGroundView3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView3tap:)];
    tap3.delegate = self;
    [self.blackBackGroundView3 addGestureRecognizer:tap3];
    self.typeSelectViewController = [[TypeSelectViewController alloc] init];
    self.typeSelectViewController.view.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 200);
    [self addChildViewController:self.typeSelectViewController];
    [self.blackBackGroundView3 addSubview:self.typeSelectViewController.view];
    self.typeSelectViewController.typeSelectBlock = ^(NSString * _Nonnull str) {
        weakSelf.titleSelect3.selected = NO;
        weakSelf.blackBackGroundView3.hidden = YES;
        [weakSelf.tableV.mj_header beginRefreshing];
    };
}
#pragma mark
- (void)titleSelectBtn:(UIControl *)sender {
    self.headBackV.backgroundColor = [UIColor whiteColor];
    BOOL selected = !sender.selected;
    self.titleSelect1.selected = NO;
    self.titleSelect2.selected = NO;
    self.titleSelect3.selected = NO;
    self.blackBackGroundView1.hidden = YES;
    self.blackBackGroundView2.hidden = YES;
    self.blackBackGroundView3.hidden = YES;
    sender.selected = selected;
    if (sender == _titleSelect1) {
        self.blackBackGroundView1.hidden = !selected;
    } else if (sender == _titleSelect2) {
        self.blackBackGroundView2.hidden = !selected;
    } else if (sender == _titleSelect3) {
        self.blackBackGroundView3.hidden = !selected;
    }
}
- (void)blackBackGroundView1tap:(UITapGestureRecognizer *)tap {
    self.titleSelect1.selected = NO;
    self.blackBackGroundView1.hidden = YES;
    self.headBackV.backgroundColor = KColor_BackGround;
}
- (void)blackBackGroundView2tap:(UITapGestureRecognizer *)tap {
    self.titleSelect2.selected = NO;
    self.blackBackGroundView2.hidden = YES;
    self.headBackV.backgroundColor = KColor_BackGround;
}
- (void)blackBackGroundView3tap:(UITapGestureRecognizer *)tap {
    self.titleSelect3.selected = NO;
    self.blackBackGroundView3.hidden = YES;
    self.headBackV.backgroundColor = KColor_BackGround;
}
#pragma mark UICollectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.styleArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StyleCollectionViewCell" forIndexPath:indexPath];
    cell.styleImgV.image = [UIImage imageNamed:self.styleArr[indexPath.row][@"img"]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GFCViewController *common = [[GFCViewController alloc] init];
    common.titleStr = self.styleArr[indexPath.row][@"title"];
    [self.navigationController pushViewController:common animated:YES];
}
#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableListMutArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    cell.commonModel = self.tableListMutArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GFCDetailsViewController *detail = [[GFCDetailsViewController alloc] init];
    CommonModel *model = self.tableListMutArr[indexPath.row];
    detail.positionid = model.positionid;
    [self.navigationController pushViewController:detail animated:YES];
}
- (UIView *)headBackV {
    if (!_headBackV) {
        _headBackV = [[UIView alloc] initWithFrame:CGRectMake(0, [HWStyle navigationbarHeight], KSCREEN_WIDTH, 123)];
        _headBackV.backgroundColor = KColor_BackGround;
        UIBezierPath *pa = [UIBezierPath bezierPathWithRoundedRect:_headBackV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(34, 34)];
        CALayer *la = [CALayer layer];
        la.shadowColor = [HWUtil colorWithHexString:@"59d3f5"].CGColor;
        la.shadowOffset = CGSizeMake(0, 5);
        la.shadowOpacity = 0.3;
        la.shadowRadius = 5;
        la.shadowPath = pa.CGPath;
        [_headBackV.layer addSublayer:la];
    }
    return _headBackV;
}
- (UIView *)headV {
    if (!_headV) {
        _headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 123)];
        _headV.backgroundColor = [UIColor whiteColor];
         UIBezierPath *pa = [UIBezierPath bezierPathWithRoundedRect:_headV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(34, 34)];
        CAShapeLayer *lay = [CAShapeLayer layer];
        lay.frame = pa.bounds;
        lay.path = pa.CGPath;
        _headV.layer.mask = lay;
    }
    return _headV;
}
- (UICollectionView *)collectionV {
    if (!_collectionV) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(100, 50);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumInteritemSpacing = 10;
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 15, KSCREEN_WIDTH - 30, 50) collectionViewLayout:flow];
        _collectionV.backgroundColor = [UIColor whiteColor];
        _collectionV.contentSize = CGSizeMake(KSCREEN_WIDTH - 30, 50);
        _collectionV.pagingEnabled = NO;
        _collectionV.showsHorizontalScrollIndicator = NO;
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        [_collectionV registerClass:[StyleCollectionViewCell class] forCellWithReuseIdentifier:@"StyleCollectionViewCell"];
    }
    return _collectionV;
}
- (NSArray *)styleArr {
    if (!_styleArr) {
        _styleArr = @[@{@"img":@"itemselect1", @"title":@"最新发布"}, @{@"img":@"itemselect2", @"title":@"宅家赚钱"}, @{@"img":@"itemselect3", @"title":@"薪资最高"}, @{@"img":@"itemselect4", @"title":@"完工结算"}, @{@"img":@"itemselect1", @"title":@"最新发布"}, @{@"img":@"itemselect2", @"title":@"宅家赚钱"}, @{@"img":@"itemselect3", @"title":@"薪资最高"}, @{@"img":@"itemselect4", @"title":@"完工结算"}];
    }
    return _styleArr;
}
- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headBackV.bottom + 10, KSCREEN_WIDTH, KSCREEN_HEIGHT - [HWStyle navigationbarHeight] - self.headV.height - [HWStyle toolbarHeight]) style:UITableViewStylePlain];
        _tableV.backgroundColor = KColor_BackGround;
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableV.showsVerticalScrollIndicator = NO;
        [_tableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
        if (@available(iOS 11.0, *)) {
            _tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableV;
};
- (NSMutableArray *)tableListMutArr {
    if (!_tableListMutArr) {
        _tableListMutArr = [[NSMutableArray alloc] init];
    }
    return _tableListMutArr;
}
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"全部兼职", @"默认排序", @"筛选"];
    }
    return _titleArray;
}
@end
