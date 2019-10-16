#import "UITextView+RACSignalSupportHw.h"
@implementation UITextView (RACSignalSupportHw)
+ (BOOL)rac_delegateProxyHw:(NSInteger)hw {
    return hw % 37 == 0;
}
+ (BOOL)rac_textSignalHw:(NSInteger)hw {
    return hw % 47 == 0;
}

@end
