#import "SortViewController.h"
#import "LocationTableViewCell.h"
#import "HWUtil.h"
#import "HWStyle.h"
@interface SortViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableViewArr;
@property (nonatomic, assign) NSInteger selectInteger;
@end
@implementation SortViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubView];
}
- (void)configSubView {
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 132)];
    back.backgroundColor = [HWUtil colorWithHexString:@"fafafa"];
    [self.view addSubview:back];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, back.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = YES;
    [back addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LocationTableViewCell class] forCellReuseIdentifier:@"LocationTableViewCell"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationTableViewCell"];
    cell.titleLab.text = self.tableViewArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentSelectItemTitle) {
        self.currentSelectItemTitle(self.tableViewArr[indexPath.row]);
    }
}
- (NSMutableArray *)tableViewArr {
    if (!_tableViewArr) {
        _tableViewArr = [[NSMutableArray alloc] initWithObjects:@"默认排序",@"最新发布",@"薪酬最高", nil];
    }
    return _tableViewArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
