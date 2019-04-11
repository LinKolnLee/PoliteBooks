//
//  DetailViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "InputViewController.h"
#import "TranslationMicTipView.h"

@interface DetailViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate
>
/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账本列表
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 navi
 */
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)BooksModel * naviModel;

@property(nonatomic,strong)TranslationMicTipView * micTipView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.collectionView];
    [self addMasonry];
    if (self.dataSource.count != 1) {
        [self setupTipViewWithCell];
    }
    // Do any additional setup after loading the view.
}
-(void)setupTipViewWithCell{
    CGFloat popHeight =kIphone6Width(35.0);
    CGRect popRect = CGRectMake(0, kIphone6Width(0), kIphone6Width(140), popHeight);
    self.micTipView = [[TranslationMicTipView alloc] initWithFrame:popRect Title:@"选中长按删除条目"];
    self.micTipView.centerX = ScreenWidth/2;
    self.micTipView.centerY = ScreenHeight - kIphone6Width(50);
    [self.view addSubview:self.micTipView];
    [self performSelector:@selector(hideTipView) withObject:nil afterDelay:3.0];
}
- (void)hideTipView {
    WS(weakSelf);
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.micTipView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.micTipView.hidden = YES;
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_isLook) {
        InputViewController *circleVC = [InputViewController new];
        //circleVC.isNeedShow = YES;
        circleVC.dateSource = _dataSource;
        circleVC.currentTableName = _currentTableName;
        WS(weakSelf);
        circleVC.InputViewControllerPopBlock = ^{
            weakSelf.dataSource = [kDataBase jq_lookupTable:weakSelf.currentTableName dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",weakSelf.dataSource[0].bookName];
            [weakSelf.collectionView reloadData];
        };
        [self.navigationController hh_presentTiltedVC:circleVC completion:nil];
    }
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(74);
    }];
//    [self.inputButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.collectionView.mas_centerX);
//        make.centerY.mas_equalTo(self.collectionView.mas_bottom).offset(kIphone6Width(-20));
//        make.width.mas_equalTo(kIphone6Width(42));
//        make.height.mas_equalTo(kIphone6Width(60));
//    }];
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.backgroundColor = kWhiteColor;
        //@"貳零壹玖年壹月往来明细";
        _naviView.titleFont = kFont12;
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"Chinesebrush";
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            //右按钮点击
            VIBRATION;
            InputViewController *circleVC = [InputViewController new];
            //circleVC.isNeedShow = YES;
            circleVC.dateSource = weakSelf.dataSource;
            circleVC.currentTableName = weakSelf.currentTableName;
            //WS(weakSelf);
            circleVC.InputViewControllerPopBlock = ^{
                weakSelf.dataSource = [kDataBase jq_lookupTable:weakSelf.currentTableName dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",weakSelf.dataSource[0].bookName];
                [weakSelf.collectionView reloadData];
            };
            [weakSelf.navigationController hh_presentTiltedVC:circleVC completion:nil];
            VIBRATION;
        };
    }
    return _naviView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat topHeight = kIphone6Width(90);
        if (IPHONEXR || IPHONEXSMAX || IPhoneX) {
            topHeight = kIphone6Width(100);
        }
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(14);
        flowLayout.minimumInteritemSpacing = kIphone6Width(15);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - topHeight - kIphone6Width(49));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topHeight , ScreenWidth, ScreenHeight - topHeight - kIphone6Width(49)) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"DetailCollectionViewCell"];
    }
    return _collectionView;
}
#pragma mark - # Delegate
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DetailCollectionViewCell alloc] init];
    }
    cell.currentTableName = self.currentTableName;
    WS(weakSelf);
    cell.detailCollectionViewCellCreateBookBlock = ^{
        VIBRATION;
        InputViewController *circleVC = [InputViewController new];
        //circleVC.isNeedShow = YES;
        circleVC.dateSource = weakSelf.dataSource;
        circleVC.currentTableName = weakSelf.currentTableName;
        //WS(weakSelf);
        circleVC.InputViewControllerPopBlock = ^{
            weakSelf.dataSource = [kDataBase jq_lookupTable:weakSelf.currentTableName dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",weakSelf.dataSource[0].bookName];
            [weakSelf.collectionView reloadData];
        };
        [weakSelf.navigationController hh_presentTiltedVC:circleVC completion:nil];
        VIBRATION;
    };
    cell.detailDataSource = self.dataSource;
    return cell;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}
-(void)setIsLook:(BOOL)isLook{
    _isLook = isLook;
    
}
-(void)setDataSource:(NSArray<BooksModel *> *)dataSource{
    _dataSource = dataSource;
    self.naviModel = dataSource[0];
    self.naviView.title = [NSString stringWithFormat:@"%@往来明细",self.naviModel.bookName];
}
-(void)setCurrentTableName:(NSString *)currentTableName{
    _currentTableName = currentTableName;
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
