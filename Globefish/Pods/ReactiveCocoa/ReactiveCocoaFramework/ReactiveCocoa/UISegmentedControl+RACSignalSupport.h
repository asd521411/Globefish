#import <UIKit/UIKit.h>
@class RACChannelTerminal;
@interface UISegmentedControl (RACSignalSupport)
- (RACChannelTerminal *)rac_newSelectedSegmentIndexChannelWithNilValue:(NSNumber *)nilValue;
@end
