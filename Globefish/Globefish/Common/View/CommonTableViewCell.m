#import "CommonTableViewCell.h"
#import "UIImageView+WebCache.h"
#define topSpace 6
@interface CommonTableViewCell ()
@property (nonatomic, strong) UIView *line;
@end
@implementation CommonTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColor_BackGround;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tagImgV = [[UIImageView alloc] init];
        self.tagImgV.image = [UIImage imageNamed:@"dituicon"];
        [self addSubview:self.tagImgV];
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.textColor = KColor_Font_2f2f2f;
        self.titleLab.font = KFontNormalSize16;
        [self addSubview:self.titleLab];
        self.locationLab = [[UILabel alloc] init];
        self.locationLab.textColor = KColor_Font_a8a8a8;
        self.locationLab.font = KFontNormalSize14;
        [self addSubview:self.locationLab];
        self.accountStyleLab = [[UILabel alloc] init];
        self.accountStyleLab.textColor = [HWUtil colorWithHexString:@"59d3f5"];
        self.accountStyleLab.font = KFontNormalSize14;
        self.accountStyleLab.layer.borderColor = [HWUtil colorWithHexString:@"59d3f5"].CGColor;
        self.accountStyleLab.layer.borderWidth = 0.5;
        [self addSubview:self.accountStyleLab];
        self.princeLab = [[UILabel alloc] init];
        [self addSubview:self.princeLab];
        self.tagLab = [[UILabel alloc] init];
        self.tagLab.textColor = [HWUtil colorWithHexString:@"212121"];
        self.tagLab.font = KFontNormalSize14;
        [self addSubview:self.tagLab];
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = KColor_Line_dfdfdf;
        [self addSubview:self.line];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(14);
    }];
    [self.accountStyleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(16);
    }];
    [self.tagImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
        make.width.height.mas_equalTo(15);
    }];
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagImgV.mas_right).offset(15);
        make.top.mas_equalTo(self.tagImgV.mas_top);
        make.height.mas_equalTo(14);
    }];
    [self.tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationLab.mas_right).offset(15);
        make.top.mas_equalTo(self.locationLab.mas_top);
        make.height.mas_equalTo(14);
    }];
    [self.princeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(self.titleLab.mas_top);
        make.height.mas_equalTo(18);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self).offset(0.5);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        self.titleLab.text = commonModel.positionname;
        self.locationLab.text = commonModel.positionworkaddressname;
        self.accountStyleLab.text = commonModel.positionpaytypename;
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:commonModel.positonmoney attributes:@{NSForegroundColorAttributeName:[HWUtil colorWithHexString:@"ff6751"], NSFontAttributeName:KFontNormalSize16}];
        NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:@"元/小时" attributes:@{NSForegroundColorAttributeName:[HWUtil colorWithHexString:@"ff6751"], NSFontAttributeName:KFontNormalSize12}];
        [attributedStr appendAttributedString:attributedStr1];
        self.princeLab.attributedText = attributedStr;
        self.tagLab.text = commonModel.positioncompang;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
