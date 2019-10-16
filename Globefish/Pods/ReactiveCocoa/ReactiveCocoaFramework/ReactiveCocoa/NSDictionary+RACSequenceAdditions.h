#import <Foundation/Foundation.h>
@class RACSequence;
@interface NSDictionary (RACSequenceAdditions)
@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@property (nonatomic, copy, readonly) RACSequence *rac_keySequence;
@property (nonatomic, copy, readonly) RACSequence *rac_valueSequence;
@end
