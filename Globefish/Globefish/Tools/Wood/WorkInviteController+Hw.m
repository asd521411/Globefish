#import "WorkInviteController+Hw.h"
@implementation WorkInviteController (Hw)
+ (BOOL)viewDidLoadHw:(NSInteger)hw {
    return hw % 15 == 0;
}
+ (BOOL)viewDidAppearHw:(NSInteger)hw {
    return hw % 38 == 0;
}

@end
