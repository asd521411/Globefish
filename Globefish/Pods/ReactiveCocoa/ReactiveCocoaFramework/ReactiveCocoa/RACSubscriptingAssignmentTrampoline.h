#import <Foundation/Foundation.h>
#import "RACEXTKeyPathCoding.h"
@class RACSignal;
#define RAC(TARGET, ...) \
    metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        (RAC_(TARGET, __VA_ARGS__, nil)) \
        (RAC_(TARGET, __VA_ARGS__))
#define RAC_(TARGET, KEYPATH, NILVALUE) \
    [[RACSubscriptingAssignmentTrampoline alloc] initWithTarget:(TARGET) nilValue:(NILVALUE)][@keypath(TARGET, KEYPATH)]
@interface RACSubscriptingAssignmentTrampoline : NSObject
- (id)initWithTarget:(id)target nilValue:(id)nilValue;
- (void)setObject:(RACSignal *)signal forKeyedSubscript:(NSString *)keyPath;
@end
