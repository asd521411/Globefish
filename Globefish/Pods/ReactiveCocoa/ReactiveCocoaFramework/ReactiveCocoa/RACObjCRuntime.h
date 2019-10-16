#import <Foundation/Foundation.h>
@interface RACObjCRuntime : NSObject
+ (Class)createClass:(const char *)className inheritingFromClass:(Class)superclass;
@end
