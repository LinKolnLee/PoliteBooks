//
//  TroopsViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/7/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "TroopsViewController.h"
#import "TroopsCollectionViewCell.h"
@interface TroopsViewController ()<UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;
@property(nonatomic,strong)SPMultipleSwitch * classTypeSwitch;

@property(nonatomic,strong)UICollectionView * baseCollectionview;

@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * dataSource;
@property(nonatomic,strong)NSMutableArray * monthDataSource;
@end

@implementation TroopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.classTypeSwitch];
    [self.view addSubview:self.baseCollectionview];
    self.dataSource = [[NSMutableArray alloc] init];
    self.monthDataSource = [[NSMutableArray alloc] init];
    [self queryUserDataSourceWithObjectId:kMemberInfoManager.objectId];
    // Do any additional setup after loading the view.
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kNavigationHeight)];
        _naviView.title = @"组队记账";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"relieve";
        _naviView.titleFont = kMBFont18;
        _naviView.isShadow = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            //右按钮点击
            [LEEAlert alert].config
            .LeeAddTitle(^(UILabel *label) {
                label.text = @"解散队伍?";
                label.textColor = kBlackColor;
            })
            .LeeAddContent(^(UILabel *label) {
                label.text = @"解散后将无法查看队伍支出明细";
                label.textColor = [kBlackColor colorWithAlphaComponent:0.75f];
            })
            .LeeAddAction(^(LEEAction *action) {
                action.type = LEEActionTypeCancel;
                action.title = @"取消解散";
                action.titleColor = kColor_Main_Color;
                action.backgroundColor = kBlackColor;
                action.clickBlock = ^{
                };
            })
            .LeeAddAction(^(LEEAction *action) {
                action.type = LEEActionTypeDefault;
                action.title = @"解散";
                action.titleColor = kColor_Main_Color;
                action.backgroundColor = kBlackColor;
                action.clickBlock = ^{
                    [weakSelf relieveTroops];
                };
            })
            .LeeHeaderColor(kColor_Main_Color)
            .LeeShow();
        };
    }
    return _naviView;
}
-(SPMultipleSwitch *)classTypeSwitch{
    if (!_classTypeSwitch) {
        _classTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"主",@"从"]];
        _classTypeSwitch.frame = CGRectMake(kIphone6Width(10),kNavigationHeight + kIphone6Width(10), kIphone6Width(150), kIphone6Width(50));
        _classTypeSwitch.backgroundColor = kWhiteColor;
        _classTypeSwitch.selectedTitleColor = kWhiteColor;
        _classTypeSwitch.titleColor = kHexRGB(0x665757);
        _classTypeSwitch.trackerColor = kBlackColor;
        _classTypeSwitch.contentInset = 5;
        _classTypeSwitch.spacing = 10;
        _classTypeSwitch.titleFont = kFont14;
        [_classTypeSwitch addTarget:self action:@selector(classTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classTypeSwitch;
}
- (UICollectionView *)baseCollectionview {
    if (!_baseCollectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - kNavigationHeight - kIphone6Width(70) - kTabBarSpace);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _baseCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationHeight + kIphone6Width(70) , ScreenWidth, ScreenHeight - kNavigationHeight - kIphone6Width(70) - kTabBarSpace) collectionViewLayout:flowLayout];
        _baseCollectionview.showsVerticalScrollIndicator = NO;
        _baseCollectionview.showsHorizontalScrollIndicator = NO;
        _baseCollectionview.scrollEnabled = NO;
        _baseCollectionview.delegate = self;
        _baseCollectionview.dataSource = self;
        _baseCollectionview.pagingEnabled = YES;
        _baseCollectionview.bounces = YES;
        _baseCollectionview.backgroundColor = kWhiteColor;
        [_baseCollectionview registerClass:[TroopsCollectionViewCell class] forCellWithReuseIdentifier:@"TroopsCollectionViewCell"];
    }
    return _baseCollectionview;
}
-(void)classTypeSwitchAction:(SPMultipleSwitch *)swit{
    [self.baseCollectionview setContentOffset:CGPointMake(swit.selectedSegmentIndex * ScreenWidth, 0)];
    [self.dataSource removeAllObjects];
    [self.monthDataSource removeAllObjects];
    if (swit.selectedSegmentIndex) {
        [self queryUserDataSourceWithObjectId:self.troopsId];
    }else{
        [self queryUserDataSourceWithObjectId:kMemberInfoManager.objectId];
    }
}
#pragma mark delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TroopsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TroopsCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[TroopsCollectionViewCell alloc] init];
    }
    cell.contentView.backgroundColor = TypeColor[indexPath.row];
    //if (self.dataSource.count != 0) {
        cell.dataSource = self.dataSource;
   // }
    //if (self.monthDataSource.count != 0) {
        cell.monthDataSource = self.monthDataSource;
    //}
    return cell;
}
-(void)queryTroopsDayDataSourceWithType:(NSInteger)type andObjectId:(NSString *)objectId{
    WS(weakSelf);
    [PBTroopsEctension queryDayBookListWithDate:[NSDate new] userObjectId:objectId withType:type success:^(NSMutableArray<PBWatherModel *> * _Nonnull bookList) {
        weakSelf.dataSource = bookList;
        [weakSelf.baseCollectionview reloadData];
    } fail:^(id _Nonnull error) {
    }];
}
-(void)queryTroopsMonthDataSourceWithType:(NSInteger)type andObjectId:(NSString *)objectId{
    WS(weakSelf);
    [PBTroopsEctension queryMonthBookListWithDate:[NSDate new] withType:type userObjectId:objectId  success:^(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull bookList) {
        for (NSMutableArray * arr in bookList) {
            CGFloat monthPrice = 0.0;
            NSString * monthkNumber = @"";
            for (PBWatherModel * model in arr) {
                monthPrice += [model.price doubleValue];
                monthkNumber = [NSString stringWithFormat:@"%ld日",(long)model.day];
            }
            [weakSelf.monthDataSource addObject:@[monthkNumber,@(monthPrice)]];
        }
        [weakSelf.baseCollectionview reloadData];
    } fail:^(id _Nonnull error) {
    }];
}
-(void)queryUserDataSourceWithObjectId:(NSString *)object{
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    WS(weakSelf);
    dispatch_barrier_sync(concurrentQueue, ^{
        [weakSelf queryTroopsDayDataSourceWithType:0 andObjectId:object];
    });
    dispatch_barrier_sync(concurrentQueue, ^{
        [weakSelf queryTroopsMonthDataSourceWithType:0 andObjectId:object];
    });
}
-(void)relieveTroops{
    [[BmobUser currentUser] setObject:nil forKey:@"troopsid"];
    [[BmobUser currentUser] updateInBackground];
    WS(weakSelf);
    [PBTroopsEctension relieveTroopsWithId:kMemberInfoManager.objectId success:^(NSString * _Nonnull newId) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [ToastManage showTopToastWith:@"队伍解散成功"];
    } fail:^(id _Nonnull error) {
    }];
}
-(void)setTroopsId:(NSString *)troopsId{
    _troopsId = troopsId;
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
