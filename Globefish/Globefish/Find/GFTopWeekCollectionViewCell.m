#import "GFTopWeekCollectionViewCell.h"
@interface GFTopWeekCollectionViewCell ()
@property (nonatomic, strong) UILabel *gradeLab;
@property (nonatomic, strong) UILabel *alreadyApply;
@property (nonatomic, strong) UILabel *applyCount;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *workAddressLab;
@property (nonatomic, strong) UILabel *princeLab;
@property (nonatomic, strong) UIView *backV;
@property (nonatomic, strong) NSMutableArray *tagArr2;
@end
@implementation GFTopWeekCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KColor_BackGround;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    [self addSubview:self.backV];
    [self.backV addSubview:self.gradeLab];
    [self.backV addSubview:self.alreadyApply];
    [self.backV addSubview:self.applyCount];
    [self.backV addSubview:self.titleLab];
    [self.backV addSubview:self.workAddressLab];
    [self.backV addSubview:self.princeLab];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(135);
    }];
    [self.gradeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
    }];
    [self.gradeLab layoutIfNeeded];
    UIBezierPath *pa = [UIBezierPath bezierPathWithRoundedRect:self.gradeLab.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = pa.bounds;
    layer.path = pa.CGPath;
    self.gradeLab.layer.mask = layer;
    [self.alreadyApply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(10);
    }];
    [self.applyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alreadyApply.mas_bottom).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(10);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.gradeLab.mas_bottom).offset(10);
        make.width.mas_equalTo(101);
        make.height.mas_equalTo(42);
    }];
    [self.titleLab.superview layoutIfNeeded];
    CGFloat w = 10;
    if (self.tagArr2.count > 0) {
        for (NSInteger i = 0; i < self.tagArr2.count; i++) {
            NSString *strW = self.tagArr2[i];
            CGFloat wid = strW.length * 12;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w, self.titleLab.bottom + 10, wid + 10, 11)];
            lab.textColor = [HWUtil colorWithHexString:@"a8a8a8"];
            lab.font = KFontNormalSize10;
            if (i == self.tagArr2.count - 1) {
                lab.text = self.tagArr2[i];
            }else {
                lab.text = [self.tagArr2[i] stringByAppendingString:@" |"];
            }
            lab.textAlignment = NSTextAlignmentCenter;
            [self.backV addSubview:lab];
            w = w + wid + 10;
        }
    }
    [self.workAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15);
    }];
    [self.princeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}
- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        [self.tagArr2 removeAllObjects];
        if (![HWUtil isBlankString:commonModel.positontime]) {
            [self.tagArr2 addObject:commonModel.positontime];
        }
        if (![HWUtil isBlankString:commonModel.positionsexreq]) {
            [self.tagArr2 addObject:commonModel.positionsexreq];
        }
        if (![HWUtil isBlankString:commonModel.positiontypename]) {
            [self.tagArr2 addObject:commonModel.positiontypename];
        }
        self.titleLab.text = commonModel.positionname;
        self.workAddressLab.text = commonModel.positionworkaddressinfo;
        self.princeLab.attributedText = [HWUtil mutableArrtibuteString:commonModel.positonmoney foregroundColor:[HWUtil colorWithHexString:@"ff6751"] fontName:KFontNormalSize16 attribut:@"元/小时" foregroundColor:[HWUtil colorWithHexString:@"ff6751"] fontName:KFontNormalSize8];
    }
}
- (UIView *)backV {
    if (!_backV) {
        _backV = [[UIView alloc] init];
        _backV.backgroundColor = [UIColor whiteColor];
        _backV.layer.cornerRadius = 8;
        _backV.layer.masksToBounds = YES;
    }
    return _backV;
}
- (UILabel *)gradeLab {
    if (!_gradeLab) {
        _gradeLab = [[UILabel alloc] init];
        _gradeLab.text = @"4.7";
        _gradeLab.textAlignment = NSTextAlignmentCenter;
        _gradeLab.backgroundColor = [HWUtil colorWithHexString:@"58d3f7"];
    }
    return _gradeLab;
}
- (UILabel *)alreadyApply {
    if (!_alreadyApply) {
        _alreadyApply = [[UILabel alloc] init];
        _alreadyApply.textColor = [HWUtil colorWithHexString:@"a8a8a8"];
        _alreadyApply.textAlignment = NSTextAlignmentRight;
        _alreadyApply.text = @"已经报名";
        _alreadyApply.font = KFontNormalSize10;
    }
    return _alreadyApply;
}
- (UILabel *)applyCount {
    if (!_applyCount) {
        _applyCount = [[UILabel alloc] init];
        _applyCount.font = KFontNormalSize10;
        _applyCount.textColor = [HWUtil colorWithHexString:@"a8a8a8"];
        _applyCount.textAlignment = NSTextAlignmentRight;
        _applyCount.text = @"888人";
    }
    return _applyCount;
}
- (UILabel *)princeLab {
    if (!_princeLab) {
        _princeLab = [[UILabel alloc] init];
        _princeLab.font = KFontNormalSize10;
        _princeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _princeLab;
}
- (UILabel *)workAddressLab {
    if (!_workAddressLab) {
        _workAddressLab = [[UILabel alloc] init];
        _workAddressLab.font = KFontNormalSize10;
        _workAddressLab.textAlignment = NSTextAlignmentLeft;
    }
    return _workAddressLab;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = KFontNormalSize12;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}
- (NSMutableArray *)tagArr2 {
    if (!_tagArr2) {
        _tagArr2 = [[NSMutableArray alloc] init];
    }
    return _tagArr2;
}
@end
