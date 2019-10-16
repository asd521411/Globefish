#import <Foundation/Foundation.h>
@class RACTuple;
@interface NSInvocation (RACTypeParsing)
- (void)rac_setArgument:(id)object atIndex:(NSUInteger)index;
- (id)rac_argumentAtIndex:(NSUInteger)index;
@property (nonatomic, copy) RACTuple *rac_argumentsTuple;
- (id)rac_returnValue;
@end
