//
//  ScreeningViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/7/2.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ScreeningViewController.h"
#import "ScreeningHeadView.h"
#import "ScreeningClassView.h"
#import "ScreeningClassSubView.h"
@interface ScreeningViewController ()

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;
@property(nonatomic,strong)ScreeningHeadView * headView;

@property(nonatomic,strong)ScreeningClassSubView * classView;

@property(nonatomic,assign)NSInteger  moneyType;
@end

@implementation ScreeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.classView];
    self.moneyType = 0;
    [self addMasonry];
    // Do any additional setup after loading the view.
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationHeight);
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.naviView.mas_bottom);
        make.height.mas_equalTo(kIphone6Width(180));
    }];
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headView.mas_bottom).offset(kIphone6Width(10));
        make.bottom.mas_equalTo(0);
    }];
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.title = @"日常流水筛选->支出·";
        _naviView.titleFont = kFont16;
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightHidden = YES;
        _naviView.isShadow = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
        };
        __weak PBIndexNavigationBarView * newNavi = _naviView;
        _naviView.PBIndexNavigationBarViewTitleLabelBlock = ^{
            VIBRATION;
            [LEEAlert actionsheet].config
            .LeeTitle(@"选择")
            .LeeContent(@"选择支出、收入")
            .LeeAction(@"支出", ^{
                weakSelf.headView.titles = TypeClassStr;
                weakSelf.moneyType = 0;
                newNavi.title  = @"日常流水筛选 -> 支出·";
            })
            .LeeAction(@"收入", ^{
                weakSelf.moneyType = 1;
                weakSelf.headView.titles = IncomeClassStr;
                newNavi.title  = @"日常流水筛选 -> 收入·";
            })
            .LeeCancelAction(@"取消", nil)
            .LeeBackgroundStyleBlur(UIBlurEffectStyleLight)
            .LeeShow();
        };
    }
    return _naviView;
}
-(ScreeningHeadView *)headView
{
    if (!_headView) {
        _headView = [[ScreeningHeadView alloc] init];
        _headView.titles = TypeClassStr;
        WS(weakSelf);
        _headView.screeningHeadViewCollectionViewCellBtnSelectBlock = ^(NSInteger type) {
            [weakSelf.classView queryScreeningListForType:type andMoneyType:weakSelf.moneyType];
        };
    }
    return _headView;
}
-(ScreeningClassSubView *)classView{
    if (!_classView) {
        _classView = [[ScreeningClassSubView alloc] init];
    }
    return _classView;
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
