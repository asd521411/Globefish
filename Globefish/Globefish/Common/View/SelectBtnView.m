#import "SelectBtnView.h"
#import "UIView+HWUtilView.h"
@implementation SelectBtnView
#define kSpace 10
#define kWidth (KSCREEN_WIDTH - kSpace * 2 * 3 - kSpace * 2) / 5
#define kHeight 30
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString *)title itemStyle:(NSArray *)itemArr {
    self = [self initWithFrame:frame];
    if (self) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, kHeight)];
        lab.font = KFontNormalSize12;
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = title;
        lab.userInteractionEnabled = NO;
        [self addSubview:lab];
        for (NSInteger i = 0; i < itemArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((i % 4) * (kWidth + kSpace * 2), lab.bottom + kSpace + (i / 4) * (kHeight + kSpace), kWidth, kHeight);
            btn.backgroundColor = [HWRandomColor randomColor];
            btn.layer.cornerRadius = 2;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.titleLabel.font = KFontNormalSize10;
            [self addSubview:btn];
            [btn setTitle:itemArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
- (void)btnAction:(UIButton *)send {
    if (self.selectBtnActionBlock) {
        self.selectBtnActionBlock(send.titleLabel.text);
    }
}
@end
