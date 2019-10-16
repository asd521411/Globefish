#import "RACSerialDisposable.h"
#import <libkern/OSAtomic.h>
@interface RACSerialDisposable () {
	void * volatile _disposablePtr;
}
@end
@implementation RACSerialDisposable
#pragma mark Properties
- (BOOL)isDisposed {
	return _disposablePtr == nil;
}
- (RACDisposable *)disposable {
	RACDisposable *disposable = (__bridge id)_disposablePtr;
	return (disposable == self ? nil : disposable);
}
- (void)setDisposable:(RACDisposable *)disposable {
	[self swapInDisposable:disposable];
}
#pragma mark Lifecycle
+ (instancetype)serialDisposableWithDisposable:(RACDisposable *)disposable {
	RACSerialDisposable *serialDisposable = [[self alloc] init];
	serialDisposable.disposable = disposable;
	return serialDisposable;
}
- (id)init {
	self = [super init];
	if (self == nil) return nil;
	_disposablePtr = (__bridge void *)self;
	OSMemoryBarrier();
	return self;
}
- (id)initWithBlock:(void (^)(void))block {
	self = [self init];
	if (self == nil) return nil;
	self.disposable = [RACDisposable disposableWithBlock:block];
	return self;
}
- (void)dealloc {
	self.disposable = nil;
}
#pragma mark Inner Disposable
- (RACDisposable *)swapInDisposable:(RACDisposable *)newDisposable {
	void * const selfPtr = (__bridge void *)self;
	void *newDisposablePtr = selfPtr;
	if (newDisposable != nil) {
		newDisposablePtr = (void *)CFBridgingRetain(newDisposable);
	}
	void *existingDisposablePtr;
	while ((existingDisposablePtr = _disposablePtr) != NULL) {
		if (!OSAtomicCompareAndSwapPtrBarrier(existingDisposablePtr, newDisposablePtr, &_disposablePtr)) {
			continue;
		}
		if (existingDisposablePtr == selfPtr) {
			return nil;
		} else {
			return CFBridgingRelease(existingDisposablePtr);
		}
	}
	[newDisposable dispose];
	if (newDisposable != nil) {
		CFRelease(newDisposablePtr);
	}
	return nil;
}
#pragma mark Disposal
- (void)dispose {
	void *existingDisposablePtr;
	while ((existingDisposablePtr = _disposablePtr) != NULL) {
		if (OSAtomicCompareAndSwapPtrBarrier(existingDisposablePtr, NULL, &_disposablePtr)) {
			if (existingDisposablePtr != (__bridge void *)self) {
				RACDisposable *existingDisposable = CFBridgingRelease(existingDisposablePtr);
				[existingDisposable dispose];
			}
			break;
		}
	}
}
@end
