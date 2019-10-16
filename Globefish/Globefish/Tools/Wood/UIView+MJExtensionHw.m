#import "UIView+MJExtensionHw.h"
@implementation UIView (MJExtensionHw)
+ (BOOL)setMj_xHw:(NSInteger)hw {
    return hw % 48 == 0;
}
+ (BOOL)mj_xHw:(NSInteger)hw {
    return hw % 11 == 0;
}
+ (BOOL)setMj_yHw:(NSInteger)hw {
    return hw % 48 == 0;
}
+ (BOOL)mj_yHw:(NSInteger)hw {
    return hw % 43 == 0;
}
+ (BOOL)setMj_wHw:(NSInteger)hw {
    return hw % 33 == 0;
}
+ (BOOL)mj_wHw:(NSInteger)hw {
    return hw % 27 == 0;
}
+ (BOOL)setMj_hHw:(NSInteger)hw {
    return hw % 43 == 0;
}
+ (BOOL)mj_hHw:(NSInteger)hw {
    return hw % 6 == 0;
}
+ (BOOL)setMj_sizeHw:(NSInteger)hw {
    return hw % 35 == 0;
}
+ (BOOL)mj_sizeHw:(NSInteger)hw {
    return hw % 9 == 0;
}
+ (BOOL)setMj_originHw:(NSInteger)hw {
    return hw % 26 == 0;
}
+ (BOOL)mj_originHw:(NSInteger)hw {
    return hw % 3 == 0;
}

@end
