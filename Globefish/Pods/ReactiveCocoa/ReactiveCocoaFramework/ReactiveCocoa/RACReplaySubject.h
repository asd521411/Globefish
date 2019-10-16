#import "RACSubject.h"
extern const NSUInteger RACReplaySubjectUnlimitedCapacity;
@interface RACReplaySubject : RACSubject
+ (instancetype)replaySubjectWithCapacity:(NSUInteger)capacity;
@end
