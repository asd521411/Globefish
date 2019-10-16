#import "UIView+HWUtilView.h"
@implementation UIView (HWUtilView)
+ (void)HWShadowDraw:(UIView *)aim shadowColor:(UIColor *)color shadowOffset:(CGSize)size shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius{
    aim.layer.shadowColor = color.CGColor;
    aim.layer.shadowOffset = size;
    aim.layer.shadowOpacity = opacity;
    aim.layer.shadowRadius = radius;
    UIBezierPath *path = [UIBezierPath bezierPath];
    float width     = aim.bounds.size.width;
    float height    = aim.bounds.size.height;
    float x         = aim.bounds.origin.x;
    float y         = aim.bounds.origin.y;
    CGPoint topLeft         = aim.bounds.origin;
    CGPoint topMiddle       = CGPointMake(x+(width/2),y);
    CGPoint topRight        = CGPointMake(x+width,y);
    CGPoint rightMiddle     = CGPointMake(x+width,y+(height/2));
    CGPoint bottomRight     = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle    = CGPointMake(x+(width/2),y+height);
    CGPoint bottomLeft      = CGPointMake(x,y+height);
    CGPoint leftMiddle      = CGPointMake(x,y+(height/2));
    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    aim.layer.shadowPath = path.CGPath;
}
@end
