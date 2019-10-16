#import "StyleCollectionViewCell.h"
@interface StyleCollectionViewCell ()
@end
@implementation StyleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.styleImgV = [[UIImageView alloc] init];
        [self addSubview:self.styleImgV];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.styleImgV.frame = CGRectMake(0, 0, self.width, self.height);
}
@end
