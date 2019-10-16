#import <UIKit/UIKit.h>
@class RACCommand;
@interface UIRefreshControl (RACCommandSupport)
@property (nonatomic, strong) RACCommand *rac_command;
@end
