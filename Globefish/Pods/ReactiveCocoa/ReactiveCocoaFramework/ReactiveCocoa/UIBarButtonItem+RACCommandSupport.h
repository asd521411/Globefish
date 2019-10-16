#import <UIKit/UIKit.h>
@class RACCommand;
@interface UIBarButtonItem (RACCommandSupport)
@property (nonatomic, strong) RACCommand *rac_command;
@end
