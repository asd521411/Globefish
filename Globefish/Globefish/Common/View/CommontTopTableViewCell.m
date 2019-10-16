#import "CommontTopTableViewCell.h"
@interface CommontTopTableViewCell ()
@property (nonatomic, strong) NSMutableArray *tagArr1;
@property (nonatomic, strong) NSMutableArray *tagArr2;
@end
@implementation CommontTopTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.addressnameTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.right.mas_equalTo(self.princeLab.mas_left);
        make.height.mas_equalTo(18);
    }];
    [self.princeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressnameTitleLab.mas_right);
        make.top.mas_equalTo(self.addressnameTitleLab);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(18);
    }];
    [self.positionStyleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.addressnameTitleLab.mas_bottom).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(10);
    }];
    [self.demandTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.positionStyleLab.mas_bottom).offset(15);
        make.right.mas_equalTo(70);
        make.height.mas_equalTo(14);
    }];
    [self.demandTitleLab.superview layoutIfNeeded];
    CGFloat w = 15;
    if (self.tagArr2.count > 0) {
        for (NSInteger i = 0; i < self.tagArr2.count; i++) {
            NSString *strW = self.tagArr2[i];
            CGFloat wid = strW.length * 15;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w, self.demandTitleLab.bottom + 10, wid, 12)];
            lab.backgroundColor = [UIColor whiteColor];
            lab.font = KFontNormalSize14;
            lab.text = self.tagArr2[i];
            lab.textAlignment = NSTextAlignmentCenter;
            [self addSubview:lab];
            w = w + wid + 15;
        }
    }
}
- (void)setupSubViews {
    [self addSubview:self.addressnameTitleLab];
    [self addSubview:self.princeLab];
    [self addSubview:self.positionStyleLab];
    [self addSubview:self.demandTitleLab];
}
- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        self.addressnameTitleLab.text = commonModel.positionname;
        self.tagArr1 = [[NSMutableArray alloc] init];
        if (![HWUtil isBlankString:commonModel.positionworkaddressname]) {
            [self.tagArr1 addObject:commonModel.positionworkaddressname];
        }
        if (![HWUtil isBlankString:commonModel.positionpaytypename]) {
            [self.tagArr1 addObject:commonModel.positionpaytypename];
        }
        if (![HWUtil isBlankString:commonModel.positionworktime]) {
            [self.tagArr1 addObject:commonModel.positionworktime];
        }
        NSString *string1 = @"";
        NSString *str1 = @"•";
        for (NSString *str in self.tagArr1) {
            if (![HWUtil isBlankString:str]) {
                string1 = [string1 stringByAppendingString: [str stringByAppendingString:str1]];
            }
        }
        string1 = [string1 substringToIndex:string1.length-1];
        self.positionStyleLab.text = string1;
        self.tagArr2 = [[NSMutableArray alloc] init];
        if (![HWUtil isBlankString:commonModel.positontime]) {
            [self.tagArr2 addObject:commonModel.positontime];
        }
        if (![HWUtil isBlankString:commonModel.positionsexreq]) {
            [self.tagArr2 addObject:commonModel.positionsexreq];
        }
        if (![HWUtil isBlankString:commonModel.positiontypename]) {
            [self.tagArr2 addObject:commonModel.positiontypename];
        }
    }
}
- (UILabel *)addressnameTitleLab {
    if (!_addressnameTitleLab) {
        _addressnameTitleLab = [[UILabel alloc] init];
        _addressnameTitleLab.font = KFontNormalSize18;
        _addressnameTitleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _addressnameTitleLab;
}
- (UILabel *)princeLab {
    if (!_princeLab) {
        _princeLab = [[UILabel alloc] init];
        _princeLab.textAlignment = NSTextAlignmentRight;
    }
    return _princeLab;
}
- (UILabel *)positionStyleLab {
    if (!_positionStyleLab) {
        _positionStyleLab = [[UILabel alloc] init];
        _positionStyleLab.font = KFontNormalSize14;
    }
    return _positionStyleLab;
}
- (UILabel *)demandTitleLab {
    if (!_demandTitleLab) {
        _demandTitleLab = [[UILabel alloc] init];
        _demandTitleLab.font = KFontNormalSize14;
        _demandTitleLab.text = @"招聘需求";
    }
    return _demandTitleLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
