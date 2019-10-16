#import "RACDynamicSignal.h"
#import "RACEXTScope.h"
#import "RACCompoundDisposable.h"
#import "RACPassthroughSubscriber.h"
#import "RACScheduler+Private.h"
#import "RACSubscriber.h"
#import <libkern/OSAtomic.h>
static CFMutableSetRef RACActiveSignals = nil;
typedef struct RACSignalList {
	CFTypeRef retainedSignal;
	struct RACSignalList * restrict next;
} RACSignalList;
static OSQueueHead RACActiveSignalsToCheck = OS_ATOMIC_QUEUE_INIT;
static volatile uint32_t RACWillCheckActiveSignals = 0;
@interface RACDynamicSignal () {
	NSMutableArray *_subscribers;
	OSSpinLock _subscribersLock;
}
@property (nonatomic, copy, readonly) RACDisposable * (^didSubscribe)(id<RACSubscriber> subscriber);
@end
@implementation RACDynamicSignal
#pragma mark Lifecycle
+ (void)initialize {
	if (self != RACDynamicSignal.class) return;
	CFSetCallBacks callbacks = kCFTypeSetCallBacks;
	callbacks.equal = NULL;
	callbacks.hash = NULL;
	RACActiveSignals = CFSetCreateMutable(NULL, 0, &callbacks);
}
+ (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe {
	RACDynamicSignal *signal = [[self alloc] init];
	signal->_didSubscribe = [didSubscribe copy];
	return [signal setNameWithFormat:@"+createSignal:"];
}
- (instancetype)init {
	self = [super init];
	if (self == nil) return nil;
	[self invalidateGlobalRefIfNoNewSubscribersShowUp];
	return self;
}
static void RACCheckActiveSignals(void) {
	OSAtomicAnd32Barrier(0, &RACWillCheckActiveSignals);
	RACSignalList * restrict elem;
	while ((elem = OSAtomicDequeue(&RACActiveSignalsToCheck, offsetof(RACSignalList, next))) != NULL) {
		RACDynamicSignal *signal = CFBridgingRelease(elem->retainedSignal);
		free(elem);
		if (signal.hasSubscribers) {
			CFSetAddValue(RACActiveSignals, (__bridge void *)signal);
		} else {
			CFSetRemoveValue(RACActiveSignals, (__bridge void *)signal);
		}
	}
}
- (void)invalidateGlobalRefIfNoNewSubscribersShowUp {
	RACSignalList *elem = malloc(sizeof(*elem));
	elem->retainedSignal = CFBridgingRetain(self);
	OSAtomicEnqueue(&RACActiveSignalsToCheck, elem, offsetof(RACSignalList, next));
	int32_t willCheck = OSAtomicOr32Orig(1, &RACWillCheckActiveSignals);
	if (willCheck == 0) {
		dispatch_async(dispatch_get_main_queue(), ^{
			RACCheckActiveSignals();
		});
	}
}
#pragma mark Managing Subscribers
- (BOOL)hasSubscribers {
	OSSpinLockLock(&_subscribersLock);
	BOOL hasSubscribers = _subscribers.count > 0;
	OSSpinLockUnlock(&_subscribersLock);
	return hasSubscribers;
}
- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
	NSCParameterAssert(subscriber != nil);
	RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
	subscriber = [[RACPassthroughSubscriber alloc] initWithSubscriber:subscriber signal:self disposable:disposable];
	OSSpinLockLock(&_subscribersLock);
	if (_subscribers == nil) {
		_subscribers = [NSMutableArray arrayWithObject:subscriber];
	} else {
		[_subscribers addObject:subscriber];
	}
	OSSpinLockUnlock(&_subscribersLock);
	@weakify(self);
	RACDisposable *defaultDisposable = [RACDisposable disposableWithBlock:^{
		@strongify(self);
		if (self == nil) return;
		BOOL stillHasSubscribers = YES;
		OSSpinLockLock(&_subscribersLock);
		{
			NSUInteger index = [_subscribers indexOfObjectWithOptions:NSEnumerationReverse passingTest:^ BOOL (id<RACSubscriber> obj, NSUInteger index, BOOL *stop) {
				return obj == subscriber;
			}];
			if (index != NSNotFound) {
				[_subscribers removeObjectAtIndex:index];
				stillHasSubscribers = _subscribers.count > 0;
			}
		}
		OSSpinLockUnlock(&_subscribersLock);
		if (!stillHasSubscribers) {
			[self invalidateGlobalRefIfNoNewSubscribersShowUp];
		}
	}];
	[disposable addDisposable:defaultDisposable];
	if (self.didSubscribe != NULL) {
		RACDisposable *schedulingDisposable = [RACScheduler.subscriptionScheduler schedule:^{
			RACDisposable *innerDisposable = self.didSubscribe(subscriber);
			[disposable addDisposable:innerDisposable];
		}];
		[disposable addDisposable:schedulingDisposable];
	}
	return disposable;
}
@end
