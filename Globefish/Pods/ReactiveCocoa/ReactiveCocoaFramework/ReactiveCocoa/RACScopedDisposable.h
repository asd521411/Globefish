#import "RACDisposable.h"
@interface RACScopedDisposable : RACDisposable
+ (instancetype)scopedDisposableWithDisposable:(RACDisposable *)disposable;
@end
