//
//  IndexViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "IndexViewController.h"
#import "NewInputButton.h"
#import "IndexCollectionViewCell.h"
#import "DetailViewController.h"
#import "BooksViewController.h"
#import "BaseCollectionView.h"
#import "CreatBookView.h"
@interface IndexViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate,BaseCollectionViewButtonClickDelegate
>
@property(nonatomic,strong)CreatBookView * creatBookView;

@property (nonatomic, strong) UIButton *closeButton;

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账本列表
 */
@property (nonatomic, strong) BaseCollectionView *collectionView;

@property(nonatomic,strong)NewInputButton * inputButton;

@property (nonatomic,strong)NSMutableArray * tableNames;

@property(nonatomic,assign)NSInteger currentItem;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview: self.inputButton];
    [self addMasonry];
    self.currentItem = 0;
    self.tableNames = [[NSMutableArray alloc] init];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.collectionView) {
        [self.collectionView reloadData];
    }
    NSMutableArray * oldNames = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
    if (oldNames.count == 0) {
        self.inputButton.hidden = YES;
    }else{
        self.inputButton.hidden = NO;
    }

}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(84);
    }];
    [self.inputButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.collectionView.mas_centerX);
        make.centerY.mas_equalTo(self.collectionView.mas_bottom).offset(kIphone6Width(-20));
        make.width.mas_equalTo(kIphone6Width(42));
        make.height.mas_equalTo(kIphone6Width(60));
    }];
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.backgroundColor = kWhiteColor;
        _naviView.title = @"礼尚往来";
        _naviView.leftImage = @"Bookcase";
        _naviView.rightImage = @"Hammer";
        _naviView.rightHidden = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            BooksViewController * books = [[BooksViewController alloc] init];
            [weakSelf.navigationController pushViewController:books animated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            //右按钮点击
        };
    }
    return _naviView;
}
-(NewInputButton *)inputButton{
    if (!_inputButton) {
        _inputButton = [[NewInputButton alloc] init];
        _inputButton.backgroundColor = kWhiteColor;
        _inputButton.layer.cornerRadius = kIphone6Width(21);
        //_inputButton.clipsToBounds = YES;
        _inputButton.layer.borderColor = kBlackColor.CGColor;
        _inputButton.layer.borderWidth = 1;
        _inputButton.layer.shadowColor = kHexRGB(0xC9AF99).CGColor;
        _inputButton.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
        _inputButton.layer.shadowOpacity = 3.5;
        _inputButton.layer.shadowRadius = 2.0;
        [_inputButton addTarget:self action:@selector(inputButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inputButton;
}
- (void)closeButtonTouchUpInside:(UIButton *)sender {
    self.view.userInteractionEnabled = YES;
    [self.creatBookView removeFromSuperview];
    [self.closeButton removeFromSuperview];
}
-(void)inputButtonTouchUpInside:(UIButton *)sender{
    NSMutableArray * tableArr = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
    NSMutableArray * nameArr = [UserDefaultStorageManager readObjectForKey:kUSERBOOKNAMEKEY];
    NSString *bookName = nameArr[self.currentItem];
    NSArray *personArr = [kDataBase jq_lookupTable:tableArr[self.currentItem] dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",bookName];
    DetailViewController * detail = [[DetailViewController alloc] init];
    detail.dataSource = personArr;
    detail.isLook = NO;
    detail.currentTableName = tableArr[self.currentItem];
    [self.navigationController pushViewController:detail animated:YES];
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth -kIphone6Width(20))/2, ScreenHeight-kIphone6Width(100), kIphone6Width(20), kIphone6Width(20))];
        [_closeButton setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        _closeButton.backgroundColor = kWhiteColor;
        _closeButton.layer.cornerRadius = kIphone6Width(10);
        _closeButton.layer.masksToBounds = YES;
        _closeButton.layer.borderWidth = kIphone6Width(1);
        _closeButton.layer.borderColor = kBlackColor.CGColor;
        [_closeButton addTarget:self action:@selector(closeButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
-(CreatBookView *)creatBookView{
    if (!_creatBookView) {
        _creatBookView = [[CreatBookView alloc] initWithFrame:CGRectMake((ScreenWidth-kIphone6Width(250))/2, (ScreenHeight - kIphone6Width(375))/2, kIphone6Width(250), kIphone6Width(375))];
        WS(weakSelf);
        __weak CreatBookView * creatBookViewNew = _creatBookView;
        _creatBookView.CreatBookViewSaveButtonClickBlock = ^(NSString * _Nonnull bookName, NSString * _Nonnull bookData, NSInteger bookColor) {
            //数据库名
            weakSelf.view.userInteractionEnabled = YES;
            NSMutableArray * oldNames = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
            NSMutableArray * newNames = [[NSMutableArray alloc] init];
            //书名
            NSMutableArray * oldBookNames = [UserDefaultStorageManager readObjectForKey:kUSERBOOKNAMEKEY];
            NSMutableArray * newBookNames = [[NSMutableArray alloc] init];
            
            NSString * tableName = [NSString stringWithFormat:@"AccountBooks%@",bookName];
            if (![kDataBase jq_isExistTable:tableName]) {
                [kDataBase jq_createTable:tableName dicOrModel:[BooksModel class]];
                BooksModel * model = [[BooksModel alloc] init];
                model.bookName = bookName;
                model.bookDate = bookData;
                model.bookImage = arc4random() % 1;
                model.bookId = 0;
                model.bookMoney = @"0";
                model.name = @"";
                model.money = @"";
                model.data = @"";
                model.tableType = bookColor;
                [kDataBase jq_inDatabase:^{
                    [kDataBase jq_insertTable:tableName dicOrModel:model];
                }];
                for (NSString * name in oldNames) {
                    [newNames addObject:name];
                }
                [newNames addObject:tableName];
                
                for (NSString * bookname in oldBookNames) {
                    [newBookNames addObject:bookname];
                }
                [newBookNames addObject:bookName];
                [UserDefaultStorageManager removeObjectForKey:kUSERTABLENAMEKEY];
                [UserDefaultStorageManager saveObject:newNames forKey:kUSERTABLENAMEKEY];
                [UserDefaultStorageManager removeObjectForKey:kUSERBOOKNAMEKEY];
                [UserDefaultStorageManager saveObject:newBookNames forKey:kUSERBOOKNAMEKEY];
            }
            [creatBookViewNew removeFromSuperview];
            [weakSelf.closeButton removeFromSuperview];
            [weakSelf.collectionView reloadData];
        };
    }
    return _creatBookView;
}
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(14);
        flowLayout.minimumInteritemSpacing = kIphone6Width(15);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(kIphone6Width(345), kIphone6Width(480));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat topHeight = kIphone6Width(110);
        if (IPHONEXR || IPHONEXSMAX || IPhoneX) {
            topHeight = kIphone6Width(180);
        }
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(kIphone6Width(10), topHeight , ScreenWidth-kIphone6Width(20), kIphone6Width(500)) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"点击添加账本";
        [_collectionView registerClass:[IndexCollectionViewCell class] forCellWithReuseIdentifier:@"IndexCollectionViewCell"];
    }
    return _collectionView;
}
#pragma mark - # Delegate
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray * arr = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JQFMDB *dataBase = [JQFMDB shareDatabase];
    NSMutableArray * arr = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
    NSArray <BooksModel *> * models = [dataBase jq_lookupTable:arr[indexPath.row] dicOrModel:[BooksModel class] whereFormat:@"where bookId = '0'"];
    IndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IndexCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[IndexCollectionViewCell alloc] init];
    }
    cell.model = models[0];
    return cell;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray * tableArr = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
    NSMutableArray * nameArr = [UserDefaultStorageManager readObjectForKey:kUSERBOOKNAMEKEY];
    NSString *bookName = nameArr[indexPath.row];
    NSArray *personArr = [kDataBase jq_lookupTable:tableArr[indexPath.row] dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",bookName];
    DetailViewController * detail = [[DetailViewController alloc] init];
    detail.isLook = YES;
    detail.dataSource = personArr;
    detail.currentTableName = tableArr[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];

}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.25 animations:^{
        self.inputButton.hidden = YES;
    }];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [UIView animateWithDuration:0.25 animations:^{
        self.inputButton.hidden = NO;
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSMutableArray * tableArr = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % tableArr.count;
    self.currentItem = page;
}
-(void)baseCollectionViewButtonClick{
    self.view.userInteractionEnabled = NO;
    //右按钮点击
    [[UIApplication sharedApplication].keyWindow addSubview:self.creatBookView];
    [self animationWithView:self.creatBookView duration:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.closeButton];
}
-(void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                         
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                         
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                         
                         [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    animation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}


@end
