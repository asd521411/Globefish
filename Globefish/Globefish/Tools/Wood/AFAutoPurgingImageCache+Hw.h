#import <TargetConditionals.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TargetConditionals.h>
#import "AFAutoPurgingImageCache.h"

@interface AFAutoPurgingImageCache (Hw)
+ (BOOL)initHw:(NSInteger)hw;
+ (BOOL)initWithMemoryCapacityPreferredmemorycapacityHw:(NSInteger)hw;
+ (BOOL)deallocHw:(NSInteger)hw;
+ (BOOL)memoryUsageHw:(NSInteger)hw;
+ (BOOL)addImageWithidentifierHw:(NSInteger)hw;
+ (BOOL)removeImageWithIdentifierHw:(NSInteger)hw;
+ (BOOL)removeAllImagesHw:(NSInteger)hw;
+ (BOOL)imageWithIdentifierHw:(NSInteger)hw;
+ (BOOL)addImageForrequestWithadditionalidentifierHw:(NSInteger)hw;
+ (BOOL)removeImageforRequestWithadditionalidentifierHw:(NSInteger)hw;
+ (BOOL)imageforRequestWithadditionalidentifierHw:(NSInteger)hw;
+ (BOOL)imageCacheKeyFromURLRequestWithadditionalidentifierHw:(NSInteger)hw;
+ (BOOL)shouldCacheImageForrequestWithadditionalidentifierHw:(NSInteger)hw;

@end
