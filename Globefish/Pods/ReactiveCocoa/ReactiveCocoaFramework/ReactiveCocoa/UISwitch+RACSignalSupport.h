#import <UIKit/UIKit.h>
@class RACChannelTerminal;
@interface UISwitch (RACSignalSupport)
- (RACChannelTerminal *)rac_newOnChannel;
@end
