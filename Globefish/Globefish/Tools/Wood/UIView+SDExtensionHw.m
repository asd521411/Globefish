#import "UIView+SDExtensionHw.h"
@implementation UIView (SDExtensionHw)
+ (BOOL)sd_heightHw:(NSInteger)hw {
    return hw % 34 == 0;
}
+ (BOOL)setSd_heightHw:(NSInteger)hw {
    return hw % 44 == 0;
}
+ (BOOL)sd_widthHw:(NSInteger)hw {
    return hw % 24 == 0;
}
+ (BOOL)setSd_widthHw:(NSInteger)hw {
    return hw % 33 == 0;
}
+ (BOOL)sd_yHw:(NSInteger)hw {
    return hw % 25 == 0;
}
+ (BOOL)setSd_yHw:(NSInteger)hw {
    return hw % 27 == 0;
}
+ (BOOL)sd_xHw:(NSInteger)hw {
    return hw % 9 == 0;
}
+ (BOOL)setSd_xHw:(NSInteger)hw {
    return hw % 1 == 0;
}

@end
