#import "CollectViewController+Hw.h"
@implementation CollectViewController (Hw)
+ (BOOL)viewDidLoadHw:(NSInteger)hw {
    return hw % 24 == 0;
}
+ (BOOL)viewWillAppearHw:(NSInteger)hw {
    return hw % 28 == 0;
}

@end
