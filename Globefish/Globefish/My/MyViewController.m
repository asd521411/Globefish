#import "MyViewController.h"
#import "NSUserDefaultMemory.h"
#import "ImgTitleView.h"
#import "HWAFNetworkManager.h"
#import "SSKeychain.h"
#import "GFLoginViewController.h"
#import "RecordDefaultViewController.h"
#import "GFLoginViewController.h"
#import "UserInfoModel.h"
#import "PersonInfoViewController.h"
@interface MyViewController ()<ImgTitleViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIView *headBackV;
@property (nonatomic, strong) UIView *headV;
@property (nonatomic, strong) NSArray *styleArr;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *personalizedLab;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UIView *itemBackView;
@property (nonatomic, strong) UIView *lowerBackView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) UserInfoModel *userInfoModel;
@end
@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self loginStatus]) {
        NSString *status = [NSString stringWithFormat:@"%@", [NSUserDefaultMemory defaultGetwithUnityKey:USERID]];
        [[HWAFNetworkManager shareManager] userInfo:@{@"userid":status} getUserInfo:^(BOOL success, id  _Nonnull request) {
            NSDictionary *dic = (NSDictionary *)request;
            if (success) {
                self.userInfoModel = [UserInfoModel mj_objectWithKeyValues:dic];
                if (![HWUtil isBlankString:self.userInfoModel.username]) {
                    self.userName.text = self.userInfoModel.username;
                }else {
                    self.userName.text = @"xxx";
                }
                if (![HWUtil isBlankString:self.userInfoModel.userprofile]) {
                    self.personalizedLab.text = self.userInfoModel.userprofile;
                }else {
                    self.personalizedLab.text = @"暂无个性签名";
                }
            }
        }];
    }else {
        self.userName.text = @"登陆";
        self.personalizedLab.text = @"暂无个性签名";
    }
}
- (BOOL)loginStatus {
    NSString *status = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    if ([HWUtil isBlankString:status]) {
        return NO;
    }else {
        return YES;
    }
}
- (void)setupSubViews {
    [self.view addSubview:self.backScrollV];
    [self.backScrollV addSubview:self.headBackV];
    [self.headBackV addSubview:self.headV];
    self.headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 28, 80, 80)];
    self.headImgV.image = [UIImage imageNamed:@"headplace"];
    self.headImgV.userInteractionEnabled = YES;
    self.headImgV.layer.cornerRadius = 40;
    self.headImgV.layer.masksToBounds = YES;
    [self.headV addSubview:self.headImgV];
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headBackViewAction:)];
    [self.headImgV addGestureRecognizer:headTap];
    CGFloat height = 20;
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.headImgV.right + 15, 30, 80, height)];
    self.userName.font = KFontNormalSize18;
    self.userName.text = @"立即登录";
    [self.headV addSubview:self.userName];
    self.personalizedLab = [[UILabel alloc] initWithFrame:CGRectMake(self.headImgV.right + 15, self.userName.bottom + 10, KSCREEN_WIDTH - 125, height)];
    self.personalizedLab.font = KFontNormalSize14;
    self.personalizedLab.text = @"      ";
    [self.headV addSubview:self.personalizedLab];
    UITapGestureRecognizer *loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topUnloginAction:)];
    [self.headV addGestureRecognizer:loginTap];
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(self.headImgV.right + 15, self.personalizedLab.bottom + 10, KSCREEN_WIDTH - 125, height)];
    lab3.font = KFontNormalSize14;
    NSArray *arr1 = @[@" ", @" ", @" "];
    NSString *text1 = [arr1 componentsJoinedByString:@"  "];
    lab3.text = text1;
    [self.headV addSubview:lab3];
    CGFloat width = (KSCREEN_WIDTH - 20 * 2 - 64 * 3) / 4;
    self.itemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackV.bottom + 30, KSCREEN_WIDTH - 30, width)];
    [self.backScrollV addSubview:self.itemBackView];
    NSArray *arr = @[@{@"img":@"fenlei",@"title":@"分类"},
                     @{@"img":@"yibaoming",@"title":@"已报名"},
                     @{@"img":@"yishanggang",@"title":@"已上岗"},
                     @{@"img":@"yiwancheng",@"title":@"已完成"}];
    for (NSInteger i = 0; i < arr.count; i++) {
        ImgTitleView *item = [[ImgTitleView alloc] initWithFrame:CGRectMake(20 + (i % 5) * (width + 65), 0, width, width)];
        item.topImgV.image = [UIImage imageNamed:arr[i][@"img"]];
        item.titleLab.text = arr[i][@"title"];
        item.maskBtn.tag = 1000 + i;
        item.delegate = self;
        [self.itemBackView addSubview:item];
        item.layer.cornerRadius = 2;
        item.layer.masksToBounds = YES;
    }
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(10, self.itemBackView.bottom + 10, KSCREEN_WIDTH - 20, 0.5)];
    line2.backgroundColor = KColor_Line_dfdfdf;
    [self.headImgV addSubview:line2];
    self.lowerBackView = [[UIView alloc] initWithFrame:CGRectMake(20, self.itemBackView.bottom + 20, KSCREEN_WIDTH - 20, 72)];
    UIBezierPath *pa = [UIBezierPath bezierPathWithRoundedRect:self.lowerBackView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(36, 36)];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = pa.bounds;
    shape.path = pa.CGPath;
    self.lowerBackView.layer.mask = shape;
    [self.backScrollV addSubview:self.lowerBackView];
    [HWUtil gradientLayer:self.lowerBackView startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:[HWUtil colorWithHexString:@"92ebfb"] colorArr2:[HWUtil colorWithHexString:@"59d3f5"] location1:0 location2:0];
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, KSCREEN_WIDTH / 2, 20)];
    lab4.textColor = [UIColor whiteColor];
    lab4.font = KFontNormalSize18;
    lab4.text = @"我的简历";
    [self.lowerBackView addSubview:lab4];
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(lab4.left, lab4.bottom + 10, KSCREEN_WIDTH - lab4.left, 14)];
    lab5.textColor = [UIColor whiteColor];
    lab5.font = KFontNormalSize12;
    lab5.text = @"完善简历 享受优先录取";
    [self.lowerBackView addSubview:lab5];
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBtn.frame = CGRectMake(self.lowerBackView.right - KSCREEN_WIDTH / 5 - 20, self.lowerBackView.height - 20, KSCREEN_WIDTH / 5, 20);
    goBtn.titleLabel.font = KFontNormalSize12;
    goBtn.layer.cornerRadius = 10;
    goBtn.layer.masksToBounds = YES;
    [self.lowerBackView addSubview:goBtn];
    [goBtn setTitle:@"去完善 >" forState:UIControlStateNormal];
    [goBtn setTintColor:[UIColor whiteColor]];
    goBtn.backgroundColor = [HWUtil colorWithHexString:@"59d3f5"];
    __weak typeof(self) weakSelf = self;
    [[goBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf loginStatus]) {
        }else {
        }
    }];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.lowerBackView.bottom + 10, KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 40;
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.backScrollV addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
#pragma mark target action
- (void)topUnloginAction:(UIGestureRecognizer *)tap {
    if ([self loginStatus]) {
        PersonInfoViewController *info = [[PersonInfoViewController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
    }else {
        GFLoginViewController *gf = [[GFLoginViewController alloc] init];
        [self.navigationController pushViewController:gf animated:YES];
    }
}
- (void)headBackViewAction:(UIButton *)send {
    if ([self loginStatus]) {
        PersonInfoViewController *info = [[PersonInfoViewController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
    }else {
        GFLoginViewController *gf = [[GFLoginViewController alloc] init];
        [self.navigationController pushViewController:gf animated:YES];
    }
}
- (void)lowerBackViewTap:(UIGestureRecognizer *)tap {
    if ([self loginStatus]) {
    }else {
    }
}
#pragma mark delegate
- (void)ImgTitleViewACtion:(NSInteger)index {
    if ([self loginStatus]) {
        RecordDefaultViewController *record = [[RecordDefaultViewController alloc] init];
        record.hidesBottomBarWhenPushed = YES;
        record.typeInteger = index - 1000;
        [self.navigationController pushViewController:record animated:YES];
    }else {
        GFLoginViewController *login = [[GFLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.listArr[indexPath.row][@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = KFontNormalSize14;
    cell.imageView.image = [UIImage imageNamed:self.listArr[indexPath.row][@"img"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[NSClassFromString(self.listArr[indexPath.row][@"vcname"]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UIScrollView *)backScrollV {
    if (!_backScrollV) {
        _backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [HWStyle navigationbarHeight] + 20)];
        _backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
        if (@available(iOS 11.0, *)) {
            _backScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _backScrollV;
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
- (NSArray *)styleArr {
    if (!_styleArr) {
        _styleArr = @[@{@"img":@"xiaoxitongzhi", @"title":@"消息通知", @"vcName":@"MessageNotificationController"}, @{@"img":@"gongzuoyaoyue", @"title":@"工作邀约", @"vcName":@"WorkInviteController"}, @{@"img":@"zaixiankefu", @"title":@"在线客服", @"vcName":@"CustomerServiceController"}];
    }
    return _styleArr;
}
- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@{@"img":@"wodeshoucang",@"title":@"我的收藏", @"vcname":@"CollectViewController"},
                     @{@"img":@"shangwuhezuo",@"title":@"商务合作", @"vcname":@"CooperationViewController"},
                     @{@"img":@"yijianfankui",@"title":@"意见反馈", @"vcname":@"FeedbackViewController"},
                     @{@"img":@"guanyuwomen",@"title":@"关于我们", @"vcname":@"AboutUSViewController"},
                     @{@"img":@"gerenshezhi", @"title":@"个人设置", @"vcname":@"PersonalSetViewController"}];
    }
    return _listArr;
}
@end
