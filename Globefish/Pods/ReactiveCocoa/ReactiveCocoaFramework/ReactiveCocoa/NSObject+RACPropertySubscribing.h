#import <Foundation/Foundation.h>
#import "RACEXTKeyPathCoding.h"
#import "RACmetamacros.h"
#define RACObserve(TARGET, KEYPATH) \
    [(id)(TARGET) rac_valuesForKeyPath:@keypath(TARGET, KEYPATH) observer:self]
@class RACDisposable;
@class RACSignal;
@interface NSObject (RACPropertySubscribing)
- (RACSignal *)rac_valuesForKeyPath:(NSString *)keyPath observer:(NSObject *)observer;
- (RACSignal *)rac_valuesAndChangesForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options observer:(NSObject *)observer;
@end
#define RACAble(...) \
    metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        (_RACAbleObject(self, __VA_ARGS__)) \
        (_RACAbleObject(__VA_ARGS__))
#define _RACAbleObject(object, property) [object rac_signalForKeyPath:@keypath(object, property) observer:self]
#define RACAbleWithStart(...) \
    metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        (_RACAbleWithStartObject(self, __VA_ARGS__)) \
        (_RACAbleWithStartObject(__VA_ARGS__))
#define _RACAbleWithStartObject(object, property) [object rac_signalWithStartingValueForKeyPath:@keypath(object, property) observer:self]
@interface NSObject (RACPropertySubscribingDeprecated)
+ (RACSignal *)rac_signalFor:(NSObject *)object keyPath:(NSString *)keyPath observer:(NSObject *)observer __attribute__((deprecated("Use -rac_valuesForKeyPath:observer: or RACObserve() instead.")));
+ (RACSignal *)rac_signalWithStartingValueFor:(NSObject *)object keyPath:(NSString *)keyPath observer:(NSObject *)observer __attribute__((deprecated("Use -rac_valuesForKeyPath:observer: or RACObserve() instead.")));
+ (RACSignal *)rac_signalWithChangesFor:(NSObject *)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options observer:(NSObject *)observer __attribute__((deprecated("Use -rac_valuesAndChangesForKeyPath:options:observer: instead.")));
- (RACSignal *)rac_signalForKeyPath:(NSString *)keyPath observer:(NSObject *)observer __attribute__((deprecated("Use -rac_valuesForKeyPath:observer: or RACObserve() instead.")));
- (RACSignal *)rac_signalWithStartingValueForKeyPath:(NSString *)keyPath observer:(NSObject *)observer __attribute__((deprecated("Use -rac_valuesForKeyPath:observer: or RACObserve() instead.")));
- (RACDisposable *)rac_deriveProperty:(NSString *)keyPath from:(RACSignal *)signal __attribute__((deprecated("Use -[RACSignal setKeyPath:onObject:] instead")));
@end
