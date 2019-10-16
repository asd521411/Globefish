#import <Foundation/Foundation.h>
@class RACCompoundDisposable;
@protocol RACSubscriber <NSObject>
@required
- (void)sendNext:(id)value;
- (void)sendError:(NSError *)error;
- (void)sendCompleted;
- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable;
@end
