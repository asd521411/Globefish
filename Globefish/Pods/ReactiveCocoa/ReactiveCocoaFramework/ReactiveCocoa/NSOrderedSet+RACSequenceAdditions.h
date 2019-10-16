#import <Foundation/Foundation.h>
@class RACSequence;
@interface NSOrderedSet (RACSequenceAdditions)
@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@end
