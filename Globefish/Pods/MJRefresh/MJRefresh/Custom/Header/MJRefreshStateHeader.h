#import "MJRefreshHeader.h"
@interface MJRefreshStateHeader : MJRefreshHeader
#pragma mark - 刷新时间相关
@property (copy, nonatomic) NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);
@property (weak, nonatomic, readonly) UILabel *lastUpdatedTimeLabel;
#pragma mark - 状态相关
@property (assign, nonatomic) CGFloat labelLeftInset;
@property (weak, nonatomic, readonly) UILabel *stateLabel;
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;
@end
