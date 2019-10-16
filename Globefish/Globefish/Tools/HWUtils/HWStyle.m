#import "HWStyle.h"
#import "HWUtil.h"
#import "HWDevice.h"
CGFloat const ECLineSpace = 5;
CGFloat const ECParagraphSpace = 10;
CGFloat const ECBorderSpace = 15;
CGFloat const ECContentPageSpace = 30;
CGFloat const ECViewSpace = 20;
CGFloat const ECNavigationbarHeight = 60;
CGFloat const ECViewBackgroundAlpha = 0.4;
NSInteger const ECTextViewMaxInput = 140;
NSInteger const ECLineTag = 9998;
@implementation HWStyle
+ (CGFloat)screenWidth
{
    CGRect frame = [UIScreen mainScreen].bounds;
    return frame.size.width;
}
+ (CGFloat)screenHeight
{
    CGRect frame = [UIScreen mainScreen].bounds;
    return frame.size.height;
}
+ (CGFloat)statusbarHeight
{
    if ([HWDevice getDeviceType] == EDeviceType_X) {
        return 44;
    }
    return 20;
}
+ (CGFloat)navigationbarHeight
{
    return [HWStyle statusbarHeight] + 44;
}
+ (CGFloat)toolbarHeight
{
    if ([HWDevice getDeviceType] == EDeviceType_X) {
        return 83;
    }
    return 49;
}
+ (CGFloat)tabbarExtensionHeight
{
    if ([HWDevice getDeviceType] == EDeviceType_X) {
        return 34.0;
    }
    return 0;
}
+ (CGFloat)activityIndicatorSize
{
     return 32.0f;
}
+ (CGFloat)loadingOffsetYInListView
{
    return [HWDevice isUnderIPhone5] ? 130.f : 145.0f;
}
+ (CGFloat)emptyOffsetYInListView
{
    return [HWDevice isUnderIPhone5] ? 115.f : 130.0f;
}
+ (CGFloat)failOffsetYInListView
{
    return [HWDevice isUnderIPhone5] ? 115.f : 130.0f;
}
+ (CGFloat)separatorLineHeight
{
    return 0.5f;
}
+ (CGFloat)separatorLeftMargin
{
    return floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 ? 15.0f : 10.0;
}
+ (CGFloat)buttonCornerRadius
{
    return 5.0f;
}
+ (CGFloat)viewPagerCursorHeight
{
     return [HWDevice isUnderIPhone5] ? 4.0f : 5.0f;
}
+ (CGFloat)viewPagerHeight
{
    return [HWDevice isUnderIPhone5] ? 34.0f : 44.0f;
}
+ (CGFloat)buttonBorderWidth
{
   return 1.0f;
}
+ (CGRect)fullScrTableFrame:(BOOL)inTab
{
    CGFloat dy = [HWStyle navigationbarHeight];
    if (inTab) {
        dy += [HWStyle toolbarHeight];
    }
    CGRect frame = [UIScreen mainScreen].bounds;
    return CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - dy);
}
+ (CGRect)viewPagerFrame
{
    CGRect frame = [UIScreen mainScreen].bounds;
    return CGRectMake(0, 0.0f, frame.size.width, [HWStyle viewPagerHeight]);
}
+ (CGRect)viewReminderFrame
{
    CGRect frame = [UIScreen mainScreen].bounds;
    return CGRectMake(0, 0.0f, frame.size.width, 50.0);
}
#pragma mark - theme color
+ (UIColor *)greenThemeColor
{
    return [UIColor colorWithRed:0x06/255.f green:0x99/255.f blue:0x91/255.f alpha:1.0];
}
+ (UIColor *)redThemeColor
{
    return [UIColor colorWithRed:0xea/255.f green:0x55/255.f blue:0x50/255.f alpha:1.0];
}
#pragma mark - font color
+ (UIColor *)blackTextColor
{
    return [UIColor colorWithRed:0x2a/255.f green:0x2a/255.f blue:0x2a/255.f alpha:1.0];
}
+ (UIColor *)darkGrayTextColor
{
    return [UIColor colorWithRed:0x70/255.f green:0x70/255.f blue:0x70/255.f alpha:1.0];
}
+ (UIColor *)grayTextColor
{
    return [UIColor colorWithRed:0x9a/255.f green:0x9a/255.f blue:0x9a/255.f alpha:1.0];
}
+ (UIColor *)lightGrayTextColor
{
    return [UIColor colorWithRed:0xcc/255.f green:0xcc/255.f blue:0xcc/255.f alpha:1.0];
}
+ (UIColor *)whiteTextColor
{
    return [UIColor whiteColor];
}
#pragma mark - line color
+ (UIColor *)darkGrayLineColor
{
    return [UIColor colorWithRed:0xc2/255.f green:0xc2/255.f blue:0xc2/255.f alpha:1.0];
}
+ (UIColor *)grayLineColor
{
    return [UIColor colorWithRed:0xe6/255.f green:0xe6/255.f blue:0xe6/255.f alpha:1.0];
}
+ (UIColor *)lightBackGroundColor
{
    return [UIColor colorWithRed:0xfa/255.f green:0xfa/255.f blue:0xfa/255.f alpha:1.0];
}
+ (UIColor *)backGroundColor
{
    return [UIColor colorWithRed:0xf7/255.f green:0xf6/255.f blue:0xf6/255.f alpha:1.0];
}
#pragma mark - color
+ (UIColor *)color1
{
    return [UIColor colorWithRed:0x26/255.0 green:0x68/255.0 blue:0x35/255.0 alpha:1.0];
}
+ (UIColor *)color2
{
    return [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0];
}
+ (UIColor *)color3
{
    return [UIColor colorWithRed:0x66/255.0 green:0x66/255.0 blue:0x66/255.0 alpha:1.0];
}
+ (UIColor *)color4
{
    return [UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1.0];
}
#pragma mark - font style
+ (UIFont *)normalFont
{
    return [UIFont systemFontOfSize:14.0];
}
+ (UIFont *)smallerFont
{
    return [UIFont systemFontOfSize:12.0];
}
+ (UIFont *)largerFont
{
    return [UIFont systemFontOfSize:18.0];
}
+ (UIFont *)larger2Font
{
    return [UIFont systemFontOfSize:16.0];
}
+ (UIFont *)largerBoldFont
{
    return [UIFont boldSystemFontOfSize:18.0];
}
+ (UIFont *)larger2BoldFont
{
    return [UIFont boldSystemFontOfSize:16.0];
}
#pragma mark - font height
+ (CGFloat)normalFontHeight
{
    return [HWUtil textSize:@"chow" font:[self normalFont] bounding:CGSizeZero].height;
}
+ (CGFloat)largeFontHeight
{
    return [HWUtil textSize:@"chow" font:[self largerFont] bounding:CGSizeZero].height;
}
+ (CGFloat)large2FontHeight
{
    return [HWUtil textSize:@"chow" font:[self larger2Font] bounding:CGSizeZero].height;
}
+ (CGFloat)large2BoldFontHeight
{
    return [HWUtil textSize:@"chow" font:[self larger2BoldFont] bounding:CGSizeZero].height;
}
+ (CGFloat)largeBoldFontHeight
{
    return [HWUtil textSize:@"chow" font:[self largerBoldFont] bounding:CGSizeZero].height;
}
+ (CGFloat)smallFontHeight
{
    return [HWUtil textSize:@"chow" font:[self smallerFont] bounding:CGSizeZero].height;
}
@end
