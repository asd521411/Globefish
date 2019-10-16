#import "RACEmptySignal.h"
#import "RACScheduler+Private.h"
#import "RACSubscriber.h"
@implementation RACEmptySignal
#pragma mark Properties
- (void)setName:(NSString *)name {
#ifdef DEBUG
	[super setName:name];
#endif
}
- (NSString *)name {
#ifdef DEBUG
	return super.name;
#else
	return @"+empty";
#endif
}
#pragma mark Lifecycle
+ (RACSignal *)empty {
#ifdef DEBUG
	return [[[self alloc] init] setNameWithFormat:@"+empty"];
#else
	static id singleton;
	static dispatch_once_t pred;
	dispatch_once(&pred, ^{
		singleton = [[self alloc] init];
	});
	return singleton;
#endif
}
#pragma mark Subscription
- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
	NSCParameterAssert(subscriber != nil);
	return [RACScheduler.subscriptionScheduler schedule:^{
		[subscriber sendCompleted];
	}];
}
@end
