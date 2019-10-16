#import "NSObject+RACSelectorSignal.h"
#import "RACEXTRuntimeExtensions.h"
#import "NSInvocation+RACTypeParsing.h"
#import "NSObject+RACDeallocating.h"
#import "RACCompoundDisposable.h"
#import "RACDisposable.h"
#import "RACObjCRuntime.h"
#import "RACSubject.h"
#import "RACTuple.h"
#import "NSObject+RACDescription.h"
#import <objc/message.h>
#import <objc/runtime.h>
NSString * const RACSelectorSignalErrorDomain = @"RACSelectorSignalErrorDomain";
const NSInteger RACSelectorSignalErrorMethodSwizzlingRace = 1;
static NSString * const RACSignalForSelectorAliasPrefix = @"rac_alias_";
static NSString * const RACSubclassSuffix = @"_RACSelectorSignal";
static void *RACSubclassAssociationKey = &RACSubclassAssociationKey;
static NSMutableSet *swizzledClasses() {
	static NSMutableSet *set;
	static dispatch_once_t pred;
	dispatch_once(&pred, ^{
		set = [[NSMutableSet alloc] init];
	});
	return set;
}
@implementation NSObject (RACSelectorSignal)
static BOOL RACForwardInvocation(id self, NSInvocation *invocation) {
	SEL aliasSelector = RACAliasForSelector(invocation.selector);
	RACSubject *subject = objc_getAssociatedObject(self, aliasSelector);
	Class class = object_getClass(invocation.target);
	BOOL respondsToAlias = [class instancesRespondToSelector:aliasSelector];
	if (respondsToAlias) {
		invocation.selector = aliasSelector;
		[invocation invoke];
	}
	if (subject == nil) return respondsToAlias;
	[subject sendNext:invocation.rac_argumentsTuple];
	return YES;
}
static void RACSwizzleForwardInvocation(Class class) {
	SEL forwardInvocationSEL = @selector(forwardInvocation:);
	Method forwardInvocationMethod = class_getInstanceMethod(class, forwardInvocationSEL);
	void (*originalForwardInvocation)(id, SEL, NSInvocation *) = NULL;
	if (forwardInvocationMethod != NULL) {
		originalForwardInvocation = (__typeof__(originalForwardInvocation))method_getImplementation(forwardInvocationMethod);
	}
	id newForwardInvocation = ^(id self, NSInvocation *invocation) {
		BOOL matched = RACForwardInvocation(self, invocation);
		if (matched) return;
		if (originalForwardInvocation == NULL) {
			[self doesNotRecognizeSelector:invocation.selector];
		} else {
			originalForwardInvocation(self, forwardInvocationSEL, invocation);
		}
	};
	class_replaceMethod(class, forwardInvocationSEL, imp_implementationWithBlock(newForwardInvocation), "v@:@");
}
static void RACSwizzleRespondsToSelector(Class class) {
	SEL respondsToSelectorSEL = @selector(respondsToSelector:);
	Method respondsToSelectorMethod = class_getInstanceMethod(class, respondsToSelectorSEL);
	BOOL (*originalRespondsToSelector)(id, SEL, SEL) = (__typeof__(originalRespondsToSelector))method_getImplementation(respondsToSelectorMethod);
	id newRespondsToSelector = ^ BOOL (id self, SEL selector) {
		Method method = rac_getImmediateInstanceMethod(class, selector);
		if (method != NULL && method_getImplementation(method) == _objc_msgForward) {
			SEL aliasSelector = RACAliasForSelector(selector);
			if (objc_getAssociatedObject(self, aliasSelector) != nil) return YES;
		}
		return originalRespondsToSelector(self, respondsToSelectorSEL, selector);
	};
	class_replaceMethod(class, respondsToSelectorSEL, imp_implementationWithBlock(newRespondsToSelector), method_getTypeEncoding(respondsToSelectorMethod));
}
static void RACSwizzleGetClass(Class class, Class statedClass) {
	SEL selector = @selector(class);
	Method method = class_getInstanceMethod(class, selector);
	IMP newIMP = imp_implementationWithBlock(^(id self) {
		return statedClass;
	});
	class_replaceMethod(class, selector, newIMP, method_getTypeEncoding(method));
}
static void RACSwizzleMethodSignatureForSelector(Class class) {
	IMP newIMP = imp_implementationWithBlock(^(id self, SEL selector) {
		Class actualClass = object_getClass(self);
		Method method = class_getInstanceMethod(actualClass, selector);
		if (method == NULL) {
			struct objc_super target = {
				.super_class = class_getSuperclass(class),
				.receiver = self,
			};
			NSMethodSignature * (*messageSend)(struct objc_super *, SEL, SEL) = (__typeof__(messageSend))objc_msgSendSuper;
			return messageSend(&target, @selector(methodSignatureForSelector:), selector);
		}
		char const *encoding = method_getTypeEncoding(method);
		return [NSMethodSignature signatureWithObjCTypes:encoding];
	});
	SEL selector = @selector(methodSignatureForSelector:);
	Method methodSignatureForSelectorMethod = class_getInstanceMethod(class, selector);
	class_replaceMethod(class, selector, newIMP, method_getTypeEncoding(methodSignatureForSelectorMethod));
}
static void RACCheckTypeEncoding(const char *typeEncoding) {
#if !NS_BLOCK_ASSERTIONS
	NSCAssert(*typeEncoding < '1' || *typeEncoding > '9', @"unknown method return type not supported in type encoding: %s", typeEncoding);
	NSCAssert(strstr(typeEncoding, "(") != typeEncoding, @"union method return type not supported");
	NSCAssert(strstr(typeEncoding, "{") != typeEncoding, @"struct method return type not supported");
	NSCAssert(strstr(typeEncoding, "[") != typeEncoding, @"array method return type not supported");
	NSCAssert(strstr(typeEncoding, @encode(_Complex float)) != typeEncoding, @"complex float method return type not supported");
	NSCAssert(strstr(typeEncoding, @encode(_Complex double)) != typeEncoding, @"complex double method return type not supported");
	NSCAssert(strstr(typeEncoding, @encode(_Complex long double)) != typeEncoding, @"complex long double method return type not supported");
#endif 
}
static RACSignal *NSObjectRACSignalForSelector(NSObject *self, SEL selector, Protocol *protocol) {
	SEL aliasSelector = RACAliasForSelector(selector);
	@synchronized (self) {
		RACSubject *subject = objc_getAssociatedObject(self, aliasSelector);
		if (subject != nil) return subject;
		Class class = RACSwizzleClass(self);
		NSCAssert(class != nil, @"Could not swizzle class of %@", self);
		subject = [[RACSubject subject] setNameWithFormat:@"%@ -rac_signalForSelector: %s", self.rac_description, sel_getName(selector)];
		objc_setAssociatedObject(self, aliasSelector, subject, OBJC_ASSOCIATION_RETAIN);
		[self.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^{
			[subject sendCompleted];
		}]];
		Method targetMethod = class_getInstanceMethod(class, selector);
		if (targetMethod == NULL) {
			const char *typeEncoding;
			if (protocol == NULL) {
				typeEncoding = RACSignatureForUndefinedSelector(selector);
			} else {
				struct objc_method_description methodDescription = protocol_getMethodDescription(protocol, selector, NO, YES);
				if (methodDescription.name == NULL) {
					methodDescription = protocol_getMethodDescription(protocol, selector, YES, YES);
					NSCAssert(methodDescription.name != NULL, @"Selector %@ does not exist in <%s>", NSStringFromSelector(selector), protocol_getName(protocol));
				}
				typeEncoding = methodDescription.types;
			}
			RACCheckTypeEncoding(typeEncoding);
			if (!class_addMethod(class, selector, _objc_msgForward, typeEncoding)) {
				NSDictionary *userInfo = @{
					NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedString(@"A race condition occurred implementing %@ on class %@", nil), NSStringFromSelector(selector), class],
					NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Invoke -rac_signalForSelector: again to override the implementation.", nil)
				};
				return [RACSignal error:[NSError errorWithDomain:RACSelectorSignalErrorDomain code:RACSelectorSignalErrorMethodSwizzlingRace userInfo:userInfo]];
			}
		} else if (method_getImplementation(targetMethod) != _objc_msgForward) {
			const char *typeEncoding = method_getTypeEncoding(targetMethod);
			RACCheckTypeEncoding(typeEncoding);
			BOOL addedAlias __attribute__((unused)) = class_addMethod(class, aliasSelector, method_getImplementation(targetMethod), typeEncoding);
			NSCAssert(addedAlias, @"Original implementation for %@ is already copied to %@ on %@", NSStringFromSelector(selector), NSStringFromSelector(aliasSelector), class);
			class_replaceMethod(class, selector, _objc_msgForward, method_getTypeEncoding(targetMethod));
		}
		return subject;
	}
}
static SEL RACAliasForSelector(SEL originalSelector) {
	NSString *selectorName = NSStringFromSelector(originalSelector);
	return NSSelectorFromString([RACSignalForSelectorAliasPrefix stringByAppendingString:selectorName]);
}
static const char *RACSignatureForUndefinedSelector(SEL selector) {
	const char *name = sel_getName(selector);
	NSMutableString *signature = [NSMutableString stringWithString:@"v@:"];
	while ((name = strchr(name, ':')) != NULL) {
		[signature appendString:@"@"];
		name++;
	}
	return signature.UTF8String;
}
static Class RACSwizzleClass(NSObject *self) {
	Class statedClass = self.class;
	Class baseClass = object_getClass(self);
	Class knownDynamicSubclass = objc_getAssociatedObject(self, RACSubclassAssociationKey);
	if (knownDynamicSubclass != Nil) return knownDynamicSubclass;
	NSString *className = NSStringFromClass(baseClass);
	if (statedClass != baseClass) {
		@synchronized (swizzledClasses()) {
			if (![swizzledClasses() containsObject:className]) {
				RACSwizzleForwardInvocation(baseClass);
				RACSwizzleRespondsToSelector(baseClass);
				RACSwizzleGetClass(baseClass, statedClass);
				RACSwizzleGetClass(object_getClass(baseClass), statedClass);
				RACSwizzleMethodSignatureForSelector(baseClass);
				[swizzledClasses() addObject:className];
			}
		}
		return baseClass;
	}
	const char *subclassName = [className stringByAppendingString:RACSubclassSuffix].UTF8String;
	Class subclass = objc_getClass(subclassName);
	if (subclass == nil) {
		subclass = [RACObjCRuntime createClass:subclassName inheritingFromClass:baseClass];
		if (subclass == nil) return nil;
		RACSwizzleForwardInvocation(subclass);
		RACSwizzleRespondsToSelector(subclass);
		RACSwizzleGetClass(subclass, statedClass);
		RACSwizzleGetClass(object_getClass(subclass), statedClass);
		RACSwizzleMethodSignatureForSelector(subclass);
		objc_registerClassPair(subclass);
	}
	object_setClass(self, subclass);
	objc_setAssociatedObject(self, RACSubclassAssociationKey, subclass, OBJC_ASSOCIATION_ASSIGN);
	return subclass;
}
- (RACSignal *)rac_signalForSelector:(SEL)selector {
	NSCParameterAssert(selector != NULL);
	return NSObjectRACSignalForSelector(self, selector, NULL);
}
- (RACSignal *)rac_signalForSelector:(SEL)selector fromProtocol:(Protocol *)protocol {
	NSCParameterAssert(selector != NULL);
	NSCParameterAssert(protocol != NULL);
	return NSObjectRACSignalForSelector(self, selector, protocol);
}
@end
