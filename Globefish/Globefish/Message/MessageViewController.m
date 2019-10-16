#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageNotificationController.h"
#import "WorkInviteController.h"
#import "GFCustomerServiceController.h"
@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headBackV;
@property (nonatomic, strong) UIView *headV;
@property (nonatomic, strong) NSArray *styleArr;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *tableListMutArr;
@end
@implementation MessageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[@"head1", @"head2", @"head3"];
    for (int i = 0; i < arr.count; i++) {
        MessageModel *model = [[MessageModel alloc] init];
        model.headImg = arr[i];
        [self.tableListMutArr addObject:model];
    }
    [self setupSubViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)setupSubViews {
    [self.view addSubview:self.headBackV];
    [self.headBackV addSubview:self.headV];
    CGFloat w = (KSCREEN_WIDTH - 65 * 2 - 25 * 2) / 3;
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < self.styleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(25 + (i%3) * (w + 65), 15, w, w);
        [self.headV addSubview:btn];
        btn.adjustsImageWhenHighlighted = NO;
        btn.tag = 111 + i;
        [btn setBackgroundImage:[UIImage imageNamed:self.styleArr[i][@"img"]] forState:UIControlStateNormal];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            UIButton *btn = (UIButton *)x;
            UIViewController *vc = [[NSClassFromString(self.styleArr[btn.tag-111][@"vcName"]) alloc] init];
            [strongSelf.navigationController pushViewController:vc animated:YES];
        }];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(25 + (i%3) * (w + 65), btn.bottom, w, 20)];
        lab.font = KFontNormalSize12;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = self.styleArr[i][@"title"];
        [self.headV addSubview:lab];
    }
    [self.view addSubview:self.tableV];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableListMutArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"];
    if (self.tableListMutArr.count > indexPath.row) {
        cell.messageModel = self.tableListMutArr[indexPath.row];
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"最新消息";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
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
- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headBackV.bottom + 10, KSCREEN_WIDTH, KSCREEN_HEIGHT - [HWStyle navigationbarHeight] - self.headV.height - [HWStyle toolbarHeight]) style:UITableViewStyleGrouped];
        _tableV.backgroundColor = KColor_BackGround;
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableV.showsVerticalScrollIndicator = NO;
        [_tableV registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"MessageTableViewCell"];
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
- (NSArray *)styleArr {
    if (!_styleArr) {
        _styleArr = @[@{@"img":@"xiaoxitongzhi", @"title":@"消息通知", @"vcName":@"MessageNotificationController"}, @{@"img":@"gongzuoyaoyue", @"title":@"工作邀约", @"vcName":@"WorkInviteController"}, @{@"img":@"zaixiankefu", @"title":@"在线客服", @"vcName":@"CustomerServiceController"}];
    }
    return _styleArr;
}
@end
