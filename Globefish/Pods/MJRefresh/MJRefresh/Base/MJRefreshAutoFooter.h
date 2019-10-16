#import "MJRefreshFooter.h"
@interface MJRefreshAutoFooter : MJRefreshFooter
@property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;
@property (assign, nonatomic) CGFloat appearencePercentTriggerAutoRefresh MJRefreshDeprecated("请使用triggerAutomaticallyRefreshPercent属性");
@property (assign, nonatomic) CGFloat triggerAutomaticallyRefreshPercent;
@property (assign, nonatomic, getter=isOnlyRefreshPerDrag) BOOL onlyRefreshPerDrag;
@end
