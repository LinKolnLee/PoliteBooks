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
#import "DateViewController.h"
#import "SettingViewController.h"
#import <Social/Social.h>
#import "WJFlowLayout.h"
#import "LoginViewController.h"
#import "MineViewController.h"
#import "TranslationMicTipView.h"
@interface IndexViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate,BaseCollectionViewButtonClickDelegate
>
@property(nonatomic,strong)CreatBookView * creatBookView;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIButton *userButton;

@property(nonatomic,strong)UIButton * shareButton;

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账簿列表
 */
@property (nonatomic, strong) BaseCollectionView *collectionView;


@property (nonatomic,strong)NSMutableArray * tableNames;

@property(nonatomic,assign)NSInteger currentItem;

@property(nonatomic,strong)NSMutableArray<PBBookModel *> * dataSource;

@property(nonatomic,strong)TranslationMicTipView * micTipView;


@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.userButton];
    [self addMasonry];
    self.currentItem = 0;
    self.tableNames = [[NSMutableArray alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSelfDataSource) name:kUserRegiseBook object:nil];
}
//-(void)reloadSelfDataSource{
//    [self queryBookList];
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (kMemberInfoManager.objectId) {
        [self queryBookList];
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([UserGuideManager isGuideWithIndex:0]) {
        [self guidanceWithIndex:0];
    }
}

-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(74);
    }];
    [self.userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kIphone6Width(-20));
        make.right.mas_equalTo(kIphone6Width((-20)));
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(25));
    }];
}

-(UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.title = @"礼账";
        _naviView.leftImage = @"Bookcase";
        _naviView.rightImage = @"chart";
        _naviView.rightHidden = NO;
        _naviView.titleFont = kFont16;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            BooksViewController * books = [[BooksViewController alloc] init];
            [weakSelf.navigationController pushViewController:books animated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            MineViewController * mine = [[MineViewController alloc] init];
            [weakSelf.navigationController hh_pushErectViewController:mine];
        };
    }
    return _naviView;
}

-(UIButton *)userButton{
    if (!_userButton) {
        _userButton = [[UIButton alloc] init];
        [_userButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [_userButton addTarget:self action:@selector(userButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userButton;
}
-(void)userButtonTouchUpInside:(UIButton *)sender{
//    if (kMemberInfoManager.mobilePhoneNumber) {
//        //个人中心
//        
//    }else{
//        //注册
//        LoginViewController * login = [[LoginViewController alloc] init];
//        [self.navigationController hh_pushErectViewController:login];
//    }
    //右按钮点击
    SettingViewController * setting = [[SettingViewController alloc] init];
    setting.dataSource = self.dataSource;
    [self.navigationController hh_pushTiltViewController:setting];
   
}
- (void)closeButtonTouchUpInside:(UIButton *)sender {
    self.view.userInteractionEnabled = YES;
    [self.creatBookView removeFromSuperview];
    [self.closeButton removeFromSuperview];
}
- (void)shareButtonTouchUpInside:(UIButton *)sender {
    SettingViewController * setting = [[SettingViewController alloc] init];
    [self.navigationController hh_pushTiltViewController:setting];
}
/*

-(void)inputButtonTouchUpInside:(UIButton *)sender{
    DetailViewController * detail = [[DetailViewController alloc] init];
    detail.bookModel = self.dataSource[self.currentItem];
    detail.isLook = NO;
    [self.navigationController pushViewController:detail animated:YES];
}*/
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
            PBBookModel * model = [[PBBookModel alloc] init];
            model.bookName = bookName;
            model.bookDate = bookData;
            model.bookColor = bookColor;
            [weakSelf saveBookModel:model];
            [creatBookViewNew removeFromSuperview];
            [weakSelf.closeButton removeFromSuperview];
            [weakSelf.collectionView reloadData];
        };
    }
    return _creatBookView;
}
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        WJFlowLayout *layout = [[WJFlowLayout alloc]init];
        CGFloat topHeight = kIphone6Width(110);
        if (IPHONEXR || IPHONEXSMAX || IPhoneX) {
            topHeight = kIphone6Width(180);
        }
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(kIphone6Width(10), topHeight , ScreenWidth-kIphone6Width(20), kIphone6Width(500)) collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"点击添加账簿";
        [_collectionView registerClass:[IndexCollectionViewCell class] forCellWithReuseIdentifier:@"IndexCollectionViewCell"];
    }
    return _collectionView;
}
#pragma mark - # Delegate
//MARK: UICollectionViewDataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IndexCollectionViewCell" forIndexPath:indexPath];
    cell.layer.shadowColor = kHexRGB(0x75664d).CGColor;
    cell.layer.shadowOffset = CGSizeMake(2, 4);
    cell.layer.shadowOpacity = 0.5;
    if (!cell) {
        cell = [[IndexCollectionViewCell alloc] init];
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController * detail = [[DetailViewController alloc] init];
    detail.isLook = YES;
    detail.bookModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];

}

/*
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.25 animations:^{
        self.inputButton.hidden = YES;
    }];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [UIView animateWithDuration:0.25 animations:^{
        self.inputButton.hidden = NO;
    }];
}*/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % self.dataSource.count;
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

-(void)saveBookModel:(PBBookModel *)model{
    WS(weakSelf);
    [BmobBookExtension inserDataForModel:model success:^(id  _Nonnull responseObject) {
        [weakSelf queryBookList];
    }];
}
-(void)queryBookList{
    [self showLoadingAnimation];
    WS(weakSelf);
    [BmobBookExtension queryBookListsuccess:^(NSMutableArray<PBBookModel *> * _Nonnull bookList) {
       [weakSelf hiddenLoadingAnimation];
        weakSelf.dataSource = bookList;
//        if (bookList.count == 0) {
//            weakSelf.inputButton.hidden = YES;
//        }else{
//            weakSelf.inputButton.hidden = NO;
//        }
        [weakSelf.collectionView reloadData];
    } fail:^(id _Nonnull error) {
        [weakSelf hiddenLoadingAnimation];
    }];
}
-(void)setupTipViewWithCell{
    CGFloat popHeight =kIphone6Width(35.0);
    CGRect popRect = CGRectMake(0, kIphone6Width(0), kIphone6Width(200), popHeight);
    self.micTipView = [[TranslationMicTipView alloc] initWithFrame:popRect Title:@"登录后数据可以实时备份 ，更安全哦~"];
    self.micTipView.centerX = ScreenWidth/2;
    self.micTipView.centerY = ScreenHeight - kIphone6Width(17.7);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipViewTouchUpInside:)];
    [self.micTipView addGestureRecognizer:tap];
    [self.view addSubview:self.micTipView];
    if (![BmobUser currentUser].mobilePhoneNumber) {
        self.micTipView.hidden = NO;
    }else{
        self.micTipView.hidden = YES;
    }
}
-(void)tipViewTouchUpInside:(UIGestureRecognizer *)ges{
    LoginViewController * login = [[LoginViewController alloc] init];
        [self.navigationController hh_pushErectViewController:login];
}

@end
