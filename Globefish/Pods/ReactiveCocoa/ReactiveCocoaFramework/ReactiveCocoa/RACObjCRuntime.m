#import "RACObjCRuntime.h"
#import <objc/runtime.h>
#if __has_feature(objc_arc)
#error "This file must be compiled without ARC."
#endif
@implementation RACObjCRuntime
+ (Class)createClass:(const char *)className inheritingFromClass:(Class)superclass {
	return objc_allocateClassPair(superclass, className, 0);
}
@end
