#import <Foundation/Foundation.h>
@class RACScheduler;
@class RACSignal;
@interface NSString (RACSupport)
+ (RACSignal *)rac_readContentsOfURL:(NSURL *)URL usedEncoding:(NSStringEncoding *)encoding scheduler:(RACScheduler *)scheduler;
@end
