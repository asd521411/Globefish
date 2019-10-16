#import "RACChannel.h"
#import "RACDisposable.h"
#import "RACReplaySubject.h"
#import "RACSignal+Operations.h"
@interface RACChannelTerminal ()
@property (nonatomic, strong, readonly) RACSignal *values;
@property (nonatomic, strong, readonly) id<RACSubscriber> otherTerminal;
- (id)initWithValues:(RACSignal *)values otherTerminal:(id<RACSubscriber>)otherTerminal;
@end
@implementation RACChannel
- (id)init {
	self = [super init];
	if (self == nil) return nil;
	RACReplaySubject *leadingSubject = [[RACReplaySubject replaySubjectWithCapacity:0] setNameWithFormat:@"leadingSubject"];
	RACReplaySubject *followingSubject = [[RACReplaySubject replaySubjectWithCapacity:1] setNameWithFormat:@"followingSubject"];
	[[leadingSubject ignoreValues] subscribe:followingSubject];
	[[followingSubject ignoreValues] subscribe:leadingSubject];
	_leadingTerminal = [[[RACChannelTerminal alloc] initWithValues:leadingSubject otherTerminal:followingSubject] setNameWithFormat:@"leadingTerminal"];
	_followingTerminal = [[[RACChannelTerminal alloc] initWithValues:followingSubject otherTerminal:leadingSubject] setNameWithFormat:@"followingTerminal"];
	return self;
}
@end
@implementation RACChannelTerminal
#pragma mark Lifecycle
- (id)initWithValues:(RACSignal *)values otherTerminal:(id<RACSubscriber>)otherTerminal {
	NSCParameterAssert(values != nil);
	NSCParameterAssert(otherTerminal != nil);
	self = [super init];
	if (self == nil) return nil;
	_values = values;
	_otherTerminal = otherTerminal;
	return self;
}
#pragma mark RACSignal
- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
	return [self.values subscribe:subscriber];
}
#pragma mark <RACSubscriber>
- (void)sendNext:(id)value {
	[self.otherTerminal sendNext:value];
}
- (void)sendError:(NSError *)error {
	[self.otherTerminal sendError:error];
}
- (void)sendCompleted {
	[self.otherTerminal sendCompleted];
}
- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable {
	[self.otherTerminal didSubscribeWithDisposable:disposable];
}
@end
