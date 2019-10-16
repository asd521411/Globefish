#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSParagraphStyle (YYText)
+ (nullable NSParagraphStyle *)yy_styleWithCTStyle:(CTParagraphStyleRef)CTStyle;
- (nullable CTParagraphStyleRef)yy_CTStyle CF_RETURNS_RETAINED;
@end
NS_ASSUME_NONNULL_END
