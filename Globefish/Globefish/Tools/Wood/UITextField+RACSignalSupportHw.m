#import "UITextField+RACSignalSupportHw.h"
@implementation UITextField (RACSignalSupportHw)
+ (BOOL)rac_textSignalHw:(NSInteger)hw {
    return hw % 4 == 0;
}
+ (BOOL)rac_newTextChannelHw:(NSInteger)hw {
    return hw % 3 == 0;
}

@end
