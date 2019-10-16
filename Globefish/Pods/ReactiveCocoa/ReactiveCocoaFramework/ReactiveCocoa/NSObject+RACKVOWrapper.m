#import "NSObject+RACKVOWrapper.h"
#import "RACEXTRuntimeExtensions.h"
#import "RACEXTScope.h"
#import "NSObject+RACDeallocating.h"
#import "NSString+RACKeyPathUtilities.h"
#import "RACCompoundDisposable.h"
#import "RACDisposable.h"
#import "RACKVOTrampoline.h"
#import "RACSerialDisposable.h"
@implementation NSObject (RACKVOWrapper)
- (RACDisposable *)rac_observeKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options observer:(NSObject *)observer block:(void (^)(id, NSDictionary *, BOOL, BOOL))block {
	NSCParameterAssert(block != nil);
	NSCParameterAssert(keyPath.rac_keyPathComponents.count > 0);
	keyPath = [keyPath copy];
	@unsafeify(observer);
	NSArray *keyPathComponents = keyPath.rac_keyPathComponents;
	BOOL keyPathHasOneComponent = (keyPathComponents.count == 1);
	NSString *keyPathHead = keyPathComponents[0];
	NSString *keyPathTail = keyPath.rac_keyPathByDeletingFirstKeyPathComponent;
	RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
	RACSerialDisposable *firstComponentSerialDisposable = [RACSerialDisposable serialDisposableWithDisposable:[RACCompoundDisposable compoundDisposable]];
	RACCompoundDisposable * (^firstComponentDisposable)(void) = ^{
		return (RACCompoundDisposable *)firstComponentSerialDisposable.disposable;
	};
	[disposable addDisposable:firstComponentSerialDisposable];
	BOOL shouldAddDeallocObserver = NO;
	objc_property_t property = class_getProperty(object_getClass(self), keyPathHead.UTF8String);
	if (property != NULL) {
		rac_propertyAttributes *attributes = rac_copyPropertyAttributes(property);
		if (attributes != NULL) {
			@onExit {
				free(attributes);
			};
			BOOL isObject = attributes->objectClass != nil || strstr(attributes->type, @encode(id)) == attributes->type;
			BOOL isProtocol = attributes->objectClass == NSClassFromString(@"Protocol");
			BOOL isBlock = strcmp(attributes->type, @encode(void(^)())) == 0;
			BOOL isWeak = attributes->weak;
			shouldAddDeallocObserver = isObject && isWeak && !isBlock && !isProtocol;
		}
	}
	void (^addDeallocObserverToPropertyValue)(NSObject *) = ^(NSObject *value) {
		if (!shouldAddDeallocObserver) return;
		@strongify(observer);
		if (value == observer) return;
		NSDictionary *change = @{
			NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting),
			NSKeyValueChangeNewKey: NSNull.null,
		};
		RACCompoundDisposable *valueDisposable = value.rac_deallocDisposable;
		RACDisposable *deallocDisposable = [RACDisposable disposableWithBlock:^{
			block(nil, change, YES, keyPathHasOneComponent);
		}];
		[valueDisposable addDisposable:deallocDisposable];
		[firstComponentDisposable() addDisposable:[RACDisposable disposableWithBlock:^{
			[valueDisposable removeDisposable:deallocDisposable];
		}]];
	};
	void (^addObserverToValue)(NSObject *) = ^(NSObject *value) {
		@strongify(observer);
		RACDisposable *observerDisposable = [value rac_observeKeyPath:keyPathTail options:(options & ~NSKeyValueObservingOptionInitial) observer:observer block:block];
		[firstComponentDisposable() addDisposable:observerDisposable];
	};
	NSKeyValueObservingOptions trampolineOptions = (options | NSKeyValueObservingOptionPrior) & ~NSKeyValueObservingOptionInitial;
	RACKVOTrampoline *trampoline = [[RACKVOTrampoline alloc] initWithTarget:self observer:observer keyPath:keyPathHead options:trampolineOptions block:^(id trampolineTarget, id trampolineObserver, NSDictionary *change) {
		if ([change[NSKeyValueChangeNotificationIsPriorKey] boolValue]) {
			[firstComponentDisposable() dispose];
			if ((options & NSKeyValueObservingOptionPrior) != 0) {
				block([trampolineTarget valueForKeyPath:keyPath], change, NO, keyPathHasOneComponent);
			}
			return;
		}
		NSObject *value = [trampolineTarget valueForKey:keyPathHead];
		if (value == nil) {
			block(nil, change, NO, keyPathHasOneComponent);
			return;
		}
		RACDisposable *oldFirstComponentDisposable = [firstComponentSerialDisposable swapInDisposable:[RACCompoundDisposable compoundDisposable]];
		[oldFirstComponentDisposable dispose];
		addDeallocObserverToPropertyValue(value);
		if (keyPathHasOneComponent) {
			block(value, change, NO, keyPathHasOneComponent);
			return;
		}
		addObserverToValue(value);
		block([value valueForKeyPath:keyPathTail], change, NO, keyPathHasOneComponent);
	}];
	[disposable addDisposable:trampoline];
	NSObject *value = [self valueForKey:keyPathHead];
	if (value != nil) {
		addDeallocObserverToPropertyValue(value);
		if (!keyPathHasOneComponent) {
			addObserverToValue(value);
		}
	}
	if ((options & NSKeyValueObservingOptionInitial) != 0) {
		id initialValue = [self valueForKeyPath:keyPath];
		NSDictionary *initialChange = @{
			NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting),
			NSKeyValueChangeNewKey: initialValue ?: NSNull.null,
		};
		block(initialValue, initialChange, NO, keyPathHasOneComponent);
	}
	RACCompoundDisposable *observerDisposable = observer.rac_deallocDisposable;
	RACCompoundDisposable *selfDisposable = self.rac_deallocDisposable;
	[observerDisposable addDisposable:disposable];
	[selfDisposable addDisposable:disposable];
	return [RACDisposable disposableWithBlock:^{
		[disposable dispose];
		[observerDisposable removeDisposable:disposable];
		[selfDisposable removeDisposable:disposable];
	}];
}
@end
@implementation NSObject (RACKVOWrapperDeprecated)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (RACKVOTrampoline *)rac_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(RACKVOBlock)block {
	return [[RACKVOTrampoline alloc] initWithTarget:self observer:observer keyPath:keyPath options:options block:block];
}
#pragma clang diagnostic pop
@end
