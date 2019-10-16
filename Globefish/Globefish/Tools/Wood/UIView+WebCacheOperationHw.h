#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"
#import "UIView+WebCacheOperation.h"
#import "objc/runtime.h"

@interface UIView (WebCacheOperationHw)
+ (BOOL)operationDictionaryHw:(NSInteger)hw;
+ (BOOL)sd_setImageLoadOperationForkeyHw:(NSInteger)hw;
+ (BOOL)sd_cancelImageLoadOperationWithKeyHw:(NSInteger)hw;
+ (BOOL)sd_removeImageLoadOperationWithKeyHw:(NSInteger)hw;

@end
