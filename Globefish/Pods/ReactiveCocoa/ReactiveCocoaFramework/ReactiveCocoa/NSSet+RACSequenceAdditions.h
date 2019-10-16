#import <Foundation/Foundation.h>
@class RACSequence;
@interface NSSet (RACSequenceAdditions)
@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@end
