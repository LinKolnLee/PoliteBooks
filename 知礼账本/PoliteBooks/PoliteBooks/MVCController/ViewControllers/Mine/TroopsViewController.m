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
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_barrier_sync(concurrentQueue, ^{
        [self queryTroopsDayDataSourceWithType:0];
    });
    dispatch_barrier_sync(concurrentQueue, ^{
         [self queryTroopsMonthDataSourceWithType:0];
    });
    // Do any additional setup after loading the view.
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kNavigationHeight)];
        _naviView.title = @"组队记账";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"export";
        _naviView.rightHidden = YES;
        _naviView.titleFont = kFont18;
        _naviView.isShadow = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            //右按钮点击
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
    if (self.dataSource.count != 0) {
        cell.dataSource = self.dataSource;
    }
    if (self.monthDataSource.count != 0) {
        cell.monthDataSource = self.monthDataSource;
    }
    return cell;
}
-(void)queryTroopsDayDataSourceWithType:(NSInteger)type{
    WS(weakSelf);
    [PBTroopsEctension queryDayBookListWithDate:[NSDate new] userObjectId:kMemberInfoManager.objectId withType:type success:^(NSMutableArray<PBWatherModel *> * _Nonnull bookList) {
        weakSelf.dataSource = bookList;
        [weakSelf.baseCollectionview reloadData];
    } fail:^(id _Nonnull error) {
    }];
}
-(void)queryTroopsMonthDataSourceWithType:(NSInteger)type{
    WS(weakSelf);
    [PBTroopsEctension queryMonthBookListWithDate:[NSDate new] withType:type success:^(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull bookList) {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
