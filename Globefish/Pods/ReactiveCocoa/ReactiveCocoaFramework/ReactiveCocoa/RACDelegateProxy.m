#import "RACDelegateProxy.h"
#import "NSObject+RACSelectorSignal.h"
#import <objc/runtime.h>
@interface RACDelegateProxy () {
	Protocol *_protocol;
}
@end
@implementation RACDelegateProxy
#pragma mark Lifecycle
- (instancetype)initWithProtocol:(Protocol *)protocol {
	NSCParameterAssert(protocol != NULL);
	self = [super init];
	if (self == nil) return nil;
	class_addProtocol(self.class, protocol);
	_protocol = protocol;
	return self;
}
#pragma mark API
- (RACSignal *)signalForSelector:(SEL)selector {
	return [self rac_signalForSelector:selector fromProtocol:_protocol];
}
#pragma mark NSObject
- (BOOL)isProxy {
	return YES;
}
- (void)forwardInvocation:(NSInvocation *)invocation {
	[invocation invokeWithTarget:self.rac_proxiedDelegate];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
	struct objc_method_description methodDescription = protocol_getMethodDescription(_protocol, selector, NO, YES);
	if (methodDescription.name == NULL) {
		methodDescription = protocol_getMethodDescription(_protocol, selector, YES, YES);
		if (methodDescription.name == NULL) return [super methodSignatureForSelector:selector];
	}
	return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
}
- (BOOL)respondsToSelector:(SEL)selector {
	__autoreleasing id delegate = self.rac_proxiedDelegate;
	if ([delegate respondsToSelector:selector]) return YES;
	return [super respondsToSelector:selector];
}
@end
