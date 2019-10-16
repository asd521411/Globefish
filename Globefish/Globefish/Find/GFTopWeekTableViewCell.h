#import <UIKit/UIKit.h>
#import "CommonModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CollectionDidSelectItemBlock)(CommonModel *common);
@interface GFTopWeekTableViewCell : UITableViewCell
@property (nonatomic, strong) CommonModel *commonModel;
@property (nonatomic, strong) NSArray *cellArr;
@property (nonatomic, copy) CollectionDidSelectItemBlock collectionDidSelectItemBlock;
@end
NS_ASSUME_NONNULL_END
