#import "RACMulticastConnection.h"
@class RACSubject;
@interface RACMulticastConnection ()
- (id)initWithSourceSignal:(RACSignal *)source subject:(RACSubject *)subject;
@end
