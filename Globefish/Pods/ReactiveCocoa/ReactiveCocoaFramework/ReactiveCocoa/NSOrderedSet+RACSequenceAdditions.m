#import "NSOrderedSet+RACSequenceAdditions.h"
#import "NSArray+RACSequenceAdditions.h"
@implementation NSOrderedSet (RACSequenceAdditions)
- (RACSequence *)rac_sequence {
	return self.array.rac_sequence;
}
@end
