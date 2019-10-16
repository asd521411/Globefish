#import "ImgTitleView.h"
#import "Masonry.h"
@implementation ImgTitleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.topImgV = [[UIImageView alloc] init];
        self.topImgV.image = [UIImage imageNamed:@""];
        [self addSubview:self.topImgV];
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.font = KFontNormalSize10;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLab];
        self.maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.maskBtn];
        [self.maskBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.topImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_offset(-10);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(self.height-20);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.left.bottom.right.mas_equalTo(self);
    }];
    [self.maskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self);
    }];
}
- (void)btnAction:(UIButton *)send {
    if (self.imgTitleViewBlock) {
        self.imgTitleViewBlock(send.tag);
    }
    if ([self.delegate respondsToSelector:@selector(ImgTitleViewACtion:)]) {
        [self.delegate ImgTitleViewACtion:send.tag];
    }
}
@end
