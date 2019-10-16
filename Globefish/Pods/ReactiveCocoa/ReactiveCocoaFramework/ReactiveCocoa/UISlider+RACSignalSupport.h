#import <UIKit/UIKit.h>
@class RACChannelTerminal;
@interface UISlider (RACSignalSupport)
- (RACChannelTerminal *)rac_newValueChannelWithNilValue:(NSNumber *)nilValue;
@end
