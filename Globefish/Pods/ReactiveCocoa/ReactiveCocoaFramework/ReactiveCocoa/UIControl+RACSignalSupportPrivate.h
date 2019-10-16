#import <UIKit/UIKit.h>
@class RACChannelTerminal;
@interface UIControl (RACSignalSupportPrivate)
- (RACChannelTerminal *)rac_channelForControlEvents:(UIControlEvents)controlEvents key:(NSString *)key nilValue:(id)nilValue;
@end
