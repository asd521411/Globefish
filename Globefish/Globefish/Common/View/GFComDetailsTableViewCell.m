#import "GFComDetailsTableViewCell.h"
#define leftSpace 50
@interface GFComDetailsTableViewCell ()
@property (nonatomic, strong) NSMutableArray *stringHeight;
@property (nonatomic, assign) CGFloat hei;
@end
@implementation GFComDetailsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.payLab = [[UILabel alloc] init];
//        self.payLab.font = KFontNormalSize14;
//        self.payLab.numberOfLines = 0;
//        [self addSubview:self.payLab];
        self.workContentLab = [[UILabel alloc] init];
        self.workContentLab.font = KFontNormalSize14;
        self.workContentLab.numberOfLines = 0;
        [self addSubview:self.workContentLab];
//        self.workTimeLab = [[UILabel alloc] init];
//        self.workTimeLab.font = KFontNormalSize14;
//        self.workTimeLab.numberOfLines = 0;
//        [self addSubview:self.workTimeLab];
//        self.workRequireLab = [[UILabel alloc] init];
//        self.workRequireLab.font = KFontNormalSize14;
//        self.workRequireLab.numberOfLines = 0;
//        [self addSubview:self.workRequireLab];
//        self.otherWelfareLab = [[UILabel alloc] init];
//        self.otherWelfareLab.font = KFontNormalSize14;
//        self.otherWelfareLab.numberOfLines = 0;
//        [self addSubview:self.otherWelfareLab];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.workContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(self.height);
    }];
}
//- (void)setCommonModel:(CommonModel *)commonModel {
//    if (_commonModel != commonModel) {
//        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[commonModel.positioninfo dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(self.width - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//        self.hei = rect.size.height;
//    }
//}
- (NSMutableArray *)stringHeight {
    if (!_stringHeight) {
        _stringHeight = [[NSMutableArray alloc] init];
    }
    return _stringHeight;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
