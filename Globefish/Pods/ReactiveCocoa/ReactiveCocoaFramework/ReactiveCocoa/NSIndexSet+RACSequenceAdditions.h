#import <Foundation/Foundation.h>
@class RACSequence;
@interface NSIndexSet (RACSequenceAdditions)
@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@end
