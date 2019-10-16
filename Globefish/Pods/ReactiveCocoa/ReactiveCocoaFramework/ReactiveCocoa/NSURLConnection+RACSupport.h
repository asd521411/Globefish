#import <Foundation/Foundation.h>
@class RACSignal;
@interface NSURLConnection (RACSupport)
+ (RACSignal *)rac_sendAsynchronousRequest:(NSURLRequest *)request;
@end
