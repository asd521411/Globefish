#import "NSDictionary+RACSequenceAdditions.h"
#import "NSArray+RACSequenceAdditions.h"
#import "RACSequence.h"
#import "RACTuple.h"
@implementation NSDictionary (RACSequenceAdditions)
- (RACSequence *)rac_sequence {
	NSDictionary *immutableDict = [self copy];
	return [immutableDict.allKeys.rac_sequence map:^(id key) {
		id value = immutableDict[key];
		return [RACTuple tupleWithObjects:key, value, nil];
	}];
}
- (RACSequence *)rac_keySequence {
	return self.allKeys.rac_sequence;
}
- (RACSequence *)rac_valueSequence {
	return self.allValues.rac_sequence;
}
@end
