#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#ifndef YYTEXT_CLAMP 
#define YYTEXT_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif
#ifndef YYTEXT_SWAP 
#define YYTEXT_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif
NS_ASSUME_NONNULL_BEGIN
static inline BOOL YYTextIsLinebreakChar(unichar c) {
    switch (c) {
        case 0x000D:
        case 0x2028:
        case 0x000A:
        case 0x2029:
            return YES;
        default:
            return NO;
    }
}
static inline BOOL YYTextIsLinebreakString(NSString * _Nullable str) {
    if (str.length > 2 || str.length == 0) return NO;
    if (str.length == 1) {
        unichar c = [str characterAtIndex:0];
        return YYTextIsLinebreakChar(c);
    } else {
        return ([str characterAtIndex:0] == '\r') && ([str characterAtIndex:1] == '\n');
    }
}
static inline NSUInteger YYTextLinebreakTailLength(NSString * _Nullable str) {
    if (str.length >= 2) {
        unichar c2 = [str characterAtIndex:str.length - 1];
        if (YYTextIsLinebreakChar(c2)) {
            unichar c1 = [str characterAtIndex:str.length - 2];
            if (c1 == '\r' && c2 == '\n') return 2;
            else return 1;
        } else {
            return 0;
        }
    } else if (str.length == 1) {
        return YYTextIsLinebreakChar([str characterAtIndex:0]) ? 1 : 0;
    } else {
        return 0;
    }
}
static inline NSTextCheckingType YYTextNSTextCheckingTypeFromUIDataDetectorType(UIDataDetectorTypes types) {
    NSTextCheckingType t = 0;
    if (types & UIDataDetectorTypePhoneNumber) t |= NSTextCheckingTypePhoneNumber;
    if (types & UIDataDetectorTypeLink) t |= NSTextCheckingTypeLink;
    if (types & UIDataDetectorTypeAddress) t |= NSTextCheckingTypeAddress;
    if (types & UIDataDetectorTypeCalendarEvent) t |= NSTextCheckingTypeDate;
    return t;
}
static inline BOOL YYTextUIFontIsEmoji(UIFont *font) {
    return [font.fontName isEqualToString:@"AppleColorEmoji"];
}
static inline BOOL YYTextCTFontIsEmoji(CTFontRef font) {
    BOOL isEmoji = NO;
    CFStringRef name = CTFontCopyPostScriptName(font);
    if (name && CFEqual(CFSTR("AppleColorEmoji"), name)) isEmoji = YES;
    if (name) CFRelease(name);
    return isEmoji;
}
static inline BOOL YYTextCGFontIsEmoji(CGFontRef font) {
    BOOL isEmoji = NO;
    CFStringRef name = CGFontCopyPostScriptName(font);
    if (name && CFEqual(CFSTR("AppleColorEmoji"), name)) isEmoji = YES;
    if (name) CFRelease(name);
    return isEmoji;
}
static inline BOOL YYTextCTFontContainsColorBitmapGlyphs(CTFontRef font) {
    return  (CTFontGetSymbolicTraits(font) & kCTFontTraitColorGlyphs) != 0;
}
static inline BOOL YYTextCGGlyphIsBitmap(CTFontRef font, CGGlyph glyph) {
    if (!font && !glyph) return NO;
    if (!YYTextCTFontContainsColorBitmapGlyphs(font)) return NO;
    CGPathRef path = CTFontCreatePathForGlyph(font, glyph, NULL);
    if (path) {
        CFRelease(path);
        return NO;
    }
    return YES;
}
static inline CGFloat YYTextEmojiGetAscentWithFontSize(CGFloat fontSize) {
    if (fontSize < 16) {
        return 1.25 * fontSize;
    } else if (16 <= fontSize && fontSize <= 24) {
        return 0.5 * fontSize + 12;
    } else {
        return fontSize;
    }
}
static inline CGFloat YYTextEmojiGetDescentWithFontSize(CGFloat fontSize) {
    if (fontSize < 16) {
        return 0.390625 * fontSize;
    } else if (16 <= fontSize && fontSize <= 24) {
        return 0.15625 * fontSize + 3.75;
    } else {
        return 0.3125 * fontSize;
    }
    return 0;
}
static inline CGRect YYTextEmojiGetGlyphBoundingRectWithFontSize(CGFloat fontSize) {
    CGRect rect;
    rect.origin.x = 0.75;
    rect.size.width = rect.size.height = YYTextEmojiGetAscentWithFontSize(fontSize);
    if (fontSize < 16) {
        rect.origin.y = -0.2525 * fontSize;
    } else if (16 <= fontSize && fontSize <= 24) {
        rect.origin.y = 0.1225 * fontSize -6;
    } else {
        rect.origin.y = -0.1275 * fontSize;
    }
    return rect;
}
NSCharacterSet *YYTextVerticalFormRotateCharacterSet();
NSCharacterSet *YYTextVerticalFormRotateAndMoveCharacterSet();
static inline CGFloat YYTextDegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}
static inline CGFloat YYTextRadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}
static inline CGFloat YYTextCGAffineTransformGetRotation(CGAffineTransform transform) {
    return atan2(transform.b, transform.a);
}
static inline CGFloat YYTextCGAffineTransformGetScaleX(CGAffineTransform transform) {
    return  sqrt(transform.a * transform.a + transform.c * transform.c);
}
static inline CGFloat YYTextCGAffineTransformGetScaleY(CGAffineTransform transform) {
    return sqrt(transform.b * transform.b + transform.d * transform.d);
}
static inline CGFloat YYTextCGAffineTransformGetTranslateX(CGAffineTransform transform) {
    return transform.tx;
}
static inline CGFloat YYTextCGAffineTransformGetTranslateY(CGAffineTransform transform) {
    return transform.ty;
}
CGAffineTransform YYTextCGAffineTransformGetFromPoints(CGPoint before[3], CGPoint after[3]);
CGAffineTransform YYTextCGAffineTransformGetFromViews(UIView *from, UIView *to);
static inline CGAffineTransform YYTextCGAffineTransformMakeSkew(CGFloat x, CGFloat y){
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}
static inline UIEdgeInsets YYTextUIEdgeInsetsInvert(UIEdgeInsets insets) {
    return UIEdgeInsetsMake(-insets.top, -insets.left, -insets.bottom, -insets.right);
}
UIViewContentMode YYTextCAGravityToUIViewContentMode(NSString *gravity);
NSString *YYTextUIViewContentModeToCAGravity(UIViewContentMode contentMode);
CGRect YYTextCGRectFitWithContentMode(CGRect rect, CGSize size, UIViewContentMode mode);
static inline CGPoint YYTextCGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}
static inline CGFloat YYTextCGRectGetArea(CGRect rect) {
    if (CGRectIsNull(rect)) return 0;
    rect = CGRectStandardize(rect);
    return rect.size.width * rect.size.height;
}
static inline CGFloat YYTextCGPointGetDistanceToPoint(CGPoint p1, CGPoint p2) {
    return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}
