#import <UIKit/UIKit.h>
@class RACSignal;
@interface UITableViewCell (RACSignalSupport)
@property (nonatomic, strong, readonly) RACSignal *rac_prepareForReuseSignal;
@end
