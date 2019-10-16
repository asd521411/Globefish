#import <Foundation/Foundation.h>
@interface NSString (RACKeyPathUtilities)
- (NSArray *)rac_keyPathComponents;
- (NSString *)rac_keyPathByDeletingLastKeyPathComponent;
- (NSString *)rac_keyPathByDeletingFirstKeyPathComponent;
@end
