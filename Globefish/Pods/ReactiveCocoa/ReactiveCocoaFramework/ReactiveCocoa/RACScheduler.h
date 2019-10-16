#import <Foundation/Foundation.h>
typedef enum : long {
	RACSchedulerPriorityHigh = DISPATCH_QUEUE_PRIORITY_HIGH,
	RACSchedulerPriorityDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT,
	RACSchedulerPriorityLow = DISPATCH_QUEUE_PRIORITY_LOW,
	RACSchedulerPriorityBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
} RACSchedulerPriority;
typedef void (^RACSchedulerRecursiveBlock)(void (^reschedule)(void));
@class RACDisposable;
@interface RACScheduler : NSObject
+ (RACScheduler *)immediateScheduler;
+ (RACScheduler *)mainThreadScheduler;
+ (RACScheduler *)schedulerWithPriority:(RACSchedulerPriority)priority name:(NSString *)name;
+ (RACScheduler *)schedulerWithPriority:(RACSchedulerPriority)priority;
+ (RACScheduler *)scheduler;
+ (RACScheduler *)currentScheduler;
- (RACDisposable *)schedule:(void (^)(void))block;
- (RACDisposable *)after:(NSDate *)date schedule:(void (^)(void))block;
- (RACDisposable *)afterDelay:(NSTimeInterval)delay schedule:(void (^)(void))block;
- (RACDisposable *)after:(NSDate *)date repeatingEvery:(NSTimeInterval)interval withLeeway:(NSTimeInterval)leeway schedule:(void (^)(void))block;
- (RACDisposable *)scheduleRecursiveBlock:(RACSchedulerRecursiveBlock)recursiveBlock;
@end
@interface RACScheduler (Deprecated)
+ (RACScheduler *)schedulerWithQueue:(dispatch_queue_t)queue name:(NSString *)name __attribute__((deprecated("Use -[RACScheduler initWithName:targetQueue:] instead.")));
@end
