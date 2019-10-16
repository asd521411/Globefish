#import <Foundation/Foundation.h>
#import "RACStream.h"
@class RACDisposable;
@class RACScheduler;
@class RACSubject;
@protocol RACSubscriber;
@interface RACSignal : RACStream
+ (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe;
+ (RACSignal *)error:(NSError *)error;
+ (RACSignal *)never;
+ (RACSignal *)startEagerlyWithScheduler:(RACScheduler *)scheduler block:(void (^)(id<RACSubscriber> subscriber))block;
+ (RACSignal *)startLazilyWithScheduler:(RACScheduler *)scheduler block:(void (^)(id<RACSubscriber> subscriber))block;
@end
@interface RACSignal (RACStream)
+ (RACSignal *)return:(id)value;
+ (RACSignal *)empty;
- (RACSignal *)concat:(RACSignal *)signal;
- (RACSignal *)zipWith:(RACSignal *)signal;
@end
@interface RACSignal (Subscription)
- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber;
- (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock;
- (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock completed:(void (^)(void))completedBlock;
- (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock completed:(void (^)(void))completedBlock;
- (RACDisposable *)subscribeError:(void (^)(NSError *error))errorBlock;
- (RACDisposable *)subscribeCompleted:(void (^)(void))completedBlock;
- (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock;
- (RACDisposable *)subscribeError:(void (^)(NSError *error))errorBlock completed:(void (^)(void))completedBlock;
@end
@interface RACSignal (Debugging)
- (RACSignal *)logAll;
- (RACSignal *)logNext;
- (RACSignal *)logError;
- (RACSignal *)logCompleted;
@end
@interface RACSignal (Testing)
- (id)asynchronousFirstOrDefault:(id)defaultValue success:(BOOL *)success error:(NSError **)error;
- (BOOL)asynchronouslyWaitUntilCompleted:(NSError **)error;
@end
@interface RACSignal (Deprecated)
+ (RACSignal *)start:(id (^)(BOOL *success, NSError **error))block __attribute__((deprecated("Use +startEagerlyWithScheduler:block: instead")));
+ (RACSignal *)startWithScheduler:(RACScheduler *)scheduler subjectBlock:(void (^)(RACSubject *subject))block __attribute__((deprecated("Use +startEagerlyWithScheduler:block: instead")));
+ (RACSignal *)startWithScheduler:(RACScheduler *)scheduler block:(id (^)(BOOL *success, NSError **error))block __attribute__((deprecated("Use +startEagerlyWithScheduler:block: instead")));
@end
