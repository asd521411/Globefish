#import <UIKit/UIKit.h>
#import "CommonModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface CommonTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *tagImgV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *locationLab;
@property (nonatomic, strong) UILabel *accountStyleLab;
@property (nonatomic, strong) UILabel *princeLab;
@property (nonatomic, strong) UILabel *tagLab;
@property (nonatomic, strong) CommonModel *commonModel;
@end
NS_ASSUME_NONNULL_END
