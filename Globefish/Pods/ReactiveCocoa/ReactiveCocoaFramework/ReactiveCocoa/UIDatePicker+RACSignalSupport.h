#import <UIKit/UIKit.h>
@class RACChannelTerminal;
@interface UIDatePicker (RACSignalSupport)
- (RACChannelTerminal *)rac_newDateChannelWithNilValue:(NSDate *)nilValue;
@end
