#import "NSSet+RACSequenceAdditions.h"
#import "NSArray+RACSequenceAdditions.h"
@implementation NSSet (RACSequenceAdditions)
- (RACSequence *)rac_sequence {
	return self.allObjects.rac_sequence;
}
@end
