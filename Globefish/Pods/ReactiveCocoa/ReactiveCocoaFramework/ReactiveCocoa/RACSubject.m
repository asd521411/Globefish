#import "RACSubject.h"
#import "RACEXTScope.h"
#import "RACCompoundDisposable.h"
#import "RACPassthroughSubscriber.h"
@interface RACSubject ()
@property (nonatomic, strong, readonly) NSMutableArray *subscribers;
@property (nonatomic, strong, readonly) RACCompoundDisposable *disposable;
- (void)enumerateSubscribersUsingBlock:(void (^)(id<RACSubscriber> subscriber))block;
@end
@implementation RACSubject
#pragma mark Lifecycle
+ (instancetype)subject {
	return [[self alloc] init];
}
- (id)init {
	self = [super init];
	if (self == nil) return nil;
	_disposable = [RACCompoundDisposable compoundDisposable];
	_subscribers = [[NSMutableArray alloc] initWithCapacity:1];
	return self;
}
- (void)dealloc {
	[self.disposable dispose];
}
#pragma mark Subscription
- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
	NSCParameterAssert(subscriber != nil);
	RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
	subscriber = [[RACPassthroughSubscriber alloc] initWithSubscriber:subscriber signal:self disposable:disposable];
	NSMutableArray *subscribers = self.subscribers;
	@synchronized (subscribers) {
		[subscribers addObject:subscriber];
	}
	return [RACDisposable disposableWithBlock:^{
		@synchronized (subscribers) {
			NSUInteger index = [subscribers indexOfObjectWithOptions:NSEnumerationReverse passingTest:^ BOOL (id<RACSubscriber> obj, NSUInteger index, BOOL *stop) {
				return obj == subscriber;
			}];
			if (index != NSNotFound) [subscribers removeObjectAtIndex:index];
		}
	}];
}
- (void)enumerateSubscribersUsingBlock:(void (^)(id<RACSubscriber> subscriber))block {
	NSArray *subscribers;
	@synchronized (self.subscribers) {
		subscribers = [self.subscribers copy];
	}
	for (id<RACSubscriber> subscriber in subscribers) {
		block(subscriber);
	}
}
#pragma mark RACSubscriber
- (void)sendNext:(id)value {
	[self enumerateSubscribersUsingBlock:^(id<RACSubscriber> subscriber) {
		[subscriber sendNext:value];
	}];
}
- (void)sendError:(NSError *)error {
	[self.disposable dispose];
	[self enumerateSubscribersUsingBlock:^(id<RACSubscriber> subscriber) {
		[subscriber sendError:error];
	}];
}
- (void)sendCompleted {
	[self.disposable dispose];
	[self enumerateSubscribersUsingBlock:^(id<RACSubscriber> subscriber) {
		[subscriber sendCompleted];
	}];
}
- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)d {
	if (d.disposed) return;
	[self.disposable addDisposable:d];
	@weakify(self, d);
	[d addDisposable:[RACDisposable disposableWithBlock:^{
		@strongify(self, d);
		[self.disposable removeDisposable:d];
	}]];
}
@end
