#import "RACPassthroughSubscriber.h"
#import "RACCompoundDisposable.h"
#import "RACSignal.h"
#import "RACSignalProvider.h"
static const char *cleanedDTraceString(NSString *original) {
	return [original stringByReplacingOccurrencesOfString:@"\\s+" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, original.length)].UTF8String;
}
static const char *cleanedSignalDescription(RACSignal *signal) {
	NSString *desc = signal.description;
	NSRange range = [desc rangeOfString:@" name:"];
	if (range.location != NSNotFound) {
		desc = [desc stringByReplacingCharactersInRange:range withString:@""];
	}
	return cleanedDTraceString(desc);
}
@interface RACPassthroughSubscriber ()
@property (nonatomic, strong, readonly) id<RACSubscriber> innerSubscriber;
@property (nonatomic, unsafe_unretained, readonly) RACSignal *signal;
@property (nonatomic, strong, readonly) RACCompoundDisposable *disposable;
@end
@implementation RACPassthroughSubscriber
#pragma mark Lifecycle
- (instancetype)initWithSubscriber:(id<RACSubscriber>)subscriber signal:(RACSignal *)signal disposable:(RACCompoundDisposable *)disposable {
	NSCParameterAssert(subscriber != nil);
	self = [super init];
	if (self == nil) return nil;
	_innerSubscriber = subscriber;
	_signal = signal;
	_disposable = disposable;
	[self.innerSubscriber didSubscribeWithDisposable:self.disposable];
	return self;
}
#pragma mark RACSubscriber
- (void)sendNext:(id)value {
	if (self.disposable.disposed) return;
	if (RACSIGNAL_NEXT_ENABLED()) {
		RACSIGNAL_NEXT(cleanedSignalDescription(self.signal), cleanedDTraceString(self.innerSubscriber.description), cleanedDTraceString([value description]));
	}
	[self.innerSubscriber sendNext:value];
}
- (void)sendError:(NSError *)error {
	if (self.disposable.disposed) return;
	if (RACSIGNAL_ERROR_ENABLED()) {
		RACSIGNAL_ERROR(cleanedSignalDescription(self.signal), cleanedDTraceString(self.innerSubscriber.description), cleanedDTraceString(error.description));
	}
	[self.innerSubscriber sendError:error];
}
- (void)sendCompleted {
	if (self.disposable.disposed) return;
	if (RACSIGNAL_COMPLETED_ENABLED()) {
		RACSIGNAL_COMPLETED(cleanedSignalDescription(self.signal), cleanedDTraceString(self.innerSubscriber.description));
	}
	[self.innerSubscriber sendCompleted];
}
- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable {
	if (disposable != self.disposable) {
		[self.disposable addDisposable:disposable];
	}
}
@end
