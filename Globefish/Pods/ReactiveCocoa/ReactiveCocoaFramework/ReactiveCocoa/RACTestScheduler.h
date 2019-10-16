#import "RACScheduler.h"
@interface RACTestScheduler : RACScheduler
- (instancetype)init;
- (void)step;
- (void)step:(NSUInteger)ticks;
- (void)stepAll;
@end
