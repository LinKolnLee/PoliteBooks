//
//  MineViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/13.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "MineViewController.h"
#import "MineChartCollectionViewCell.h"
#import "WJFlowLayout.h"
#import "RealtionViewController.h"
@interface MineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSMutableArray * dataSource;

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic,strong)UILabel * bookNumberLabel;

@property(nonatomic,strong)UILabel * inMoneyLabel;

@property(nonatomic,strong)UILabel * outMoneyLabel;

@property(nonatomic,strong)NSString * bookNumber;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview: self.collectionView];
    [self.view addSubview:self.bookNumberLabel];
    [self.view addSubview:self.inMoneyLabel];
    [self.view addSubview:self.outMoneyLabel];
    [self addMosary];
    [self queryBookList];
    self.bookNumber = @" ";
}
-(void)addMosary{
    [self.bookNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ScreenWidth + 124);
        make.right.mas_equalTo(kIphone6Width(-15));
    }];
    [self.inMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bookNumberLabel.mas_bottom).offset(20);
        make.right.mas_equalTo(kIphone6Width(-15));
    }];
    [self.outMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inMoneyLabel.mas_bottom).offset(20);
        make.right.mas_equalTo(kIphone6Width(-15));
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark - # Getter
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 84)];
        _naviView.backgroundColor = kWhiteColor;
        _naviView.title = @"用户账簿信息";
        _naviView.titleFont = kFont15;
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"realtion";
        _naviView.rightHidden = NO;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            //右按钮点击
            RealtionViewController * realtion = [[RealtionViewController alloc] init];
            [weakSelf.navigationController hh_pushBackViewController:realtion];
        };
    }
    return _naviView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(10);
        flowLayout.minimumInteritemSpacing = kIphone6Width(20);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(ScreenWidth-50, ScreenWidth-20);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kIphone6Width(10), 104 , ScreenWidth-20,ScreenWidth) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[MineChartCollectionViewCell class] forCellWithReuseIdentifier:@"MineChartCollectionViewCell"];
    }
    return _collectionView;
}
-(UILabel *)bookNumberLabel{
    if (!_bookNumberLabel) {
        _bookNumberLabel = [[UILabel alloc] init];
        _bookNumberLabel.font = kPingFangTC_Light(15);
        _bookNumberLabel.text = @"账簿个数";
        _bookNumberLabel.textColor = kHexRGB(0x3f3f4d);
        _bookNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bookNumberLabel;
}
-(UILabel *)inMoneyLabel{
    if (!_inMoneyLabel) {
        _inMoneyLabel = [[UILabel alloc] init];
        _inMoneyLabel.font = kPingFangTC_Light(15);
        _inMoneyLabel.text = @"总进礼：1000";
        _inMoneyLabel.textColor = kHexRGB(0x3f3f4d);
        _inMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _inMoneyLabel;
}
-(UILabel *)outMoneyLabel{
    if (!_outMoneyLabel) {
        _outMoneyLabel = [[UILabel alloc] init];
        _outMoneyLabel.font = kPingFangTC_Light(15);
        _outMoneyLabel.text = @"总收礼：1000";
        _outMoneyLabel.textColor = kHexRGB(0x3f3f4d);
        _outMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _outMoneyLabel;
}
#pragma mark - # Delegate
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MineChartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineChartCollectionViewCell" forIndexPath:indexPath];
    cell.layer.shadowColor = kHexRGB(0x75664d).CGColor;
    cell.layer.shadowOffset = CGSizeMake(2, 4);
    cell.layer.shadowOpacity = 0.5;
    if (!cell) {
        cell = [[MineChartCollectionViewCell alloc] init];
    }
    cell.index = indexPath.row;
    cell.bookModels = self.dataSource[indexPath.row];
    return cell;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
}

-(void)queryBookList{
    WS(weakSelf);
    [BmobBookExtension queryBookListsuccess:^(NSMutableArray<PBBookModel *> * _Nonnull bookList) {
        if (bookList.count == 0) {
        }else{
            weakSelf.dataSource = [NSMutableArray arrayWithObjects:bookList,bookList, nil];
            [weakSelf.collectionView reloadData];
            weakSelf.bookNumber = [NSString stringWithFormat:@"%ld",bookList.count];
            [weakSelf reloadSubviews];
        }
    } fail:^(id _Nonnull error) {
    }];
}
-(void)reloadSubviews{
    NSString * str = [NSString stringWithFormat: @"账簿个数: %@  ",self.bookNumber];
    self.bookNumberLabel.text = str;
    NSInteger inMoney = 0;
    for (PBBookModel * model in self.dataSource[0]) {
        inMoney = inMoney + model.bookInMoney;
    }
    self.inMoneyLabel.text = [NSString stringWithFormat:@"总收礼: %ld  ",inMoney];
    NSInteger outMoney = 0;
    for (PBBookModel * model in self.dataSource[0]) {
        outMoney = outMoney + model.bookOutMoney;
    }
    self.outMoneyLabel.text = [NSString stringWithFormat:@"总进礼: %ld  ",outMoney];
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
