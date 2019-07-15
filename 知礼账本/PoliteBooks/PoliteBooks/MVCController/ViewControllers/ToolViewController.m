//
//  ToolViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/28.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ToolViewController.h"
#import "ToolCollectionViewCell.h"
#import "KeepAccountViewController.h"
@interface ToolViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,UIScrollViewDelegate,BaseCollectionViewButtonClickDelegate
>

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)BaseCollectionView *  collectionview;

@property(nonatomic,strong)NSMutableArray<PBQuickModel *> * dataSource;

@property (nonatomic, strong) NSIndexPath *longPressIndexPath;

@end

@implementation ToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.collectionview];
    [self addMasonry];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self queryQuickList];
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationHeight);
    }];
    
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.title = @"日常速记";
         _naviView.rightImage = @"addNewBooks";
        _naviView.titleFont = kFont18;
         _naviView.isShadow = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            KeepAccountViewController * keep = [[KeepAccountViewController alloc] init];
            keep.quick = YES;
            [weakSelf.navigationController hh_pushErectViewController:keep];
        };
    }
    return _naviView;
}
- (BaseCollectionView *)collectionview {
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(30);
        flowLayout.minimumInteritemSpacing = kIphone6Width(30);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(kIphone6Width(60), kIphone6Width(60));
        _collectionview = [[BaseCollectionView alloc] initWithFrame:CGRectMake(kIphone6Width(20),kNavigationHeight+kIphone6Width(20),ScreenWidth - kIphone6Width(40),ScreenHeight - kNavigationHeight - kIphone6Width(30) - kTabBarSpace) collectionViewLayout:flowLayout];
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled = YES;
        _collectionview.bounces = NO;
        _collectionview.btnTitle = @"点击添加快速记账模块";
        _collectionview.baseDelegate = self;
        _collectionview.backgroundColor = [UIColor whiteColor];
        [_collectionview registerClass:[ToolCollectionViewCell class] forCellWithReuseIdentifier:@"ToolCollectionViewCell"];
    }
    return _collectionview;
}
-(void)baseCollectionViewButtonClick{
    //创建速记
    KeepAccountViewController * keep = [[KeepAccountViewController alloc] init];
    keep.quick = YES;
    [self.navigationController hh_pushErectViewController:keep];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ToolCollectionViewCell alloc] init];
    }
    cell.layer.cornerRadius = kIphone6Width(10);
    cell.layer.masksToBounds = YES;
    cell.model = self.dataSource[indexPath.row];
    cell.layer.borderColor = kBlackColor.CGColor; //self.dataSource[indexPath.row].moneyType == 0 ? kBlackColor.CGColor : kHexRGB(0xf15b6c).CGColor;
    cell.layer.borderWidth = kIphone6Width(2);
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
    longPressGR.minimumPressDuration = 1;
    [cell addGestureRecognizer:longPressGR];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VIBRATION;
    NSDate * date = [NSDate new];
    PBWatherModel * waterModel = [[PBWatherModel alloc] init];
    waterModel.price = self.dataSource[indexPath.row].price;
    waterModel.week = [date weekday];
    waterModel.year = [date year];
    waterModel.month = [date month];
    waterModel.day = [date day];
    waterModel.weekNum = [date weekOfYear];
    waterModel.mark = @"速记";
    waterModel.type = self.dataSource[indexPath.row].type;
    waterModel.moneyType = self.dataSource[indexPath.row].moneyType;
    //WS(weakSelf);
    [PBWatherExtension inserDataForModel:waterModel success:^(id  _Nonnull responseObject) {
        [ToastManage showTopToastWith:@"速记成功"];
    }];
}
-(void)queryQuickList{
    WS(weakSelf);
    [PBQuickExtension queryBookListsuccess:^(NSMutableArray<PBQuickModel *> * _Nonnull bookList) {
        weakSelf.dataSource = bookList;
        [weakSelf.collectionview reloadData];
    } fail:^(id _Nonnull error) {
    }];
}
-(void)lpGR:(UILongPressGestureRecognizer *)lpGR
{
    if (lpGR.state == UIGestureRecognizerStateBegan) {//手势开始
        CGPoint point = [lpGR locationInView:self.collectionview];
        VIBRATION;
        self.longPressIndexPath = [self.collectionview indexPathForItemAtPoint:point];// 可以获取我们在哪个cell上长按
        [self delegateModel:self.dataSource[self.longPressIndexPath.row]];
        
    }
}
-(void)delegateModel:(PBQuickModel *)model{
    WS(weakSelf);
    [LEEAlert alert].config
    .LeeAddTitle(^(UILabel *label) {
        label.text = @"确认删除?";
        label.textColor = kBlackColor;
    })
    .LeeAddContent(^(UILabel *label) {
        label.text = @"删除后将无法恢复, 请慎重考虑";
        label.textColor = [kBlackColor colorWithAlphaComponent:0.75f];
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeCancel;
        action.title = @"取消删除";
        action.titleColor = kColor_Main_Color;
        action.backgroundColor = kBlackColor;
        action.clickBlock = ^{
        };
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeDefault;
        action.title = @"删除";
        action.titleColor = kColor_Main_Color;
        action.backgroundColor = kBlackColor;
        action.clickBlock = ^{
            [PBQuickExtension delegateDataForModel:model success:^(id  _Nonnull responseObject) {
                [weakSelf queryQuickList];
            }];
        };
    })
    .LeeHeaderColor(kColor_Main_Color)
    .LeeShow();
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
