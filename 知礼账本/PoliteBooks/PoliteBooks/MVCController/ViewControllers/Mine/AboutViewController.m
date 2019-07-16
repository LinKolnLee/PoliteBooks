//
//  AboutViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/20.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "AboutViewController.h"
#import "BaseCollectionView.h"
#import "WJFlowLayout.h"
#import "AboutCollectionViewCell.h"

@interface AboutViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;
@property (nonatomic, strong) BaseCollectionView *collectionView;

@property(nonatomic,strong)UILabel * versionLabel;

@property(nonatomic,strong)UILabel * bookNumberLabel;

@property(nonatomic,strong)UILabel * contactLabel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.versionLabel];
    //[self.view addSubview:self.bookNumberLabel];
    [self.view addSubview:self.contactLabel];

    [self addMasonry];
    // Do any additional setup after loading the view.
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
        _naviView.title = @"关于虾米";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"export";
        _naviView.rightHidden = YES;
        _naviView.titleFont = kMBFont18;
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

- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        WJFlowLayout *layout = [[WJFlowLayout alloc]init];

        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(kIphone6Width(10), kIphone6Width(120) , ScreenWidth-kIphone6Width(20), ScreenWidth/4*3) collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[AboutCollectionViewCell class] forCellWithReuseIdentifier:@"AboutCollectionViewCell"];
    }
    return _collectionView;
}
-(UILabel *)bookNumberLabel{
    if (!_bookNumberLabel) {
        _bookNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-150, ScreenWidth, 25)];
        _bookNumberLabel.font = kPingFangTC_Light(15);
        _bookNumberLabel.textColor = TypeColor[1];
        _bookNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bookNumberLabel;
}
-(UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-100, ScreenWidth, 25)];
        _versionLabel.font = kPingFangTC_Light(15);
        _versionLabel.text = [NSString stringWithFormat:@"当前版本：虾米账本%@",kCurrentAppVersion];
        _versionLabel.textColor = kBlackColor;
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}
-(UILabel *)contactLabel{
    if (!_contactLabel) {
        _contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 25)];
        _contactLabel.font = kPingFangTC_Light(15);
        _contactLabel.text = @"联系方式：zhilibook@163.com";
        _contactLabel.textColor = kBlackColor;
        _contactLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contactLabel;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AboutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AboutCollectionViewCell" forIndexPath:indexPath];
    cell.layer.shadowColor = kHexRGB(0x75664d).CGColor;
    cell.layer.shadowOffset = CGSizeMake(2, 4);
    cell.layer.shadowOpacity = 0.5;
    if (!cell) {
        cell = [[AboutCollectionViewCell alloc] init];
    }
    cell.imageName = @"newAbout";
    return cell;
}
-(void)setDataSource:(NSMutableArray<PBBookModel *> *)dataSource{
    _dataSource = dataSource;
    self.bookNumberLabel.text = [NSString stringWithFormat:@"当前账本个数：%ld",dataSource.count];
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
