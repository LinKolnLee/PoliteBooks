//
//  KeepAccountViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "KeepAccountViewController.h"
#import "SPMultipleSwitch.h"
#import "KeepAccountInOutCollectionViewCell.h"
#import "BKCKeyboard.h"
@interface KeepAccountViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,UIScrollViewDelegate
>
@property(nonatomic,strong)SPMultipleSwitch * classTypeSwitch;

@property(nonatomic,strong)UIButton * cancelButton;

@property(nonatomic,strong)UICollectionView * baseCollectionview;
@property (nonatomic, strong) BKCKeyboard *keyboard;

@property (nonatomic, assign) NSInteger accountType;


@end

@implementation KeepAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.classTypeSwitch];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview: self.baseCollectionview];
    [self keyboard];
    // Do any additional setup after loading the view.
}
- (BKCKeyboard *)keyboard {
    if (!_keyboard) {
        WS(weakSelf);
        _keyboard = [BKCKeyboard init];
        [_keyboard setComplete:^(NSString *price, NSString *mark, NSDate *date) {
            [weakSelf.keyboard hide];
            PBWatherModel * model = [[PBWatherModel alloc] init];
            model.price = [price floatValue];
            model.week = [date weekday];
            model.year = [date year];
            model.month = [date month];
            model.day = [date day];
            model.mark = mark;
            model.type = weakSelf.accountType;
            [PBWatherExtension inserDataForModel:model success:^(id  _Nonnull responseObject) {
                DLog(@"流水账成功");
            }];
        }];
        [self.view addSubview:_keyboard];
    }
    return _keyboard;
}
-(SPMultipleSwitch *)classTypeSwitch{
    if (!_classTypeSwitch) {
        _classTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"支出",@"收入"]];
        _classTypeSwitch.frame = CGRectMake((ScreenWidth - (ScreenWidth-150))/2, kStatusBarHeight + 10, ScreenWidth-150, 40);
        _classTypeSwitch.backgroundColor = kHexRGB(0xe9f1f6);
        _classTypeSwitch.selectedTitleColor = kWhiteColor;
        _classTypeSwitch.titleColor = kHexRGB(0x665757);
        _classTypeSwitch.trackerColor = TypeColor[3];
        _classTypeSwitch.contentInset = 5;
        _classTypeSwitch.spacing = 10;
        _classTypeSwitch.titleFont = kFont14;
        //        _relationTypeSwitch.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        //        _relationTypeSwitch.layer.borderColor = kHexRGB(0x665757).CGColor;
        [_classTypeSwitch addTarget:self action:@selector(classTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classTypeSwitch;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(ScreenWidth - 40, kStatusBarHeight + kIphone6Width(15), kIphone6Width(25), kIphone6Width(25));
        [_cancelButton addTarget:self action:@selector(cancelButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    }
    return _cancelButton;
}
- (UICollectionView *)baseCollectionview {
    if (!_baseCollectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - kNavigationHeight - kIphone6Width(30) - kTabBarSpace);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _baseCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationHeight + kIphone6Width(30) , ScreenWidth, ScreenHeight - kNavigationHeight - kIphone6Width(20) - kTabBarSpace) collectionViewLayout:flowLayout];
        _baseCollectionview.showsVerticalScrollIndicator = NO;
        _baseCollectionview.showsHorizontalScrollIndicator = NO;
        
        _baseCollectionview.delegate = self;
        _baseCollectionview.dataSource = self;
        _baseCollectionview.pagingEnabled = YES;
        _baseCollectionview.bounces = NO;
        _baseCollectionview.backgroundColor = [UIColor whiteColor];
        [_baseCollectionview registerClass:[KeepAccountInOutCollectionViewCell class] forCellWithReuseIdentifier:@"KeepAccountInOutCollectionViewCell"];
    }
    return _baseCollectionview;
}
-(void)classTypeSwitchAction:(SPMultipleSwitch *)switc{
    
}
-(void)cancelButtonTouchUpInside:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KeepAccountInOutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeepAccountInOutCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[KeepAccountInOutCollectionViewCell alloc] init];
    }
    WS(weakSelf);
    cell.keepAccountInOutCollectionViewCellBtnSelectBlock = ^(NSInteger type) {
        weakSelf.accountType = type;
        [weakSelf.keyboard show];
    };
    
    cell.row = indexPath.row;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.classTypeSwitch.selectedSegmentIndex = (NSInteger)(scrollView.contentOffset.x / ScreenWidth);
}
@end
