#import "GFCDetailsViewController.h"
#import "ReactiveCocoa.h"
#import "CommonModel.h"
#import "GFComDetailsTableViewCell.h"
#import "MJExtension.h"
#import "CommontTopTableViewCell.h"
#import "CommonTableViewCell.h"
#import "MJRefresh.h"
#import "HWAFNetworkManager.h"
#import "UITextField+RACSignalSupportHw.h"
#import "UIView+MJExtensionHw.h"
#import "UITextView+RACSignalSupportHw.h"
@interface GFCDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, copy) NSString *text2;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CommonModel *commonModel;
@property (nonatomic, strong) NSArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) BOOL upOrDown;
@property (nonatomic, strong) NSMutableArray *otherRecommendArr;
@property (nonatomic, strong) UIView *bottomBackV;
@property (nonatomic, strong) UILabel *connectType;
@property (nonatomic, strong) UILabel *connectNum;
@property (nonatomic, strong) UIView *maskBackV;
@end
#define KTableRowFixedWidth     KSCREEN_WIDTH - 100 - 15
@implementation GFCDetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableViews];
    [self tableViewRefresh];
    [self setupConnectViews];
    [self setupMaskViews];
    [self.tableView.mj_header beginRefreshing];
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
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)tableViewRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDown = YES;
        [self loadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.upOrDown = NO;
        [self loadData];
    }];
}
- (void)setupTableViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [HWStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [HWStyle navigationbarHeight] - [HWStyle toolbarHeight]) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 0.1)];
    self.tableView.tableHeaderView = head;
}
- (void)setupConnectViews {
    CGFloat height = 50;
}
- (void)sendDojob {
}
- (void)setupMaskViews {
    self.maskBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    self.maskBackV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.maskBackV.hidden = YES;
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    [win addSubview:self.maskBackV];
    CGFloat wid = KSCREEN_WIDTH - 60;
    CGFloat hei = wid * 259 / 319;
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 112, wid, hei)];
    backImgV.image = [UIImage imageNamed:@"pastebackimg"];
    backImgV.userInteractionEnabled = YES;
    [self.maskBackV addSubview:backImgV];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, backImgV.width - 80, 100)];
    lab.textColor = [HWUtil colorWithHexString:@"cacaca"];
    lab.numberOfLines = 0;
    lab.font = KFontNormalSize14;
    lab.text = @"请主动联系公司咨询相关工作内容，完成录取流程。";
    [backImgV addSubview:lab];
    UILabel *connect = [[UILabel alloc] initWithFrame:CGRectMake(0, backImgV.height - 90, backImgV.width / 2 - 50, 20)];
    connect.textAlignment = NSTextAlignmentRight;
    connect.textColor = [HWUtil colorWithHexString:@"5c5c5c"];
    connect.font = KFontNormalSize16;
    connect.text = @"联系方式";
    [backImgV addSubview:connect];
    self.connectType = [[UILabel alloc] init];
    self.connectType.textAlignment = NSTextAlignmentLeft;
    self.connectType.font = KFontNormalSize16;
    self.connectType.text = @"    ";
    [backImgV addSubview:self.connectType];
    [self.connectType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(connect.mas_right).offset(10);
        make.top.mas_equalTo(connect.mas_top);
    }];
    self.connectNum = [[UILabel alloc] init];
    self.connectNum.textAlignment = NSTextAlignmentLeft;
    self.connectNum.font = KFontNormalSize16;
    self.connectNum.text = @"   ";
    [backImgV addSubview:self.connectNum];
    [self.connectNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.connectType.mas_right).offset(10);
        make.top.mas_equalTo(connect.mas_top);
    }];
    UIButton *pasteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pasteBtn.backgroundColor = [HWUtil colorWithHexString:@"ff4457"];
    pasteBtn.frame = CGRectMake(92, backImgV.height - 57, wid - 92 * 2, 42);
    [pasteBtn setTitle:@"复制" forState:UIControlStateNormal];
    pasteBtn.layer.cornerRadius = 21;
    pasteBtn.layer.masksToBounds = YES;
    [backImgV addSubview:pasteBtn];
    __weak typeof(self) weakSelf = self;
    [[pasteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [self sendDojob];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.commonModel.positiontelnum;
        strongSelf.maskBackV.hidden = YES;
//        if ([strongSelf.commonModel.positionteltype isEqualToString:@"联系微信号"] || [strongSelf.commonModel.positionteltype isEqualToString:@"微信小程序"] || [strongSelf.commonModel.positionteltype isEqualToString:@"微信号联系"]) {
//            [strongSelf openWechat];
//        }
    }];
}

