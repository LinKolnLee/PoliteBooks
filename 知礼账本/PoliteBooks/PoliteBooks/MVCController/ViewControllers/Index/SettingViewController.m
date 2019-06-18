//
//  SettingViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/4/17.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "SettingViewController.h"
#import <Social/Social.h>
#import "GuideViewController.h"
#import "DateViewController.h"
#import "SearchViewController.h"
#import "WKWebViewController.h"
@interface SettingViewController ()

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)UILabel * contactLabel;

@property(nonatomic,strong)UILabel * versionLabel;

@property(nonatomic,strong)UILabel * bookNumberLabel;

@property(nonatomic,strong)UILabel * outBookLabel;

@property(nonatomic,strong)UIButton * loginOutBtn;

@property(nonatomic,strong)UIButton * searchButton;

@property(nonatomic,strong)UIButton * registerButton;

@property(nonatomic,strong)UIButton * priveButton;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.contactLabel];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.bookNumberLabel];
    [self.view addSubview:self.outBookLabel];
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.priveButton];
    [self.view addSubview:self.loginOutBtn];
    
    // Do any additional setup after loading the view.
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kNavigationHeight)];
        _naviView.backgroundColor = kWhiteColor;
        _naviView.title = @"应用信息";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"BookChars";
        _naviView.rightHidden = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _naviView;
}
-(UILabel *)bookNumberLabel{
    if (!_bookNumberLabel) {
        _bookNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-150, ScreenWidth, 25)];
        _bookNumberLabel.font = kPingFangTC_Light(15);
        _bookNumberLabel.textColor = TypeColor[5];
        _bookNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bookNumberLabel;
}
-(UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-100, ScreenWidth, 25)];
        _versionLabel.font = kPingFangTC_Light(15);
        _versionLabel.text = [NSString stringWithFormat:@"当前版本：知礼账簿%@",kCurrentAppVersion];
        _versionLabel.textColor = TypeColor[5];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}
-(UILabel *)contactLabel{
    if (!_contactLabel) {
        _contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 25)];
        _contactLabel.font = kPingFangTC_Light(15);
        _contactLabel.text = @"联系方式：zhilibook@163.com";
        _contactLabel.textColor = TypeColor[5];
        _contactLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contactLabel;
}
-(UILabel *)outBookLabel{
    if (!_outBookLabel) {
        _outBookLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, 25)];
        _outBookLabel.font = kPingFangTC_Light(15);
        _outBookLabel.text = @"查看日历";
        _outBookLabel.textColor = TypeColor[6];
        _outBookLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outBookLabelTouchUpInside:)];
        [_outBookLabel addGestureRecognizer:tap];
        _outBookLabel.userInteractionEnabled = YES;
    }
    return _outBookLabel;
}

-(UIButton *)loginOutBtn{
    if (!_loginOutBtn) {
        _loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginOutBtn.frame = CGRectMake(0, 350, ScreenWidth, 25);
        [_loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_loginOutBtn setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _loginOutBtn.titleLabel.font = kPingFangTC_Light(15);
        if (![BmobUser currentUser].mobilePhoneNumber) {
            _loginOutBtn.hidden = YES;
        }
        [_loginOutBtn addTarget:self action:@selector(loginOutBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginOutBtn;
}
-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(0, 200, ScreenWidth, 25);
        [_searchButton setTitle:@"账簿搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _searchButton.titleLabel.font = kPingFangTC_Light(15);
        [_searchButton addTarget:self action:@selector(searchButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
-(UIButton *)registerButton{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.frame = CGRectMake(0, 250, ScreenWidth, 25);
        [_registerButton setTitle:@"注册协议" forState:UIControlStateNormal];
        [_registerButton setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = kPingFangTC_Light(15);
        [_registerButton addTarget:self action:@selector(registerButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
-(UIButton *)priveButton{
    if (!_priveButton) {
        _priveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _priveButton.frame = CGRectMake(0, 300, ScreenWidth, 25);
        [_priveButton setTitle:@"隐私政策" forState:UIControlStateNormal];
        [_priveButton setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _priveButton.titleLabel.font = kPingFangTC_Light(15);
        [_priveButton addTarget:self action:@selector(priveButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priveButton;
}
-(void)outBookLabelTouchUpInside:(UIButton *)sender{
    DateViewController * date = [[DateViewController alloc] init];
    [self.navigationController hh_presentBackScaleVC:date height:ScreenHeight-kIphone6Width(230) completion:nil];
}

-(void)setDataSource:(NSMutableArray<PBBookModel *> *)dataSource{
    _dataSource = dataSource;
    self.bookNumberLabel.text = [NSString stringWithFormat:@"当前账簿个数：%ld",dataSource.count];
}
-(void)loginOutBtnTouchUpInside:(UIButton *)sender{
    [BmobUser logout];
    kMemberInfoManager.objectId = 0;
    WS(weakSelf);
    [UserManager showUserLoginView];
    [ToastManage showTopToastWith:@"账户已退出登录"];
    [weakSelf.navigationController popViewControllerAnimated:YES];
}
-(void)searchButtonTouchUpInside:(UIButton *)search{
    SearchViewController * searchVc = [[SearchViewController alloc] init];
    [self.navigationController hh_pushBackViewController:searchVc];
}
-(void)registerButtonTouchUpInside:(UIButton *)sender{
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    webVC.titleStr  = @"注册协议";
    webVC.urlStr = [[[NSBundle mainBundle] URLForResource:@"RegistrationAgreement.html" withExtension:nil] absoluteString];
    [self.navigationController pushViewController:webVC  animated:NO];
}
-(void)priveButtonTouchUpInside:(UIButton *)sender{
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    webVC.titleStr  = @"隐私政策";
    webVC.urlStr = [[[NSBundle mainBundle] URLForResource:@"PrivacyAgreement.html" withExtension:nil] absoluteString];
    [self.navigationController pushViewController:webVC  animated:NO];
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
