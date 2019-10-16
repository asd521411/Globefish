#import <UIKit/UIKit.h>
@class RACSignal;
@interface UITableViewHeaderFooterView (RACSignalSupport)
@property (nonatomic, strong, readonly) RACSignal *rac_prepareForReuseSignal;
@end
