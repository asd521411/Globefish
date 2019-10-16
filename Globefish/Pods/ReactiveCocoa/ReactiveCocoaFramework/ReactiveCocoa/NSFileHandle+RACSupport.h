#import <Foundation/Foundation.h>
@class RACSignal;
@interface NSFileHandle (RACSupport)
- (RACSignal *)rac_readInBackground;
@end
