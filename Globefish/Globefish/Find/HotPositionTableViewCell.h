#import <UIKit/UIKit.h>
#import "CommonModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CollectionDidSelectItemBlock)(CommonModel *common);
@interface HotPositionTableViewCell : UITableViewCell
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *cellArr;
@property (nonatomic, copy) CollectionDidSelectItemBlock collectionDidSelectItemBlock;
@end
NS_ASSUME_NONNULL_END
