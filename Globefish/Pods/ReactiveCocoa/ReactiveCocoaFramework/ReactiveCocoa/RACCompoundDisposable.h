#import "RACDisposable.h"
@interface RACCompoundDisposable : RACDisposable
+ (instancetype)compoundDisposable;
+ (instancetype)compoundDisposableWithDisposables:(NSArray *)disposables;
- (void)addDisposable:(RACDisposable *)disposable;
- (void)removeDisposable:(RACDisposable *)disposable;
@end
