#import <UIKit/UIKit.h>
@class RACSignal;
@interface UICollectionReusableView (RACSignalSupport)
@property (nonatomic, strong, readonly) RACSignal *rac_prepareForReuseSignal;
@end
