#import <UIKit/UIKit.h>
@class RACChannelTerminal;
@interface UIStepper (RACSignalSupport)
- (RACChannelTerminal *)rac_newValueChannelWithNilValue:(NSNumber *)nilValue;
@end
