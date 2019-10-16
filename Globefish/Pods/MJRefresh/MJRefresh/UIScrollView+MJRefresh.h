#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"
@class MJRefreshHeader, MJRefreshFooter;
@interface UIScrollView (MJRefresh)
@property (strong, nonatomic) MJRefreshHeader *mj_header;
@property (strong, nonatomic) MJRefreshHeader *header MJRefreshDeprecated("使用mj_header");
@property (strong, nonatomic) MJRefreshFooter *mj_footer;
@property (strong, nonatomic) MJRefreshFooter *footer MJRefreshDeprecated("使用mj_footer");
#pragma mark - other
- (NSInteger)mj_totalDataCount;
@end
