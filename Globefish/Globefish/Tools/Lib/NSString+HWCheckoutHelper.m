#import "NSString+HWCheckoutHelper.h"
@implementation NSString (HWCheckoutHelper)
- (BOOL)n6_isMobile {
    NSString *mobileRegex = @"^[1][3456789][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", mobileRegex];
    return [predicate evaluateWithObject:self];
}
- (BOOL)n6_isPassWord {
    NSString *passwordRegex =
    @"[a-zA-Z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [predicate evaluateWithObject:self];
}
@end
