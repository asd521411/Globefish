#import <Foundation/Foundation.h>
@class RACTuple;
@interface RACBlockTrampoline : NSObject
+ (id)invokeBlock:(id)block withArguments:(RACTuple *)arguments;
@end