static inline CGFloat YYTextCGPointGetDistanceToRect(CGPoint p, CGRect r) {
    r = CGRectStandardize(r);
    if (CGRectContainsPoint(r, p)) return 0;
    CGFloat distV, distH;
    if (CGRectGetMinY(r) <= p.y && p.y <= CGRectGetMaxY(r)) {
        distV = 0;
    } else {
        distV = p.y < CGRectGetMinY(r) ? CGRectGetMinY(r) - p.y : p.y - CGRectGetMaxY(r);
    }
    if (CGRectGetMinX(r) <= p.x && p.x <= CGRectGetMaxX(r)) {
        distH = 0;
    } else {
        distH = p.x < CGRectGetMinX(r) ? CGRectGetMinX(r) - p.x : p.x - CGRectGetMaxX(r);
    }
    return MAX(distV, distH);
}
CGFloat YYTextScreenScale();
CGSize YYTextScreenSize();
static inline CGFloat YYTextCGFloatToPixel(CGFloat value) {
    return value * YYTextScreenScale();
}
static inline CGFloat YYTextCGFloatFromPixel(CGFloat value) {
    return value / YYTextScreenScale();
}
static inline CGFloat YYTextCGFloatPixelFloor(CGFloat value) {
    CGFloat scale = YYTextScreenScale();
    return floor(value * scale) / scale;
}
static inline CGFloat YYTextCGFloatPixelRound(CGFloat value) {
    CGFloat scale = YYTextScreenScale();
    return round(value * scale) / scale;
}
static inline CGFloat YYTextCGFloatPixelCeil(CGFloat value) {
    CGFloat scale = YYTextScreenScale();
    return ceil(value * scale) / scale;
}
static inline CGFloat YYTextCGFloatPixelHalf(CGFloat value) {
    CGFloat scale = YYTextScreenScale();
    return (floor(value * scale) + 0.5) / scale;
}
static inline CGPoint YYTextCGPointPixelFloor(CGPoint point) {
    CGFloat scale = YYTextScreenScale();
    return CGPointMake(floor(point.x * scale) / scale,
                       floor(point.y * scale) / scale);
}
static inline CGPoint YYTextCGPointPixelRound(CGPoint point) {
    CGFloat scale = YYTextScreenScale();
    return CGPointMake(round(point.x * scale) / scale,
                       round(point.y * scale) / scale);
}
static inline CGPoint YYTextCGPointPixelCeil(CGPoint point) {
    CGFloat scale = YYTextScreenScale();
    return CGPointMake(ceil(point.x * scale) / scale,
                       ceil(point.y * scale) / scale);
}
static inline CGPoint YYTextCGPointPixelHalf(CGPoint point) {
    CGFloat scale = YYTextScreenScale();
    return CGPointMake((floor(point.x * scale) + 0.5) / scale,
                       (floor(point.y * scale) + 0.5) / scale);
}
static inline CGSize YYTextCGSizePixelFloor(CGSize size) {
    CGFloat scale = YYTextScreenScale();
    return CGSizeMake(floor(size.width * scale) / scale,
                      floor(size.height * scale) / scale);
}
static inline CGSize YYTextCGSizePixelRound(CGSize size) {
    CGFloat scale = YYTextScreenScale();
    return CGSizeMake(round(size.width * scale) / scale,
                      round(size.height * scale) / scale);
}
static inline CGSize YYTextCGSizePixelCeil(CGSize size) {
    CGFloat scale = YYTextScreenScale();
    return CGSizeMake(ceil(size.width * scale) / scale,
                      ceil(size.height * scale) / scale);
}
static inline CGSize YYTextCGSizePixelHalf(CGSize size) {
    CGFloat scale = YYTextScreenScale();
    return CGSizeMake((floor(size.width * scale) + 0.5) / scale,
                      (floor(size.height * scale) + 0.5) / scale);
}
static inline CGRect YYTextCGRectPixelFloor(CGRect rect) {
    CGPoint origin = YYTextCGPointPixelCeil(rect.origin);
    CGPoint corner = YYTextCGPointPixelFloor(CGPointMake(rect.origin.x + rect.size.width,
                                                     rect.origin.y + rect.size.height));
    CGRect ret = CGRectMake(origin.x, origin.y, corner.x - origin.x, corner.y - origin.y);
    if (ret.size.width < 0) ret.size.width = 0;
    if (ret.size.height < 0) ret.size.height = 0;
    return ret;
}
static inline CGRect YYTextCGRectPixelRound(CGRect rect) {
    CGPoint origin = YYTextCGPointPixelRound(rect.origin);
    CGPoint corner = YYTextCGPointPixelRound(CGPointMake(rect.origin.x + rect.size.width,
                                                     rect.origin.y + rect.size.height));
    return CGRectMake(origin.x, origin.y, corner.x - origin.x, corner.y - origin.y);
}
static inline CGRect YYTextCGRectPixelCeil(CGRect rect) {
    CGPoint origin = YYTextCGPointPixelFloor(rect.origin);
    CGPoint corner = YYTextCGPointPixelCeil(CGPointMake(rect.origin.x + rect.size.width,
                                                    rect.origin.y + rect.size.height));
    return CGRectMake(origin.x, origin.y, corner.x - origin.x, corner.y - origin.y);
}
static inline CGRect YYTextCGRectPixelHalf(CGRect rect) {
    CGPoint origin = YYTextCGPointPixelHalf(rect.origin);
    CGPoint corner = YYTextCGPointPixelHalf(CGPointMake(rect.origin.x + rect.size.width,
                                                    rect.origin.y + rect.size.height));
    return CGRectMake(origin.x, origin.y, corner.x - origin.x, corner.y - origin.y);
}
static inline UIEdgeInsets YYTextUIEdgeInsetPixelFloor(UIEdgeInsets insets) {
    insets.top = YYTextCGFloatPixelFloor(insets.top);
    insets.left = YYTextCGFloatPixelFloor(insets.left);
    insets.bottom = YYTextCGFloatPixelFloor(insets.bottom);
    insets.right = YYTextCGFloatPixelFloor(insets.right);
    return insets;
}
static inline UIEdgeInsets YYTextUIEdgeInsetPixelCeil(UIEdgeInsets insets) {
    insets.top = YYTextCGFloatPixelCeil(insets.top);
    insets.left = YYTextCGFloatPixelCeil(insets.left);
    insets.bottom = YYTextCGFloatPixelCeil(insets.bottom);
    insets.right = YYTextCGFloatPixelCeil(insets.right);
    return insets;
}
static inline UIFont * _Nullable YYTextFontWithBold(UIFont *font) {
    if (![font respondsToSelector:@selector(fontDescriptor)]) return font;
    return [UIFont fontWithDescriptor:[font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold] size:font.pointSize];
}
static inline UIFont * _Nullable YYTextFontWithItalic(UIFont *font) {
    if (![font respondsToSelector:@selector(fontDescriptor)]) return font;
    return [UIFont fontWithDescriptor:[font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic] size:font.pointSize];
}
static inline UIFont * _Nullable YYTextFontWithBoldItalic(UIFont *font) {
    if (![font respondsToSelector:@selector(fontDescriptor)]) return font;
    return [UIFont fontWithDescriptor:[font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold | UIFontDescriptorTraitItalic] size:font.pointSize];
}
static inline NSRange YYTextNSRangeFromCFRange(CFRange range) {
    return NSMakeRange(range.location, range.length);
}
static inline CFRange YYTextCFRangeFromNSRange(NSRange range) {
    return CFRangeMake(range.location, range.length);
}
BOOL YYTextIsAppExtension();
UIApplication * _Nullable YYTextSharedApplication();
NS_ASSUME_NONNULL_END
