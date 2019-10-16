#import "RACQueueScheduler.h"
@interface RACQueueScheduler ()
@property (nonatomic, readonly) dispatch_queue_t queue;
- (id)initWithName:(NSString *)name queue:(dispatch_queue_t)queue;
- (void)performAsCurrentScheduler:(void (^)(void))block;
+ (dispatch_time_t)wallTimeWithDate:(NSDate *)date;
@end
