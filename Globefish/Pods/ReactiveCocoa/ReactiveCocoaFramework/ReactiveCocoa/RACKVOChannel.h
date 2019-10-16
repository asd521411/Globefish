#import "RACChannel.h"
#import "RACEXTKeyPathCoding.h"
#import "RACmetamacros.h"
#define RACChannelTo(TARGET, ...) \
    metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        (RACChannelTo_(TARGET, __VA_ARGS__, nil)) \
        (RACChannelTo_(TARGET, __VA_ARGS__))
#define RACChannelTo_(TARGET, KEYPATH, NILVALUE) \
    [[RACKVOChannel alloc] initWithTarget:(TARGET) keyPath:@keypath(TARGET, KEYPATH) nilValue:(NILVALUE)][@keypath(RACKVOChannel.new, followingTerminal)]
@interface RACKVOChannel : RACChannel
- (id)initWithTarget:(NSObject *)target keyPath:(NSString *)keyPath nilValue:(id)nilValue;
- (id)init __attribute__((unavailable("Use -initWithTarget:keyPath:nilValue: instead")));
@end
@interface RACKVOChannel (RACChannelTo)
- (RACChannelTerminal *)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(RACChannelTerminal *)otherTerminal forKeyedSubscript:(NSString *)key;
@end
