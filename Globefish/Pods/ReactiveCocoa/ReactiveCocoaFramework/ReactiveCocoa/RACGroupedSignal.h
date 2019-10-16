#import "RACSubject.h"
@interface RACGroupedSignal : RACSubject
@property (nonatomic, readonly, copy) id<NSCopying> key;
+ (instancetype)signalWithKey:(id<NSCopying>)key;
@end
