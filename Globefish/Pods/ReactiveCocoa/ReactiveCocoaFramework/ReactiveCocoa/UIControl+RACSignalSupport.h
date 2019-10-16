#import <UIKit/UIKit.h>
@class RACSignal;
@interface UIControl (RACSignalSupport)
- (RACSignal *)rac_signalForControlEvents:(UIControlEvents)controlEvents;
@end
