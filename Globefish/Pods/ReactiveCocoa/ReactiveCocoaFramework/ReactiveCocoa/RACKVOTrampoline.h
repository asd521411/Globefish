#import <Foundation/Foundation.h>
#import "NSObject+RACKVOWrapper.h"
#import "RACDisposable.h"
@interface RACKVOTrampoline : RACDisposable
- (id)initWithTarget:(NSObject *)target observer:(NSObject *)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(RACKVOBlock)block;
@end
