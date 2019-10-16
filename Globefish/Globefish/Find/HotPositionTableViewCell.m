#import "HotPositionTableViewCell.h"
#import "GFHCollectionViewCell.h"
#import "UIView+HWUtilView.h"
@interface HotPositionTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *itemArr;
@end
@implementation HotPositionTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColor_BackGround;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    [self addSubview:self.collectionView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(15, 15, self.width - 30, self.height - 30);
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(184, 92);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, self.width - 30, self.height) collectionViewLayout:flow];
        _collectionView.backgroundColor = KColor_BackGround;
        _collectionView.contentSize = CGSizeMake(self.width, self.height);
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[GFHCollectionViewCell class] forCellWithReuseIdentifier:@"HotCollectionViewCell"];
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCollectionViewCell" forIndexPath:indexPath];
    cell.commonModel = self.itemArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionDidSelectItemBlock) {
        self.collectionDidSelectItemBlock(self.itemArr[indexPath.row]);
    }
}
- (void)setCellArr:(NSArray *)cellArr {
    if (_cellArr != cellArr) {
        _cellArr = cellArr;
        self.itemArr = [[NSMutableArray alloc] initWithArray:_cellArr];
        [self.collectionView reloadData];
    }
}
- (NSMutableArray *)itemArr {
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
