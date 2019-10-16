#import "MessageTableViewCell.h"
@interface MessageTableViewCell ()
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UILabel *timeLab;
@end
@implementation MessageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColor_BackGround;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    [self addSubview:self.headImgV];
    [self addSubview:self.titleLab];
    [self addSubview:self.detailLab];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(self.height - 20);
        make.bottom.mas_equalTo(-10);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImgV.mas_right).offset(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
    }];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImgV.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
    }];
}
- (void)setMessageModel:(MessageModel *)messageModel {
    if (_messageModel != messageModel) {
        self.headImgV.image = [UIImage imageNamed:messageModel.headImg];
        self.titleLab.text = @"北京科技有限公司";
        self.detailLab.text = @"感谢你参加面试";
        self.timeLab.text = @"2分钟前";
    }
}
- (UIImageView *)headImgV {
    if (!_headImgV) {
        _headImgV = [[UIImageView alloc] init];
        _headImgV.layer.cornerRadius = 2;
        _headImgV.layer.masksToBounds = YES;
    }
    return _headImgV;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = KFontNormalSize14;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = [HWUtil colorWithHexString:@"2f2f2f"];
    }
    return _titleLab;
}
- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] init];
        _detailLab.font = KFontNormalSize10;
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.textColor = [HWUtil colorWithHexString:@"dadada"];
    }
    return _detailLab;
}
- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = KFontNormalSize10;
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.textColor = [HWUtil colorWithHexString:@"dadada"];
    }
    return _timeLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
