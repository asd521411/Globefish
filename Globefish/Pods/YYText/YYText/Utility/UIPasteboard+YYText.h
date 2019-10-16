#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIPasteboard (YYText)
@property (nullable, nonatomic, copy) NSData *yy_PNGData;    
@property (nullable, nonatomic, copy) NSData *yy_JPEGData;   
@property (nullable, nonatomic, copy) NSData *yy_GIFData;    
@property (nullable, nonatomic, copy) NSData *yy_WEBPData;   
@property (nullable, nonatomic, copy) NSData *yy_ImageData;  
@property (nullable, nonatomic, copy) NSAttributedString *yy_AttributedString;
@end
UIKIT_EXTERN NSString *const YYTextPasteboardTypeAttributedString;
UIKIT_EXTERN NSString *const YYTextUTTypeWEBP;
NS_ASSUME_NONNULL_END
