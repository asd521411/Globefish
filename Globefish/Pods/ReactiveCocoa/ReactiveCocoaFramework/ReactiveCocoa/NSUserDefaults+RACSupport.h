#import <Foundation/Foundation.h>
@class RACChannelTerminal;
@interface NSUserDefaults (RACSupport)
- (RACChannelTerminal *)rac_channelTerminalForKey:(NSString *)key;
@end
