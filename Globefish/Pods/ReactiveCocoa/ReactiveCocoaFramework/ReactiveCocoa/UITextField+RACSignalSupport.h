#import <UIKit/UIKit.h>
@class RACChannelTerminal;
@class RACSignal;
@interface UITextField (RACSignalSupport)
- (RACSignal *)rac_textSignal;
- (RACChannelTerminal *)rac_newTextChannel;
@end
