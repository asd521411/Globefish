#import "RACEmptySequence.h"
@implementation RACEmptySequence
#pragma mark Lifecycle
+ (instancetype)empty {
	static id singleton;
	static dispatch_once_t pred;
	dispatch_once(&pred, ^{
		singleton = [[self alloc] init];
	});
	return singleton;
}
#pragma mark RACSequence
- (id)head {
	return nil;
}
- (RACSequence *)tail {
	return nil;
}
- (RACSequence *)bind:(RACStreamBindBlock)bindBlock passingThroughValuesFromSequence:(RACSequence *)passthroughSequence {
	return passthroughSequence ?: self;
}
#pragma mark NSCoding
- (Class)classForCoder {
	return self.class;
}
- (id)initWithCoder:(NSCoder *)coder {
	return self.class.empty;
}
- (void)encodeWithCoder:(NSCoder *)coder {
}
#pragma mark NSObject
- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p>{ name = %@ }", self.class, self, self.name];
}
- (NSUInteger)hash {
	return (NSUInteger)(__bridge void *)self;
}
- (BOOL)isEqual:(RACSequence *)seq {
	return (self == seq);
}
@end
