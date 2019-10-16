#import <Foundation/Foundation.h>
@class RACSequence;
@interface NSArray (RACSequenceAdditions)
@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@end
