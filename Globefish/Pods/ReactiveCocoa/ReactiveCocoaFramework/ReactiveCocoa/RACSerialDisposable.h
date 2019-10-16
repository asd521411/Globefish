#import "RACDisposable.h"
@interface RACSerialDisposable : RACDisposable
@property (atomic, strong) RACDisposable *disposable;
+ (instancetype)serialDisposableWithDisposable:(RACDisposable *)disposable;
- (RACDisposable *)swapInDisposable:(RACDisposable *)newDisposable;
@end
