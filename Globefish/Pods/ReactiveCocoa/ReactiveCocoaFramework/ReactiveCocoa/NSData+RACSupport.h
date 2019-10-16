#import <Foundation/Foundation.h>
@class RACScheduler;
@class RACSignal;
@interface NSData (RACSupport)
+ (RACSignal *)rac_readContentsOfURL:(NSURL *)URL options:(NSDataReadingOptions)options scheduler:(RACScheduler *)scheduler;
@end
