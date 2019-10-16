#import "RACArraySequence.h"
@interface RACArraySequence ()
@property (nonatomic, copy, readonly) NSArray *array __attribute__((deprecated));
@property (nonatomic, copy, readonly) NSArray *backingArray;
@property (nonatomic, assign, readonly) NSUInteger offset;
@end
@implementation RACArraySequence
#pragma mark Lifecycle
+ (instancetype)sequenceWithArray:(NSArray *)array offset:(NSUInteger)offset {
	NSCParameterAssert(offset <= array.count);
	if (offset == array.count) return self.empty;
	RACArraySequence *seq = [[self alloc] init];
	seq->_backingArray = [array copy];
	seq->_offset = offset;
	return seq;
}
#pragma mark RACSequence
- (id)head {
	return self.backingArray[self.offset];
}
- (RACSequence *)tail {
	RACSequence *sequence = [self.class sequenceWithArray:self.backingArray offset:self.offset + 1];
	sequence.name = self.name;
	return sequence;
}
#pragma mark NSFastEnumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id[])stackbuf count:(NSUInteger)len {
	NSCParameterAssert(len > 0);
	if (state->state >= self.backingArray.count) {
		return 0;
	}
	if (state->state == 0) {
		state->state = self.offset;
		state->mutationsPtr = state->extra;
	}
	state->itemsPtr = stackbuf;
	NSUInteger startIndex = state->state;
	NSUInteger index = 0;
	for (id value in self.backingArray) {
		if (index < startIndex) {
			++index;
			continue;
		}
		stackbuf[index - startIndex] = value;
		++index;
		if (index - startIndex >= len) break;
	}
	NSCAssert(index > startIndex, @"Final index (%lu) should be greater than start index (%lu)", (unsigned long)index, (unsigned long)startIndex);
	state->state = index;
	return index - startIndex;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (NSArray *)array {
	return [self.backingArray subarrayWithRange:NSMakeRange(self.offset, self.backingArray.count - self.offset)];
}
#pragma clang diagnostic pop
#pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self == nil) return nil;
	_backingArray = [coder decodeObjectForKey:@"array"];
	_offset = 0;
	return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
}
#pragma mark NSObject
- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p>{ name = %@, array = %@ }", self.class, self, self.name, self.backingArray];
}
@end
