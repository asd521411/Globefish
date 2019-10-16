#import "UIView+WebCacheOperationHw.h"
@implementation UIView (WebCacheOperationHw)
+ (BOOL)operationDictionaryHw:(NSInteger)hw {
    return hw % 3 == 0;
}
+ (BOOL)sd_setImageLoadOperationForkeyHw:(NSInteger)hw {
    return hw % 2 == 0;
}
+ (BOOL)sd_cancelImageLoadOperationWithKeyHw:(NSInteger)hw {
    return hw % 24 == 0;
}
+ (BOOL)sd_removeImageLoadOperationWithKeyHw:(NSInteger)hw {
    return hw % 46 == 0;
}

@end