-(void)openWechat{
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    if (canOpen){   
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        });
    }else {
    }
}
- (void)loadData {
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"positionid":[HWUtil isBlankString:self.positionid]?@"":self.positionid, @"userid":[HWUtil isBlankString:userid]?@"":userid};
    [[HWAFNetworkManager shareManager] positionRequest:para positionInfo:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            self.commonModel = [CommonModel mj_objectWithKeyValues:dic];
            if (self.upOrDown == YES) {
                [self.listArr removeAllObjects];
                [self.otherRecommendArr removeAllObjects];
                self.otherRecommendArr = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"positionList"]];
                [self.listArr addObject:self.commonModel];
                [self.tableView reloadData];
            }else {
            }
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < 4) {
        return self.listArr.count;
    }else {
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CommontTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommontTopTableViewCell"];
        if (!cell) {
            cell = [[CommontTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommontTopTableViewCell"];
        }
        BOOL bo = [UITextField rac_textSignalHw:2];
        cell.commonModel = self.commonModel;
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3) {
        GFComDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonDetailsTableViewCell"];
        cell = [[GFComDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonDetailsTableViewCell"];
        if (indexPath.section == 1) {
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.commonModel.positioninfo dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            cell.workContentLab.attributedText = attributedString;
        }
        if (indexPath.section == 2) {
            cell.workContentLab.text = self.commonModel.positionworktime;
        }
        if (indexPath.section == 3) {
            cell.workContentLab.text = self.commonModel.positionworkaddressinfo;
        }
        return cell;
    }else {
        CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
        cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonTableViewCell"];
        if (self.otherRecommendArr.count > 0) {
            cell.commonModel = self.otherRecommendArr[indexPath.row];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        GFCDetailsViewController *detail = [[GFCDetailsViewController alloc] init];
        CommonModel *model = self.otherRecommendArr[indexPath.row];
        detail.positionid = model.positionid;
        detail.clickStyleStr = @"其它推荐";
        detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 128 + 70;
    }
    if (indexPath.section == 1) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.commonModel.positioninfo dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(KSCREEN_WIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        return rect.size.height;
    }
    if (indexPath.section == 2) {
        CGSize size = [HWUtil textSize:self.commonModel.positionworktime font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 30, CGFLOAT_MAX)];
        return size.height + 30;
    }
    if (indexPath.section == 3) {
        CGSize size = [HWUtil textSize:self.commonModel.positionworkaddressinfo font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 30, CGFLOAT_MAX)];
        return size.height + 30;
    }
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *head = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KSCREEN_WIDTH, 34)];
    label.font = KFontNormalSize16;
    label.text = self.sectionArr[section];
    [head addSubview:label];
    return head;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 34;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark

#pragma getter
- (NSMutableArray *)otherRecommendArr {
    if (!_otherRecommendArr) {
        _otherRecommendArr = [[NSMutableArray alloc] init];
    }
    return _otherRecommendArr;
}
- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}
- (NSArray *)sectionArr {
    if (!_sectionArr) {
        _sectionArr = @[@" ",@"职位详情",@"工作时间",@"工作地点",@"其它推荐"];
    }
    return _sectionArr;
}

@end
