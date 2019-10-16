#import "RACScopedDisposable.h"
@implementation RACScopedDisposable
#pragma mark Lifecycle
+ (instancetype)scopedDisposableWithDisposable:(RACDisposable *)disposable {
	return [self disposableWithBlock:^{
		[disposable dispose];
	}];
}
- (void)dealloc {
	[self dispose];
}
#pragma mark RACDisposable
- (RACScopedDisposable *)asScopedDisposable {
	return self;
}
@end
