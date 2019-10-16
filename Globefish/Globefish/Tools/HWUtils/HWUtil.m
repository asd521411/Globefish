#import "HWUtil.h"
#import "HWStyle.h"
#import "HWDevice.h"
#import <AdSupport/AdSupport.h>
@implementation HWUtil
# pragma mark - 有效性检查
+ (BOOL)checkInputPhoneNum:(NSString*)num
{
    if (num.length != 11)
    {
        return NO;
    }
    NSString *compare = @"0123456789";
    NSString *temp;
    for (NSInteger i = 0; i < [num length]; i ++)
    {
        temp = [num substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [compare rangeOfString:temp];
        NSInteger location = range.location;
        if (location < 0)
        {
            return NO;
        }
    }
    return YES;
}
+ (BOOL)checkoutIsMobile {
    NSString *mobileRegex = @"^[1][3456789][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", mobileRegex];
    return [predicate evaluateWithObject:self];
}
+ (BOOL)validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[\u4E00-\u9FA5]{1,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]){
        return YES;
    }
    return NO;
}
+ (BOOL)textField:(UITextField *)textField evaluateNumberChargeInRange:(NSRange)range replacementString:(NSString *)string hasDot:(BOOL *)hasDot
{
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        *hasDot = NO;
    }
    if ([string length]>0)
    {
        if ((textField.text.length < 6 && !*hasDot) || ([textField.text rangeOfString:@"."].location < 6 && *hasDot)) {
            unichar single=[string characterAtIndex:0];
            if ((single >='0' && single<='9') || single == '.')
            {
                if([textField.text length]==0){
                    if(single == '.'){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                    if (single == '0') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return YES;
                    }
                }
                if (single=='.')
                {
                    if(!*hasDot)
                    {
                        *hasDot = YES;
                        return YES;
                    }else
                    {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                else
                {
                    if (*hasDot)
                    {
                        NSRange ran=[textField.text rangeOfString:@"."];
                        NSInteger tt=range.location-ran.location;
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                    else
                    {
                        return YES;
                    }
                }
            }else{
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else if(textField.text.length == 6 && !*hasDot && [string characterAtIndex:0] == '.'){
            return YES;
        }else if((textField.text.length == 7 || textField.text.length == 8) && [textField.text rangeOfString:@"."].location == 6)
        {
            unichar single=[string characterAtIndex:0];
            if (single >='0' && single<='9')
            {
                NSRange ran=[textField.text rangeOfString:@"."];
                NSInteger tt=range.location-ran.location;
                if (tt <= 2){
                    return YES;
                }else{
                    return NO;
                }
            }
            else{
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
            return NO;
        }
    }
    else
    {
        return YES;
    }
    return NO;
}
# pragma mark - 其他方法
+ (CGSize)textSize:(NSString *)text font:(UIFont *)font bounding:(CGSize)size
{
    if (!(text && font) || [text isEqual:[NSNull null]]) {
        return CGSizeZero;
    }
    CGRect rect = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
    return CGRectIntegral(rect).size;
}
+ (CGFloat)widgetHeight:(UIView *)widget sizeMakeWidth:(CGFloat)wid {
    if ([widget isKindOfClass:[UILabel class]]) {
        UILabel *la = (UILabel *)widget;
        la.numberOfLines = 0;
    }
    CGSize fit = [widget sizeThatFits:CGSizeMake(wid, CGFLOAT_MAX)];
    return fit.height;
}
+ (NSInteger)textLength:(NSString *)text
{
    if (text == nil || [text isEqual:[NSNull null]]) {
        return 0;
    }
    return [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length;
}
+ (NSString *)formatFloat:(CGFloat)number
{
    NSNumberFormatter *formatter = [HWUtil numberFormatter];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:number]];
}
+ (NSString *)formatMoney:(CGFloat)number
{
    return [NSString stringWithFormat:NSLocalizedString(@"md_result_yuan_fmt", nil), [HWUtil formatFloat:number]];
}
+ (CGFloat)singleLineHeight:(UIFont *)font
{
    return [HWUtil textSize:@"A" font:font bounding:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
}
#pragma mark - 颜色相关
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
+ (NSNumberFormatter *)numberFormatter
{
    NSNumberFormatter *formatter;
    if (formatter == nil)
    {
        formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:2];
    }
    return formatter;
}
# pragma mark - 时间相关
+ (NSString *)formatTime:(NSInteger)time
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:date];
}
+ (NSString *)stringWithSeconds:(NSTimeInterval)seconds timeFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    static NSDateFormatter *formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    }
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}
+ (NSTimeInterval)secondsWithString:(NSString *)string timeFormat:(NSString *)format
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    }
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:string];
    return [date timeIntervalSince1970];
}
# pragma mark - 图片相关操作
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, (CGRect){CGPointZero,size});
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (float)imagePixByDevice
{
    if ([HWDevice getDeviceType] == EDeviceType_6p) {
        return 3.0;
    }else{
        return 2.0;
    }
}
+ (UIImage *)getImageName:(NSString *)imgName formBundle:(NSString *)bundleName isThreeFix:(BOOL)isFix imgType:(NSString *)imageType
{
    NSString *path = nil;
    if (isFix) {
        path = [[NSBundle mainBundle]
                    pathForResource:[NSString stringWithFormat:@"%@/%@@%ldx", bundleName, imgName,(long)[self imagePixByDevice]] ofType:imageType];
    }else{
        path = [[NSBundle mainBundle]
                pathForResource:[NSString stringWithFormat:@"%@/%@", bundleName, imgName] ofType:imageType];
    }
    return [UIImage imageWithContentsOfFile:path];
}
+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
+ (void)saveImageToAlbum:(UIImage *)image
{
}
+ (void)gradientLayer:(UIView *)v startPoint:(CGPoint)start endPoint:(CGPoint)end colorArr1:(UIColor *)color1 colorArr2:(UIColor *)color2 location1:(CGFloat)v1 location2:(CGFloat)v2{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = v.bounds;
    [v.layer addSublayer:gradient];
    gradient.startPoint = start;
    gradient.endPoint = end;
    gradient.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];
}
+ (NSAttributedString *)mutableArrtibuteString:(NSString *)str1 foregroundColor:(UIColor *)color1 fontName:(UIFont *)font1 attribut:(NSString *)str2 foregroundColor:(UIColor *)color2 fontName:(UIFont *)font2{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str1 attributes:@{NSForegroundColorAttributeName:color1, NSFontAttributeName:font1}];
    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc] initWithString:str2 attributes:@{NSForegroundColorAttributeName:color2, NSFontAttributeName:font2}];
    [attributedStr appendAttributedString:attributedStr2];
    return attributedStr;
}
+ (NSString *)getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result;
}
+ (NSString *)getIDFA {
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}
@end
