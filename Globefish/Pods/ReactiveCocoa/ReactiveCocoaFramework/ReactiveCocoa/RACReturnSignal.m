#import "RACReturnSignal.h"
#import "RACScheduler+Private.h"
#import "RACSubscriber.h"
#import "RACUnit.h"
@interface RACReturnSignal ()
@property (nonatomic, strong, readonly) id value;
@end
@implementation RACReturnSignal
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
	return @"+return:";
#endif
}
#pragma mark Lifecycle
+ (RACSignal *)return:(id)value {
#ifndef DEBUG
	if (value == RACUnit.defaultUnit) {
		static RACReturnSignal *unitSingleton;
		static dispatch_once_t unitPred;
		dispatch_once(&unitPred, ^{
			unitSingleton = [[self alloc] init];
			unitSingleton->_value = RACUnit.defaultUnit;
		});
		return unitSingleton;
	} else if (value == nil) {
		static RACReturnSignal *nilSingleton;
		static dispatch_once_t nilPred;
		dispatch_once(&nilPred, ^{
			nilSingleton = [[self alloc] init];
			nilSingleton->_value = nil;
		});
		return nilSingleton;
	}
#endif
	RACReturnSignal *signal = [[self alloc] init];
	signal->_value = value;
#ifdef DEBUG
	[signal setNameWithFormat:@"+return: %@", value];
#endif
	return signal;
}
#pragma mark Subscription
- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
	NSCParameterAssert(subscriber != nil);
	return [RACScheduler.subscriptionScheduler schedule:^{
		[subscriber sendNext:self.value];
		[subscriber sendCompleted];
	}];
}
@end
