#import "MJRefreshAutoFooter.h"
@interface MJRefreshAutoFooter()
@property (assign, nonatomic, getter=isOneNewPan) BOOL oneNewPan;
@end
@implementation MJRefreshAutoFooter
#pragma mark - 初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) { 
        if (self.hidden == NO) {
            self.scrollView.mj_insetB += self.mj_h;
        }
        self.mj_y = _scrollView.mj_contentH;
    } else { 
        if (self.hidden == NO) {
            self.scrollView.mj_insetB -= self.mj_h;
        }
    }
}
#pragma mark - 过期方法
- (void)setAppearencePercentTriggerAutoRefresh:(CGFloat)appearencePercentTriggerAutoRefresh
{
    self.triggerAutomaticallyRefreshPercent = appearencePercentTriggerAutoRefresh;
}
- (CGFloat)appearencePercentTriggerAutoRefresh
{
    return self.triggerAutomaticallyRefreshPercent;
}
#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    self.triggerAutomaticallyRefreshPercent = 1.0;
    self.automaticallyRefresh = YES;
    self.onlyRefreshPerDrag = NO;
}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    self.mj_y = self.scrollView.mj_contentH;
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    if (self.state != MJRefreshStateIdle || !self.automaticallyRefresh || self.mj_y == 0) return;
    if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { 
        if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h * self.triggerAutomaticallyRefreshPercent + _scrollView.mj_insetB - self.mj_h) {
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y <= old.y) return;
            [self beginRefreshing];
        }
    }
}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    if (self.state != MJRefreshStateIdle) return;
    UIGestureRecognizerState panState = _scrollView.panGestureRecognizer.state;
    if (panState == UIGestureRecognizerStateEnded) {
        if (_scrollView.mj_insetT + _scrollView.mj_contentH <= _scrollView.mj_h) {  
            if (_scrollView.mj_offsetY >= - _scrollView.mj_insetT) { 
                [self beginRefreshing];
            }
        } else { 
            if (_scrollView.mj_offsetY >= _scrollView.mj_contentH + _scrollView.mj_insetB - _scrollView.mj_h) {
                [self beginRefreshing];
            }
        }
    } else if (panState == UIGestureRecognizerStateBegan) {
        self.oneNewPan = YES;
    }
}
- (void)beginRefreshing
{
    if (!self.isOneNewPan && self.isOnlyRefreshPerDrag) return;
    [super beginRefreshing];
    self.oneNewPan = NO;
}
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    if (state == MJRefreshStateRefreshing) {
        [self executeRefreshingCallback];
    } else if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        if (MJRefreshStateRefreshing == oldState) {
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }
    }
}
- (void)setHidden:(BOOL)hidden
{
    BOOL lastHidden = self.isHidden;
    [super setHidden:hidden];
    if (!lastHidden && hidden) {
        self.state = MJRefreshStateIdle;
        self.scrollView.mj_insetB -= self.mj_h;
    } else if (lastHidden && !hidden) {
        self.scrollView.mj_insetB += self.mj_h;
        self.mj_y = _scrollView.mj_contentH;
    }
}
@end
