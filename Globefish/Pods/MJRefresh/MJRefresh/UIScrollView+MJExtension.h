#import <UIKit/UIKit.h>
@interface UIScrollView (MJExtension)
@property (readonly, nonatomic) UIEdgeInsets mj_inset;
@property (assign, nonatomic) CGFloat mj_insetT;
@property (assign, nonatomic) CGFloat mj_insetB;
@property (assign, nonatomic) CGFloat mj_insetL;
@property (assign, nonatomic) CGFloat mj_insetR;
@property (assign, nonatomic) CGFloat mj_offsetX;
@property (assign, nonatomic) CGFloat mj_offsetY;
@property (assign, nonatomic) CGFloat mj_contentW;
@property (assign, nonatomic) CGFloat mj_contentH;
@end
