#import "AboutUSViewController+Hw.h"
@implementation AboutUSViewController (Hw)
+ (BOOL)viewDidLoadHw:(NSInteger)hw {
    return hw % 2 == 0;
}
+ (BOOL)viewWillAppearHw:(NSInteger)hw {
    return hw % 32 == 0;
}

@end
