#import <Foundation/Foundation.h>
@class RACCompoundDisposable;
@class RACDisposable;
@class RACSignal;
@interface NSObject (RACDeallocating)
@property (atomic, readonly, strong) RACCompoundDisposable *rac_deallocDisposable;
- (RACSignal *)rac_willDeallocSignal;
@end
@interface NSObject (RACDeallocatingDeprecated)
- (RACSignal *)rac_didDeallocSignal __attribute__((deprecated("Use -rac_willDeallocSignal")));
- (void)rac_addDeallocDisposable:(RACDisposable *)disposable __attribute__((deprecated("Add disposables to -rac_deallocDisposable instead")));
@end
