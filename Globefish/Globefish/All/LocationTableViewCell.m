#import "LocationTableViewCell.h"
@implementation LocationTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.textColor = [HWUtil colorWithHexString:@"333333"];
        self.titleLab.font = [UIFont systemFontOfSize:14];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLab.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
