#import "NSObject+RACDescription.h"
#import "RACTuple.h"
@implementation NSObject (RACDescription)
- (NSString *)rac_description {
	if (getenv("RAC_DEBUG_SIGNAL_NAMES") != NULL) {
		return [[NSString alloc] initWithFormat:@"<%@: %p>", self.class, self];
	} else {
		return @"(description skipped)";
	}
}
@end
@implementation NSValue (RACDescription)
- (NSString *)rac_description {
	return self.description;
}
@end
@implementation NSString (RACDescription)
- (NSString *)rac_description {
	return self.description;
}
@end
@implementation RACTuple (RACDescription)
- (NSString *)rac_description {
	return self.allObjects.description;
}
@end
