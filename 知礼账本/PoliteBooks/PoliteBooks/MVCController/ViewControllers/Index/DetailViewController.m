//
//  DetailViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailOrderCollectionViewCell.h"
#import "InputViewController.h"
#import "TranslationMicTipView.h"
#import "BaseCollectionView.h"
@interface DetailViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
BaseCollectionViewButtonClickDelegate
>
/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账本列表
 */
@property (nonatomic, strong) BaseCollectionView *collectionView;

/**
 navi
 */
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)BooksModel * naviModel;

@property(nonatomic,strong)TranslationMicTipView * micTipView;

@property (nonatomic, strong) NSIndexPath *longPressIndexPath;

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
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(14);
        flowLayout.minimumInteritemSpacing = kIphone6Width(15);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(ScreenWidth/7, ScreenHeight - 160);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat topHeight = kIphone6Width(100);
        if (IPHONEXR || IPHONEXSMAX || IPhoneX) {
            topHeight = kIphone6Width(120);
        }
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 84 , ScreenWidth, ScreenHeight - 100) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"点击开始记账";
        _collectionView.noDataTitle = @"你还没有记过该类型账";
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
    return self.dataSource.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailOrderCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DetailOrderCollectionViewCell alloc] init];
    }
    cell.model = self.dataSource[indexPath.row + 1];
    cell.layer.cornerRadius = kIphone6Width(10);
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = kHexRGB(0xf6f5ec);
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
    longPressGR.minimumPressDuration = 1;
    [cell addGestureRecognizer:longPressGR];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, ScreenWidth/7, ScreenHeight-160);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, ScreenWidth/7, ScreenHeight-160);
    borderLayer.lineWidth = 1.f;
    borderLayer.strokeColor = kBlackColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth/7, ScreenHeight-160) cornerRadius:kIphone6Width(15)];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
    [cell.layer setMask:maskLayer];
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
    UIColor *blueColor = TypeColor[self.dataSource[0].tableType];
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
            [kDataBase jq_inDatabase:^{
                [kDataBase jq_deleteTable:self.currentTableName whereFormat:@"WHERE bookId = '%d'",self.dataSource[self.longPressIndexPath.row + 1].bookId];
                self.dataSource = [kDataBase jq_lookupTable:self.currentTableName dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",self.dataSource[0].bookName];
                [weakSelf.collectionView reloadData]; //刷新tableview
            }];
        };
    })
    .LeeHeaderColor(blueColor)
    .LeeShow();
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
-(void)baseCollectionViewButtonClick{
    VIBRATION;
    InputViewController *circleVC = [InputViewController new];
    //circleVC.isNeedShow = YES;
    circleVC.dateSource = self.dataSource;
    circleVC.currentTableName = self.currentTableName;
    WS(weakSelf);
    circleVC.InputViewControllerPopBlock = ^{
        weakSelf.dataSource = [kDataBase jq_lookupTable:weakSelf.currentTableName dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",weakSelf.dataSource[0].bookName];
        [weakSelf.collectionView reloadData];
    };
    [self.navigationController hh_presentTiltedVC:circleVC completion:nil];
    VIBRATION;
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
