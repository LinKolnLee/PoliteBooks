//
//  SearchViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/17.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "SearchViewController.h"
#import "PBSearchView.h"
#import "BaseCollectionView.h"
#import "DetailOrderCollectionViewCell.h"
@interface SearchViewController ()<UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

/**
 账本列表
 */
@property (nonatomic, strong) BaseCollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray<PBTableModel *> * tableDataSource;
@property(nonatomic,strong)NSMutableArray<PBBookModel *> * dataSource;

@property(nonatomic,strong)UIButton * backButton;

@property(nonatomic,strong)PBSearchView * searchView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableDataSource = [[NSMutableArray alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.collectionView];
    
    // 左侧按钮
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(25));
        make.top.mas_equalTo(kIphone6Width(55));
    }];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kIphone6Width(40));
        make.left.mas_equalTo(self.backButton.mas_right).offset(kIphone6Width(15));
        make.right.mas_equalTo(kIphone6Width(-10));
        make.height.mas_equalTo(kIphone6Width(50));
    }];
}
-(void)backButtonTouchUpInside:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(PBSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[PBSearchView alloc] init];
        WS(weakSelf);
        _searchView.serachViewTextfiledReturnBlock = ^(NSString * _Nonnull str) {
            [weakSelf queryTableListWithWord:str];
        };
    }
    return _searchView;
}
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        _backButton.adjustsImageWhenDisabled = NO;
        _backButton.adjustsImageWhenHighlighted = NO;
        [_backButton setImage:[UIImage imageNamed:@"NavigationBack"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(25);
        flowLayout.minimumInteritemSpacing = kIphone6Width(25);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(ScreenWidth/4, ScreenHeight - 160);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat topHeight = kIphone6Width(100);
        if (IPHONEXR || IPHONEXSMAX || IPhoneX) {
            topHeight = kIphone6Width(120);
        }
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(10, topHeight, ScreenWidth - 20, ScreenHeight - 100) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        //_collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"没有搜索到该用户的账单";
       // _collectionView.noDataTitle = @"你还没有记过该类型账";
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DetailOrderCollectionViewCell class] forCellWithReuseIdentifier:@"DetailOrderCollectionViewCell"];
    }
    return _collectionView;
}
#pragma mark - # Delegate
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailOrderCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DetailOrderCollectionViewCell alloc] init];
    }
   // cell.bookModel = self.bookModel;
    cell.model = self.tableDataSource[indexPath.row];
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

-(void)queryTableListWithWord:(NSString *)word{
    [self showLoadingAnimation];
    WS(weakSelf);
    [PBTableExtension querySearchBookListWithStr:word success:^(NSMutableArray<PBTableModel *> * _Nonnull tableList) {
        [weakSelf hiddenLoadingAnimation];
        weakSelf.tableDataSource = tableList;
        [weakSelf.collectionView reloadData];
    } fail:^(id _Nonnull error) {
        [weakSelf hiddenLoadingAnimation];
    }];
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
