#import "GFLoginViewController.h"
#import "NSString+HWCheckoutHelper.h"
#import "GFPrivateViewController.h"
@interface GFLoginViewController ()
@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger interger;
@property (nonatomic, strong) UIButton *getCode;
@end
@implementation GFLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self popSuperView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer setFireDate:[NSDate distantFuture]];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)setupSubViews {
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [HWStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [HWStyle navigationbarHeight] - [HWStyle toolbarHeight])];
    self.backScrollV.scrollEnabled = YES;
    self.backScrollV.bounces = YES;
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT + 100);
    [self.view addSubview:self.backScrollV];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
    [self.backScrollV addGestureRecognizer:tap1];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, KSCREEN_WIDTH - 30, 25)];
    lab1.textColor = [HWUtil colorWithHexString:@"2f2f2f"];
    lab1.text = @"欢迎加入河豚兼职~";
    lab1.font = [UIFont boldSystemFontOfSize:22];
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    UILabel *lableft1 = [[UILabel alloc] init];
    lableft1.textColor = [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1];
    lableft1.font = KFontNormalSize16;
    lableft1.text = @"请输入手机号";
    lableft1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lableft1];
    [lableft1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(lab1.mas_bottom).offset(110);
        make.width.mas_equalTo(100);
    }];
    UITextField *textFd1 = [[UITextField alloc] init];
    textFd1.placeholder = @" ";
    textFd1.textColor = KColor_C8C8C8;
    textFd1.font = KFontNormalSize16;
    textFd1.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:textFd1];
    [textFd1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lableft1.mas_right).offset(20);
        make.top.mas_equalTo(lableft1.mas_top);
        make.height.mas_equalTo(lableft1.mas_height);
        make.width.mas_equalTo(KSCREEN_WIDTH-200);
    }];
    [[textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 11) {
            textFd1.text = [text substringToIndex:11];
        }
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [HWUtil colorWithHexString:@"7be2f9"];
    [self.backScrollV addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lableft1.mas_left);
        make.top.mas_equalTo(lableft1.mas_bottom).offset(10);
        make.width.mas_equalTo(KSCREEN_WIDTH-80);
        make.height.mas_equalTo(0.5);
    }];
    UILabel *lableft2 = [[UILabel alloc] init];
    lableft2.textColor = [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1];
    lableft2.font = KFontNormalSize16;
    lableft2.text = @"请输入验证码";
    lableft2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lableft2];
    [lableft2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(lableft1.mas_bottom).offset(50);
        make.width.mas_equalTo(100);
    }];
    UITextField *textFd2 = [[UITextField alloc] init];
    textFd2.placeholder = @" ";
    textFd2.textColor = KColor_C8C8C8;
    textFd2.font = KFontNormalSize16;
    textFd2.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:textFd2];
    [textFd2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lableft2.mas_right).offset(20);
        make.top.mas_equalTo(lableft2.mas_top);
        make.height.mas_equalTo(lableft2.mas_height);
        make.width.mas_equalTo(KSCREEN_WIDTH-200);
    }];
    [[textFd2 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 6) {
            textFd2.text = [text substringToIndex:6];
        }
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [HWUtil colorWithHexString:@"7be2f9"];
    [self.backScrollV addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lableft2.mas_left);
        make.top.mas_equalTo(lableft2.mas_bottom).offset(10);
        make.width.mas_equalTo(KSCREEN_WIDTH-80);
        make.height.mas_equalTo(0.5);
    }];
    self.getCode = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getCode.backgroundColor = [HWUtil colorWithHexString:@"7be2f9"];
    self.getCode.layer.cornerRadius = 14;
    self.getCode.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.getCode];
    [self.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getCode.titleLabel.font = KFontNormalSize12;
    [self.getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(line2);
        make.right.mas_equalTo(self.backScrollV.width-40);
    }];
    __weak typeof(self) weakSelf = self;
    [[self.getCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (![textFd1.text n6_isMobile] || textFd1.text.length != 11) {
            [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.timer setFireDate:[NSDate distantPast]];
        strongSelf.getCode.userInteractionEnabled = NO;
        strongSelf.interger = 60;
        [[HWAFNetworkManager shareManager] accountRequest:@{@"usertel":textFd1.text} sendMessage:^(BOOL success, id  _Nonnull request) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
            }
        }];
    }];
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backScrollV);
        make.top.mas_equalTo(lableft2.mas_bottom).offset(70);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(40);
    }];
    [login setTitle:@"登  陆" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    login.adjustsImageWhenHighlighted = NO;
    [login setBackgroundColor:[HWUtil colorWithHexString:@"7be2f9"]];
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [textFd1 resignFirstResponder];
        [textFd2 resignFirstResponder];
        if (![textFd1.text n6_isMobile]) {
            [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        if (textFd2.text.length != 6) {
            [SVProgressHUD showInfoWithStatus:@"验证码错误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        NSDictionary *para = @{@"usertel":textFd1.text,
                               @"usermessagecode":textFd2.text,
                               @"phonecard":[HWUtil getIDFA]
                               };
        [[HWAFNetworkManager shareManager] accountRequest:para logonAndloginByMessage:^(BOOL success, id  _Nonnull request) {
            NSDictionary *dic = (NSDictionary *)request;
            if (success) {
                [SVProgressHUD showSuccessWithStatus:dic[@"message"]];
                [SVProgressHUD dismissWithDelay:1];
                
                if ([request[@"status"] isEqualToString:@"success"]) {
                    if (dic[@"userid"]) {
                        [NSUserDefaultMemory defaultSetMemory:dic[@"userid"] unityKey:USERID];
                        [strongSelf.navigationController popToRootViewControllerAnimated:YES];
                    }else {
                        [SVProgressHUD showSuccessWithStatus:@"请求错误！"];
                        [SVProgressHUD dismissWithDelay:1];
                    }
                }
//                if ([request[@"status"] isEqualToString:@"fail"]) {
//                    if ([request[@"statusMessage"] isEqualToString:@"验证码错误"]) {
//                    }
//                    if ([request[@"statusMessage"] isEqualToString:@"用户没有注册，请注册"]) {
//                    }
//                }
//                if ([request[@"status"] isEqualToString:@"success"]) {
//                    if (dic[@"userid"]) {
//                        [NSUserDefaultMemory defaultSetMemory:dic[@"userid"] unityKey:USERID];
//                        [strongSelf.navigationController popToRootViewControllerAnimated:YES];
//                    }else {
//                        [SVProgressHUD showSuccessWithStatus:@"请求错误！"];
//                        [SVProgressHUD dismissWithDelay:1];
//                    }
//                }
            }
        }];
    }];
    UILabel *rd = [[UILabel alloc] init];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:@"登陆即同意用户协议"];
    [mutStr addAttributes:@{NSForegroundColorAttributeName:[HWUtil colorWithHexString:@"b7b7b7"], NSFontAttributeName:KFontNormalSize16} range:NSMakeRange(0, 9)];
    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc] initWithString:@"《河豚兼职隐私政策》"];
    [mutStr1 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:70/255.0 green:222/255.0 blue:160/255.0 alpha:1], NSFontAttributeName:KFontNormalSize16} range:NSMakeRange(0, 10)];
    [mutStr appendAttributedString:mutStr1];
    rd.attributedText = mutStr;
    rd.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:rd];
    [rd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(login.mas_bottom).offset(50);
        make.width.mas_equalTo(KSCREEN_WIDTH-30);
        make.height.mas_equalTo(20);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [rd addGestureRecognizer:tap];
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.frame = CGRectMake(15, login.bottom + 50, KSCREEN_WIDTH - 30, 20);
    [self.backScrollV addSubview:bu];
    [bu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(login.mas_bottom).offset(50);
        make.width.mas_equalTo(KSCREEN_WIDTH-30);
        make.height.mas_equalTo(20);
    }];
    [bu addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tapAction1:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}
- (void)timer:(NSTimer *)time {
    self.interger--;
    [self.getCode setTitle:[NSString stringWithFormat:@"%ld%@",(long)self.interger, @"s"] forState:UIControlStateNormal];
    if (self.interger == 0) {
        [self.getCode setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        self.getCode.userInteractionEnabled = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
- (void)tapAction:(UIButton *)send {
    GFPrivateViewController *pri = [[GFPrivateViewController alloc] init];
    [self.navigationController pushViewController:pri animated:YES];
}
@end
