#import <UIKit/UIKit.h>
#import "CommonModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface CommontTopTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *addressnameTitleLab;
@property (nonatomic, strong) UILabel *princeLab;
@property (nonatomic, strong) UILabel *positionStyleLab;
@property (nonatomic, strong) UILabel *demandTitleLab;
@property (nonatomic, strong) UILabel *tagLab;
@property (nonatomic, strong) CommonModel *commonModel;
@end
NS_ASSUME_NONNULL_END
