#import "GuidancePageViewController.h"
#import "HWDevice.h"
#import "SuperTabBarController.h"
#import "SuperNavigationController.h"
@interface GuidancePageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *scrollArr;
@property (nonatomic, strong) UIImageView *scrollImg;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end
@implementation GuidancePageViewController
- (NSArray *)scrollArr {
    if (_scrollArr == nil) {
        _scrollArr = [[NSArray alloc] initWithObjects:@"guidance1",@"guidance2",@"guidance3", nil];
    }
    return _scrollArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
}
- (UIScrollView *)scrollView {
    CGFloat spa = 40;
    CGFloat hei = 40;
    CGFloat wid = (KSCREEN_WIDTH - spa * 5 ) / 2;
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.bounces = NO;
        for (int i = 0; i < self.scrollArr.count; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
            img.backgroundColor = [HWRandomColor randomColor];
            img.image = [UIImage imageNamed:self.scrollArr[i]];
            img.userInteractionEnabled = YES;
            [_scrollView addSubview:img];
            if (i == self.scrollArr.count - 1) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = [UIColor cyanColor];
                btn.frame = CGRectMake(spa, self.view.frame.size.height - 120, wid, hei);
                btn.layer.cornerRadius = 5;
                btn.layer.masksToBounds = YES;
                btn.tag = 111;
                [img addSubview:btn];
                [btn setTitle:@"注   册" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
                UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.backgroundColor = [HWRandomColor randomColor];
                btn1.frame = CGRectMake(KSCREEN_WIDTH - wid - spa, btn.top, wid, hei);
                btn1.layer.cornerRadius = 5;
                btn1.layer.masksToBounds = YES;
                btn1.tag = 222;
                [img addSubview:btn1];
                [btn1 setTitle:@"登  陆" forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        _scrollView.contentSize = CGSizeMake(self.scrollArr.count * self.view.frame.size.width, self.view.frame.size.height);
    }
    return _scrollView;
}
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 40)];
        _pageControl.backgroundColor = [UIColor purpleColor];
        _pageControl.numberOfPages = _scrollArr.count;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageControlTurn:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
- (void)pageControlTurn:(UIPageControl *)page {
    _scrollView.contentOffset = CGPointMake(page.currentPage * _scrollView.frame.size.width, 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = _scrollView.contentOffset.x / _scrollView.frame.size.width;
}
- (void)btn:(UIButton *)button {
    if (button.tag == 111) {
        SuperTabBarController *base = [[SuperTabBarController alloc] init];
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        win.rootViewController = base;
        [win makeKeyAndVisible];
        base.selectedIndex = 4;
        SuperNavigationController *na = base.viewControllers[4];
    }
    if (button.tag == 222) {
        SuperTabBarController *base = [[SuperTabBarController alloc] init];
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        win.rootViewController = base;
        [win makeKeyAndVisible];
        base.selectedIndex = 4;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
