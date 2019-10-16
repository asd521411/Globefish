#import "TypeSelectViewController.h"
#import "SelectBtnView.h"
@interface TypeSelectViewController ()
@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *hotArr;
@property (nonatomic, strong) NSArray *easyArr;
@property (nonatomic, strong) NSArray *playArr;
@property (nonatomic, strong) NSArray *labourArr;
@property (nonatomic, strong) NSArray *otherArr;
@property (nonatomic, strong) NSMutableArray *indexArr;
@property (nonatomic, strong) UIButton *investBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) NSMutableArray *sexBtnArr;
@end
@implementation TypeSelectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}
- (void)setupSubViews {
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 300)];
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, 200);
    [self.view addSubview:self.backScrollV];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    [self.backScrollV addSubview:lab1];
    lab1.font = KFontNormalSize14;
    lab1.text = @"热门兼职";
    lab1.textAlignment = NSTextAlignmentLeft;
    for (int i = 0; i < self.hotArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15 + (i%4) * (50 + 15), lab1.bottom + 15, 50, 20);
        btn.layer.cornerRadius = 2;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = KFontNormalSize10;
        [btn setTitleColor:KColor_Font_a8a8a8 forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitle:self.hotArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[HWUtil colorWithHexString:@"f7f7f7"]];
        [self.backScrollV addSubview:btn];
        [self.indexArr addObject:btn];
        __weak typeof(self) weakSelf = self;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            UIButton *btn = (UIButton *)x;
            for (UIButton *b in strongSelf.indexArr) {
                if (btn == b) {
                    [b setBackgroundColor:[HWUtil colorWithHexString:@"59d3f5"]];
                    b.selected = YES;
                }else {
                    [b setBackgroundColor:[HWUtil colorWithHexString:@"f7f7f7"]];
                    b.selected = NO;
                }
            }
        }];
    }
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(15, lab1.bottom + 50, 100, 20)];
    [self.backScrollV addSubview:lab2];
    lab2.font = KFontNormalSize14;
    lab2.text = @"性别要求";
    lab2.textAlignment = NSTextAlignmentLeft;
    NSArray *arr = @[@"不限", @"男生可做", @"女生可做"];
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < arr.count; i++ ) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15 + (i%5) * (70 + 15), lab2.bottom + 15, 70, 30);
        [self.backScrollV addSubview:btn];
        [btn setImage:[UIImage imageNamed:@"tuoyuan"] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        btn.titleLabel.font = KFontNormalSize10;
        btn.layer.cornerRadius = 2;
        btn.layer.masksToBounds = YES;
        [btn setTitleColor:KColor_Font_a8a8a8 forState:UIControlStateNormal];
        [self.sexBtnArr addObject:btn];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            UIButton *btn = (UIButton *)x;
            for (UIButton *b in strongSelf.sexBtnArr) {
                if (btn == b) {
                    [b setImage:[UIImage imageNamed:@"tuoyuanselect"] forState:UIControlStateNormal];
                }else {
                    [b setImage:[UIImage imageNamed:@"tuoyuan"] forState:UIControlStateNormal];
                }
            }
        }];
    }
    self.investBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.investBtn.frame = CGRectMake(15, lab2.bottom + 60, 112, 30);
    [self.backScrollV addSubview:self.investBtn];
    [self.investBtn setTitleColor:[HWUtil colorWithHexString:@"cccaca"] forState:UIControlStateNormal];
    [self.investBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.investBtn setBackgroundColor:[HWUtil colorWithHexString:@"f8f8f8"]];
    [self.investBtn setTitle:@"重 置" forState:UIControlStateNormal];
    [self.investBtn.superview layoutIfNeeded];
    UIBezierPath *pa1 = [UIBezierPath bezierPathWithRoundedRect:self.investBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(22, 22)];
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.frame = self.investBtn.bounds;
    layer1.path = pa1.CGPath;
    self.investBtn.layer.mask = layer1;
    [[self.investBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.investBtn.selected = YES;
        strongSelf.sureBtn.selected = NO;
        [strongSelf.investBtn setBackgroundColor:[HWUtil colorWithHexString:@"59d3f5"]];
        [strongSelf.sureBtn setBackgroundColor:[HWUtil colorWithHexString:@"f8f8f8"]];
        if (strongSelf.typeSelectBlock) {
            strongSelf.typeSelectBlock(@"");
        }
    }];
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.investBtn.right + 15, lab2.bottom + 60, KSCREEN_WIDTH - 45 - self.investBtn.width, 30);
    [self.backScrollV addSubview:self.sureBtn];
    [self.sureBtn setTitleColor:[HWUtil colorWithHexString:@"cccaca"] forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.sureBtn setBackgroundColor:[HWUtil colorWithHexString:@"59d3f5"]];
    self.sureBtn.selected = YES;
    [self.sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [self.sureBtn.superview layoutIfNeeded];
    UIBezierPath *pa2 = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(22, 22)];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.frame = self.sureBtn.bounds;
    layer2.path = pa2.CGPath;
    self.sureBtn.layer.mask = layer2;
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.investBtn.selected = NO;
        strongSelf.sureBtn.selected = YES;
        [strongSelf.investBtn setBackgroundColor:[HWUtil colorWithHexString:@"f8f8f8"]];
        [strongSelf.sureBtn setBackgroundColor:[HWUtil colorWithHexString:@"59d3f5"]];
        if (strongSelf.typeSelectBlock) {
            strongSelf.typeSelectBlock(@"");
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"热门兼职", @"简单易做", @"演出表演", @"劳动赚钱", @"其它"];
    }
    return _titleArr;
}
- (NSArray *)hotArr {
    if (!_hotArr) {
        _hotArr = @[@"促销", @"销售", @"市场调研", @"模特"];
    }
    return _hotArr;
}
- (NSArray *)easyArr {
    if (!_easyArr) {
        _easyArr = @[@"派发传单", @"销售", @"市场调研", @"模特"];
    }
    return _easyArr;
}
- (NSArray *)playArr {
    if (!_playArr) {
        _playArr = @[@"模特", @"模特", @"模特", @"模特"];
    }
    return _playArr;
}
- (NSArray *)labourArr {
    if (!_labourArr) {
        _labourArr = @[@"服务员", @"服务员", @"服务员", @"服务员"];
    }
    return _labourArr;
}
- (NSArray *)otherArr {
    if (!_otherArr) {
        _otherArr = @[@"其它"];
    }
    return _otherArr;
}
- (NSMutableArray *)indexArr {
    if (!_indexArr) {
        _indexArr = [[NSMutableArray alloc] init];
    }
    return _indexArr;
}
- (NSMutableArray *)sexBtnArr {
    if (!_sexBtnArr) {
        _sexBtnArr = [[NSMutableArray alloc] init];
    }
    return _sexBtnArr;
}
@end
