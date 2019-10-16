#import "RACSubscriptingAssignmentTrampoline.h"
#import "RACSignal+Operations.h"
@interface RACSubscriptingAssignmentTrampoline ()
@property (nonatomic, strong, readonly) id target;
@property (nonatomic, strong, readonly) id nilValue;
@end
@implementation RACSubscriptingAssignmentTrampoline
- (id)initWithTarget:(id)target nilValue:(id)nilValue {
	if (target == nil) return nil;
	self = [super init];
	if (self == nil) return nil;
	_target = target;
	_nilValue = nilValue;
	return self;
}
- (void)setObject:(RACSignal *)signal forKeyedSubscript:(NSString *)keyPath {
	[signal setKeyPath:keyPath onObject:self.target nilValue:self.nilValue];
}
@end
