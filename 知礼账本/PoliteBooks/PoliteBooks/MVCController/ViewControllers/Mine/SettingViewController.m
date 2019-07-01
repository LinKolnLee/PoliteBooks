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
#import "FeedbackViewController.h"
#import "ExportExcellViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"
@interface SettingViewController ()



/*@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)UILabel * outBookLabel;

@property(nonatomic,strong)UIButton * exportButton;

@property(nonatomic,strong)UIButton * searchButton;

@property(nonatomic,strong)UIButton * feedbackButton;

@property(nonatomic,strong)UIButton * registerButton;

@property(nonatomic,strong)UIButton * priveButton;

@property(nonatomic,strong)UIButton * aboutBtn;

@property(nonatomic,strong)UIButton * loginOutBtn;*/
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.outBookLabel];
    [self.view addSubview:self.exportButton];
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.feedbackButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.priveButton];
    [self.view addSubview:self.aboutBtn];
    [self.view addSubview:self.loginOutBtn];*/
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /*
    if (![BmobUser currentUser].mobilePhoneNumber) {
        [self.loginOutBtn setTitle:@"登录" forState:UIControlStateNormal];
    }else{
        [self.loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }
     */
}
/*
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 74)];
        _naviView.title = @"应用信息";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"BookChars";
        _naviView.rightHidden = YES;
        _naviView.titleFont = kFont16;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _naviView;
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
-(UIButton *)exportButton{
    if (!_exportButton) {
        _exportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exportButton.frame = CGRectMake(0, 200, ScreenWidth, 25);
        [_exportButton setTitle:@"导出EXCEL" forState:UIControlStateNormal];
        [_exportButton setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _exportButton.titleLabel.font = kPingFangTC_Light(15);
        [_exportButton addTarget:self action:@selector(exportButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exportButton;
}
-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(0, 250, ScreenWidth, 25);
        [_searchButton setTitle:@"账本搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _searchButton.titleLabel.font = kPingFangTC_Light(15);
        [_searchButton addTarget:self action:@selector(searchButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
-(UIButton *)feedbackButton{
    if (!_feedbackButton) {
        _feedbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _feedbackButton.frame = CGRectMake(0, 300, ScreenWidth, 25);
        [_feedbackButton setTitle:@"意见反馈" forState:UIControlStateNormal];
        [_feedbackButton setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _feedbackButton.titleLabel.font = kPingFangTC_Light(15);
        [_feedbackButton addTarget:self action:@selector(feedbackButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedbackButton;
}
-(UIButton *)registerButton{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.frame = CGRectMake(0, 350, ScreenWidth, 25);
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
        _priveButton.frame = CGRectMake(0, 400, ScreenWidth, 25);
        [_priveButton setTitle:@"隐私政策" forState:UIControlStateNormal];
        [_priveButton setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _priveButton.titleLabel.font = kPingFangTC_Light(15);
        [_priveButton addTarget:self action:@selector(priveButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priveButton;
}
-(UIButton *)aboutBtn{
    if (!_aboutBtn) {
        _aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _aboutBtn.frame = CGRectMake(0, 450, ScreenWidth, 25);
        [_aboutBtn setTitle:@"关于虾米" forState:UIControlStateNormal];
        [_aboutBtn setTitleColor:TypeColor[6] forState:UIControlStateNormal];
        _aboutBtn.titleLabel.font = kPingFangTC_Light(15);
        [_aboutBtn addTarget:self action:@selector(aboutBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aboutBtn;
}
-(UIButton *)loginOutBtn{
    if (!_loginOutBtn) {
        _loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginOutBtn.frame = CGRectMake((ScreenWidth - 150)/2, 500, kIphone6Width(150), kIphone6Width(35));
        if (![BmobUser currentUser].mobilePhoneNumber) {
            [_loginOutBtn setTitle:@"登录" forState:UIControlStateNormal];
        }else{
            [_loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        }
        [_loginOutBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _loginOutBtn.backgroundColor = kHexRGB(0x3d3d4f);
        _loginOutBtn.layer.cornerRadius = kIphone6Width(17.5);
        _loginOutBtn.layer.masksToBounds = YES;
        _loginOutBtn.titleLabel.font = kPingFangTC_Light(15);
        [_loginOutBtn addTarget:self action:@selector(loginOutBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginOutBtn;
}
-(void)outBookLabelTouchUpInside:(UIButton *)sender{
    DateViewController * date = [[DateViewController alloc] init];
    [self.navigationController hh_presentBackScaleVC:date height:ScreenHeight-kIphone6Width(230) completion:nil];
}

-(void)setDataSource:(NSMutableArray<PBBookModel *> *)dataSource{
    _dataSource = dataSource;
}
-(void)loginOutBtnTouchUpInside:(UIButton *)sender{
    if (![BmobUser currentUser].mobilePhoneNumber) {
        LoginViewController * login = [[LoginViewController alloc] init];
        [self.navigationController hh_pushErectViewController:login];
    }else{
        [BmobUser logout];
        kMemberInfoManager.objectId = 0;
        WS(weakSelf);
        [UserManager showUserLoginView];
        [ToastManage showTopToastWith:@"账户已退出登录"];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }
    
}
-(void)searchButtonTouchUpInside:(UIButton *)search{
    SearchViewController * searchVc = [[SearchViewController alloc] init];
    [self.navigationController hh_pushBackViewController:searchVc];
}
-(void)feedbackButtonTouchUpInside:(UIButton *)sender{
    FeedbackViewController * feedBack = [[FeedbackViewController alloc] init];
    [self.navigationController hh_pushBackViewController:feedBack];
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
-(void)exportButtonTouchUpInside:(UIButton *)sender{
    ExportExcellViewController * export = [[ExportExcellViewController alloc] init];
    [self.navigationController hh_pushBackViewController:export];
}
-(void)aboutBtnTouchUpInside:(UIButton *)sender{
    AboutViewController * about = [[AboutViewController alloc] init];
    about.dataSource = self.dataSource;
    [self.navigationController hh_pushBackViewController:about];
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
