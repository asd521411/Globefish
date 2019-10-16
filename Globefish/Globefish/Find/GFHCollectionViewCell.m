#import "GFHCollectionViewCell.h"
#import "UIView+HWUtilView.h"
@interface GFHCollectionViewCell ()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *workAddressLab;
@property (nonatomic, strong) UILabel *princeLab;
@property (nonatomic, strong) UIView *backV;
@property (nonatomic, strong) NSMutableArray *tagArr2;
@end
@implementation GFHCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    [self addSubview:self.backV];
    [self.backV addSubview:self.titleLab];
    [self.backV addSubview:self.workAddressLab];
    [self.backV addSubview:self.princeLab];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backV.frame = CGRectMake(0, 0, self.width, self.height);
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(38);
    }];
    [self.titleLab.superview layoutIfNeeded];
    CGFloat w = 15;
    if (self.tagArr2.count > 0) {
        for (NSInteger i = 0; i < self.tagArr2.count; i++) {
            NSString *strW = self.tagArr2[i];
            CGFloat wid = strW.length * 12;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w, self.titleLab.bottom, wid, 11)];
            lab.textColor = [HWUtil colorWithHexString:@"59d3f5"];
            lab.font = KFontNormalSize10;
            lab.text = self.tagArr2[i];
            lab.layer.borderColor = [HWUtil colorWithHexString:@"59d3f5"].CGColor;
            lab.layer.borderWidth = 0.5;
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
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);
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
        self.princeLab.attributedText = [HWUtil mutableArrtibuteString:commonModel.positonmoney foregroundColor:[HWUtil colorWithHexString:@"ff6751"] fontName:KFontNormalSize10 attribut:@"元/小时" foregroundColor:[HWUtil colorWithHexString:@"ff6751"] fontName:KFontNormalSize8];
    }
}
- (UIView *)backV {
    if (!_backV) {
        _backV = [[UIView alloc] init];
        _backV.backgroundColor = [UIColor whiteColor];
        _backV.layer.cornerRadius = 2;
        _backV.layer.masksToBounds = YES;
    }
    return _backV;
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
