#import <Foundation/Foundation.h>
@class RACSequence;
@interface NSString (RACSequenceAdditions)
@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@end
