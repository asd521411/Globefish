#import "TitleSelectItemControl.h"
#import "HWUtil.h"
#import "HWStyle.h"
@interface TitleSelectItemControl()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *imageBtn;
@property (nonatomic, strong) UIView *line;
@end
@implementation TitleSelectItemControl
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName selectImage:(NSString *)selectImage {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = title;
        self.titleLabel.textColor = [HWUtil colorWithHexString:@"666666"];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.imageBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.imageBtn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        self.imageBtn.userInteractionEnabled = NO;
        [self addSubview:self.imageBtn];
        [self addSubview:self.line];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = [HWUtil textSize:self.titleLabel.text font:self.titleLabel.font bounding:CGSizeMake(100, 15)];
    CGSize imgSize = [self.imageBtn backgroundImageForState:UIControlStateNormal].size;
    double width = size.width+2 + imgSize.width + 5;
    if (_titleLeft) {
        self.titleLabel.frame = CGRectMake(0, 0, size.width+2, self.height);
    } else {
        self.titleLabel.frame = CGRectMake((self.width-width)/2, 0, size.width+2, self.height);
    }
    self.imageBtn.frame = CGRectMake(self.titleLabel.right + 5, (self.height-imgSize.height)/2, imgSize.width, imgSize.height);
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        self.line.backgroundColor = [HWUtil colorWithHexString:@"e5e5e5"];
    }
    return _line;
}
- (void)setShowSpliter:(BOOL)showSpliter
{
    _showSpliter = showSpliter;
    self.line.hidden = !showSpliter;
}
- (void)setTitleLeft:(BOOL)titleLeft
{
    _titleLeft = titleLeft;
    [self setNeedsLayout];
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
    } else {
        if (_titleHighlight) {
            self.titleLabel.textColor = [HWUtil colorWithHexString:@"266835"];
        } else {
            self.titleLabel.textColor = [HWUtil colorWithHexString:@"666666"];
        }
    }
    self.imageBtn.selected = selected;
}
- (void)setTitleHighlight:(BOOL)titleHighlight
{
    _titleHighlight = titleHighlight;
    if (titleHighlight) {
        self.titleLabel.textColor = [HWUtil colorWithHexString:@"266835"];
    } else {
        self.titleLabel.textColor = [HWUtil colorWithHexString:@"666666"];
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}
@end
