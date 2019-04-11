//
//  BooksViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/1/14.
//  Copyright © 2019 Beauty. All rights reserved.
//
#import "CreatBookView.h"
#import "BooksViewController.h"
#import "BooksCollectionViewCell.h"
#import "BooksModel.h"
#import "DetailViewController.h"
#import "BaseCollectionView.h"
@interface BooksViewController()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate,BaseCollectionViewButtonClickDelegate
>


@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账本列表
 */
@property (nonatomic, strong) BaseCollectionView *collectionView;

@property (nonatomic, strong) NSIndexPath *longPressIndexPath;

@property(nonatomic,strong)CreatBookView * creatBookView;

///
@property (nonatomic, strong) UIButton *closeButton;



@end
@implementation BooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.collectionView];
    [self addMasonry];
    
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(84);
    }];
}

-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.backgroundColor = kWhiteColor;
        _naviView.title = @"往年";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"addBooks";
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            //右按钮点击
            weakSelf.view.userInteractionEnabled = NO;
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.creatBookView];
            [weakSelf animationWithView:weakSelf.creatBookView duration:0.5];
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.closeButton];
        };
    }
    return _naviView;
}
-(CreatBookView *)creatBookView{
    if (!_creatBookView) {
        _creatBookView = [[CreatBookView alloc] initWithFrame:CGRectMake((ScreenWidth-kIphone6Width(250))/2, (ScreenHeight - kIphone6Width(375))/2, kIphone6Width(250), kIphone6Width(375))];
        WS(weakSelf);
        __weak CreatBookView * creatBookViewNew = _creatBookView;

        _creatBookView.CreatBookViewSaveButtonClickBlock = ^(NSString * _Nonnull bookName, NSString * _Nonnull bookData, NSInteger bookColor) {
            weakSelf.view.userInteractionEnabled = YES;
            //数据库名
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
            }else{
                [LEEAlert actionsheet].config
                .LeeTitle(@"提示")
                .LeeContent([NSString stringWithFormat:@"您已经有一个名称为“%@”的账本了",bookName])
                .LeeAction(@"好的", ^{
                })
                .LeeShow();
            }
            creatBookViewNew.bookNameTextField.text = @"";
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
        flowLayout.minimumLineSpacing = kIphone6Width(15);
        flowLayout.minimumInteritemSpacing = kIphone6Width(5);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(kIphone6Width(150), kIphone6Width(200));
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat topHeight = kIphone6Width(110);
        if (IPHONEXR || IPHONEXSMAX || IPhoneX) {
            topHeight = kIphone6Width(130);
        }
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(kIphone6Width(10), topHeight , ScreenWidth-kIphone6Width(20), ScreenHeight - kIphone6Width(90)) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"点击添加账本";
        [_collectionView registerClass:[BooksCollectionViewCell class] forCellWithReuseIdentifier:@"BooksCollectionViewCell"];
    }
    return _collectionView;
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
#pragma mark - # Event Response
- (void)closeButtonTouchUpInside:(UIButton *)sender {
    self.view.userInteractionEnabled = YES;
    [self.creatBookView removeFromSuperview];
    [self.closeButton removeFromSuperview];
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
    BooksCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BooksCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BooksCollectionViewCell alloc] init];
    }
    if (indexPath.row == 0) {
        cell.isShowTip = YES;
    }
    cell.bookModel = models[0];
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
    longPressGR.minimumPressDuration = 1;
    [cell addGestureRecognizer:longPressGR];
    return cell;
}
-(void)lpGR:(UILongPressGestureRecognizer *)lpGR
{
    if (lpGR.state == UIGestureRecognizerStateBegan) {//手势开始
        CGPoint point = [lpGR locationInView:self.collectionView];
        VIBRATION;
        self.longPressIndexPath = [self.collectionView indexPathForItemAtPoint:point];// 可以获取我们在哪个cell上长按
        [self showAlert];
       
    }
}
-(void)showAlert{
    JQFMDB *dataBase = [JQFMDB shareDatabase];
    NSMutableArray * arr = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
    NSArray <BooksModel *> * models = [dataBase jq_lookupTable:arr[self.longPressIndexPath.row] dicOrModel:[BooksModel class] whereFormat:@"where bookId = '0'"];
    UIColor *blueColor = TypeColor[models[0].tableType];
    WS(weakSelf);
    [LEEAlert alert].config
    .LeeAddTitle(^(UILabel *label) {
        label.text = @"确认删除?";
        label.textColor = kWhiteColor;
    })
    .LeeAddContent(^(UILabel *label) {
        label.text = @"删除后将无法恢复, 请慎重考虑";
        label.textColor = [kWhiteColor colorWithAlphaComponent:0.75f];
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeCancel;
        action.title = @"取消";
        action.titleColor = blueColor;
        action.backgroundColor = kWhiteColor;
        action.clickBlock = ^{
        };
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeDefault;
        action.title = @"删除";
        action.titleColor = blueColor;
        action.backgroundColor = kWhiteColor;
        action.clickBlock = ^{
            // 删除点击事件Block
            [dataBase jq_deleteAllDataFromTable:[NSString stringWithFormat:@"AccountBooks%@",models[0].bookName]];
            //删除表名称
            NSMutableArray * arr = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
            NSMutableArray * newArr = [[NSMutableArray alloc] init];
            for (int i = 0; i<arr.count; i++) {
                if (i != weakSelf.longPressIndexPath.row) {
                    [newArr addObject:arr[i]];
                }
            }
            //删除账本名称
            NSMutableArray * oldBookNames = [UserDefaultStorageManager readObjectForKey:kUSERBOOKNAMEKEY];
            
            NSMutableArray * newBookNameArr = [[NSMutableArray alloc] init];
            for (int i = 0; i<oldBookNames.count; i++) {
                if (i != weakSelf.longPressIndexPath.row) {
                    [newBookNameArr addObject:oldBookNames[i]];
                }
            }
            [UserDefaultStorageManager removeObjectForKey:kUSERBOOKNAMEKEY];
            [UserDefaultStorageManager saveObject:newBookNameArr forKey:kUSERBOOKNAMEKEY];
            
            
            [UserDefaultStorageManager removeObjectForKey:kUSERTABLENAMEKEY];
            [UserDefaultStorageManager saveObject:newArr forKey:kUSERTABLENAMEKEY];
            [weakSelf.collectionView reloadData]; //刷新tableView;
        };
    })
    .LeeHeaderColor(blueColor)
    .LeeShow();
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

-(void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    animation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}
-(void)baseCollectionViewButtonClick{
    self.view.userInteractionEnabled = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self.creatBookView];
    [self animationWithView:self.creatBookView duration:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.closeButton];
}
@end
