#import <UIKit/UIKit.h>
@class RACCommand;
@interface UIButton (RACCommandSupport)
@property (nonatomic, strong) RACCommand *rac_command;
@end
