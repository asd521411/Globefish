#import <Foundation/Foundation.h>
@class RACDisposable;
@class RACKVOTrampoline;
@interface NSObject (RACKVOWrapper)
- (RACDisposable *)rac_observeKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options observer:(NSObject *)observer block:(void (^)(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent))block;
@end
typedef void (^RACKVOBlock)(id target, id observer, NSDictionary *change);
@interface NSObject (RACKVOWrapperDeprecated)
- (RACKVOTrampoline *)rac_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(RACKVOBlock)block __attribute((deprecated("Use rac_observeKeyPath:options:observer:block: instead.")));
@end
