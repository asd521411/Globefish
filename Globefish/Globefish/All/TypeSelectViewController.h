#import <UIKit/UIKit.h>
#import "SuperViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^TypeSelectBlock)(NSString *str);
@interface TypeSelectViewController : SuperViewController
@property (nonatomic, copy) TypeSelectBlock  typeSelectBlock;
@end
NS_ASSUME_NONNULL_END
