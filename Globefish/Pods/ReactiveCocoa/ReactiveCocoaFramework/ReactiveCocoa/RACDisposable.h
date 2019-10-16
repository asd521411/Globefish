#import <Foundation/Foundation.h>
@class RACScopedDisposable;
@interface RACDisposable : NSObject
@property (atomic, assign, getter = isDisposed, readonly) BOOL disposed;
+ (instancetype)disposableWithBlock:(void (^)(void))block;
- (void)dispose;
- (RACScopedDisposable *)asScopedDisposable;
@end
