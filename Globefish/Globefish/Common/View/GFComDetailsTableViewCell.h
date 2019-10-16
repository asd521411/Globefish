#import <UIKit/UIKit.h>
#import "CommonModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface GFComDetailsTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *payLab;
@property (nonatomic, strong) UILabel *workContentLab;
@property (nonatomic, strong) UILabel *workTimeLab;
@property (nonatomic, strong) UILabel *workRequireLab;
@property (nonatomic, strong) UILabel *otherWelfareLab;
@property (nonatomic, strong) UILabel *payTitleLab;
@property (nonatomic, strong) UILabel *workContentTitleLab;
@property (nonatomic, strong) UILabel *workTimeTitleLab;
@property (nonatomic, strong) UILabel *workRequireTitleLab;
@property (nonatomic, strong) UILabel *otherWelfareTitleLab;
@property (nonatomic, strong) CommonModel *commonModel;
@end
NS_ASSUME_NONNULL_END
