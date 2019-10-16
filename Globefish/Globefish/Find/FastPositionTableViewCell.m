#import "FastPositionTableViewCell.h"
#import "UIView+HWUtilView.h"
@interface FastPositionTableViewCell ()
@property (nonatomic, strong) UIView *backV1;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *workAddressLab;
@property (nonatomic, strong) UILabel *princeLab;
@property (nonatomic, strong) UIImageView *rightImgV;
@property (nonatomic, strong) NSMutableArray *tagArr2;
@end
@implementation FastPositionTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColor_BackGround;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    [self addSubview:self.backV1];
    [self.backV1 addSubview:self.backV2];
    [self.backV2 addSubview:self.titleLab];
    [self.backV2 addSubview:self.workAddressLab];
    [self.backV2 addSubview:self.princeLab];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
    [self.backV1.superview layoutIfNeeded];
    [self.backV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.backV1);
    }];
    [self.backV2.superview layoutIfNeeded];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    [self.princeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.backV2.mas_bottom).offset(-15);
    }];
    [self.backV2.superview layoutIfNeeded];
    self.rightV.frame = CGRectMake(self.backV2.width - self.backV2.height, 0, self.backV2.height, self.backV2.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.rightV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(30, 30)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.rightV.bounds;
    layer.path = path.CGPath;
    self.rightV.layer.mask = layer;
    CGFloat w = 15;
    if (self.tagArr2.count > 0) {
        for (NSInteger i = 0; i < self.tagArr2.count; i++) {
            NSString *strW = self.tagArr2[i];
            CGFloat wid = strW.length * 12;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100 + w, 42, wid, 12)];
            lab.textColor = [HWUtil colorWithHexString:@"d7d7d7"];
            lab.font = KFontNormalSize10;
            lab.text = self.tagArr2[i];
            lab.textAlignment = NSTextAlignmentCenter;
            [self.backV2 addSubview:lab];
            w = w + wid + 15;
        }
    }
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
        if (![HWUtil isBlankString:commonModel.positionworktime]) {
            [self.tagArr2 addObject:commonModel.positionworktime];
        }
        self.titleLab.text = commonModel.positionname;
        self.workAddressLab.text = commonModel.positionworkaddressinfo;
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:commonModel.positonmoney attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:KFontNormalSize14}];
        NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:@"/天" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:KFontNormalSize14}];
        [attributedStr appendAttributedString:attributedStr1];
        self.princeLab.attributedText = attributedStr;
    }
}
- (UIView *)rightV {
    if (!_rightV) {
        _rightV = [[UIView alloc] init];
        _rightV.alpha = 0.2;
    }
    return _rightV;
}
- (UIView *)backV1 {
    if (!_backV1) {
        _backV1 = [[UIView alloc] init];
    }
    return _backV1;
}
- (UIImageView *)backV2 {
    if (!_backV2) {
        _backV2 = [[UIImageView alloc] init];
        _backV2.userInteractionEnabled = YES;
    }
    return _backV2;
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
        _titleLab.font = KFontNormalSize14;
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (NSMutableArray *)tagArr2 {
    if (!_tagArr2) {
        _tagArr2 = [[NSMutableArray alloc] init];
    }
    return _tagArr2;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
