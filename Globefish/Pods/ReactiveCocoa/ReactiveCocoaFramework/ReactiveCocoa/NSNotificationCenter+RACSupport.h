#import <Foundation/Foundation.h>
@class RACSignal;
@interface NSNotificationCenter (RACSupport)
- (RACSignal *)rac_addObserverForName:(NSString *)notificationName object:(id)object;
@end
