#import "RACSignal.h"
#import "RACSubscriber.h"
@class RACChannelTerminal;
@interface RACChannel : NSObject
@property (nonatomic, strong, readonly) RACChannelTerminal *leadingTerminal;
@property (nonatomic, strong, readonly) RACChannelTerminal *followingTerminal;
@end
@interface RACChannelTerminal : RACSignal <RACSubscriber>
- (id)init __attribute__((unavailable("Instantiate a RACChannel instead")));
@end
