#import "RACQueueScheduler.h"
@interface RACTargetQueueScheduler : RACQueueScheduler
- (id)initWithName:(NSString *)name targetQueue:(dispatch_queue_t)targetQueue;
@end
