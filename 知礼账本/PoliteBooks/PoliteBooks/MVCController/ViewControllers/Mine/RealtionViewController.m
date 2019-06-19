//
//  RealtionViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/19.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "RealtionViewController.h"
#import "SPMultipleSwitch.h"
#import "BaseCollectionView.h"
#import "DetailOrderCollectionViewCell.h"
@interface RealtionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;
@property(nonatomic,strong)SPMultipleSwitch * relationTypeSwitch;
@property (nonatomic, strong) BaseCollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray * dataSource;

@property(nonatomic,strong)NSMutableArray * strongDataSource;

@end

@implementation RealtionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] init];
    self.strongDataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.relationTypeSwitch];
    [self.view addSubview:self.collectionView];
   
    [self queryBookList];
    // Do any additional setup after loading the view.
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 84)];
        _naviView.backgroundColor = kWhiteColor;
        _naviView.title = @"用户关系信息";
        _naviView.titleFont = kFont15;
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"realtion";
        _naviView.rightHidden = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _naviView;
}
-(SPMultipleSwitch *)relationTypeSwitch{
    if (!_relationTypeSwitch) {
        _relationTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"亲戚",@"朋友",@"同学",@"同事",@"邻里"]];
        _relationTypeSwitch.frame = CGRectMake(15, kIphone6Width(95), ScreenWidth-30, 30);
        _relationTypeSwitch.backgroundColor = kHexRGB(0xe9f1f6);
        _relationTypeSwitch.selectedTitleColor = kWhiteColor;
        _relationTypeSwitch.titleColor = kHexRGB(0x665757);
        _relationTypeSwitch.trackerColor = kHexRGB(0x3f3f4d);
        _relationTypeSwitch.contentInset = 5;
        _relationTypeSwitch.spacing = 10;
        _relationTypeSwitch.titleFont = kFont14;
        
        [_relationTypeSwitch addTarget:self action:@selector(relationTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _relationTypeSwitch;
}
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(14);
        flowLayout.minimumInteritemSpacing = kIphone6Width(10);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(ScreenWidth/4, kIphone6Width(500));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(3, kIphone6Width(140) , ScreenWidth - 6, kIphone6Width(530)) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.noDataTitle = @"记一笔~";
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DetailOrderCollectionViewCell class] forCellWithReuseIdentifier:@"DetailOrderCollectionViewCell"];
    }
    return _collectionView;
}
-(void)relationTypeSwitchAction:(SPMultipleSwitch *)swit{
    [self setupCellDatasourceWithItem:swit.selectedSegmentIndex];
}

#pragma mark - # Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailOrderCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DetailOrderCollectionViewCell alloc] init];
    }
    cell.model = self.dataSource[indexPath.row];
    cell.layer.cornerRadius = kIphone6Width(10);
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = kHexRGB(0xf6f5ec);
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, ScreenWidth/4, ScreenHeight-160);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, ScreenWidth/4, ScreenHeight-160);
    borderLayer.lineWidth = 1.f;
    borderLayer.strokeColor = kBlackColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth/4, ScreenHeight-160) cornerRadius:kIphone6Width(15)];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
    [cell.layer setMask:maskLayer];
}
-(void)queryBookList{
    [self showLoadingAnimation];
    WS(weakSelf);
    [PBTableExtension queryRealtionTableLissuccess:^(NSMutableArray<PBTableModel *> * _Nonnull tableList) {
        [weakSelf hiddenLoadingAnimation];
        weakSelf.strongDataSource = tableList;
        [weakSelf setupCellDatasourceWithItem:0];
    } fail:^(id _Nonnull error) {
        [weakSelf hiddenLoadingAnimation];
    }];
}
-(void)setupCellDatasourceWithItem:(NSInteger)item{
    [self.dataSource removeAllObjects];
    NSArray * items = @[@"亲戚",@"朋友",@"同学",@"同事",@"邻里"];
    for (PBTableModel*model in self.strongDataSource) {
        if ([model.userRelation isEqualToString:items[item]]) {
            [self.dataSource addObject:model];
        }
    }
    [self.collectionView reloadData];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
