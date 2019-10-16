#import <Foundation/Foundation.h>
@class RACSequence;
@interface NSEnumerator (RACSequenceAdditions)
@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@end
