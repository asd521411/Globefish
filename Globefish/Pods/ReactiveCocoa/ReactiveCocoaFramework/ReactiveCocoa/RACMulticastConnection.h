#import <Foundation/Foundation.h>
@class RACDisposable;
@class RACSignal;
@interface RACMulticastConnection : NSObject
@property (nonatomic, strong, readonly) RACSignal *signal;
- (RACDisposable *)connect;
- (RACSignal *)autoconnect;
@end
