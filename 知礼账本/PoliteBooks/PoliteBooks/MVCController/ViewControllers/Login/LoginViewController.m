//
//  LoginViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/13.
//  Copyright © 2019 Beauty. All rights reserved.
//
static  NSInteger timeNum;

#import "LoginViewController.h"
#import "WKWebViewController.h"
#import "UILabel+LCLabelCategory.h"
#import "UITextField+Extension.h"
#import "FCUUID.h"
@interface LoginViewController ()<UITextFieldDelegate>

/// 手机号
@property (nonatomic, strong) UITextField *phoneTextField;

/// 验证码
@property (nonatomic, strong) UITextField *codeTextField;

/// 确定绑定
@property (nonatomic, strong) UIButton *sureBindButton;

/// 取消绑定
@property (nonatomic, strong) UIButton *cancelBindButton;

/// 获取验证码
@property (nonatomic, strong) UIButton *getAuthCodeBtn;

/// 倒计时定时器
@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)UILabel * subTitleLabel;

@property(nonatomic,strong)NSString * codeNumber;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.codeTextField];
    [self.codeTextField addSubview:self.getAuthCodeBtn];
    [self.view addSubview:self.subTitleLabel];
    [self.view addSubview:self.sureBindButton];
    [self.view addSubview:self.cancelBindButton];
    timeNum = 30;
    self.codeNumber = 0;
    [self addMasonry];
    [self setupSubView];
    // Do any additional setup after loading the view.
}
-(void)setupSubView{
    WS(weakSelf);
    [self.subTitleLabel setLc_tapBlock:^(NSInteger index, NSAttributedString *charAttributedString) {
        if (index>7 && index<12) {
            DLog(@"注册协议");
            WKWebViewController *webVC = [[WKWebViewController alloc] init];
            webVC.titleStr  = @"注册协议";
            webVC.urlStr = [[[NSBundle mainBundle] URLForResource:@"RegistrationAgreement.html" withExtension:nil] absoluteString];
            [weakSelf.navigationController pushViewController:webVC  animated:NO];
        }else if (index > 12){
            DLog(@"隐私政策");
            WKWebViewController *webVC = [[WKWebViewController alloc] init];
            webVC.titleStr  = @"隐私政策";
            webVC.urlStr = [[[NSBundle mainBundle] URLForResource:@"PrivacyAgreement.html" withExtension:nil] absoluteString];
            [weakSelf.navigationController pushViewController:webVC  animated:NO];
        }else{
            return;
        };
        
    }];
}
#pragma mark - # Private Methods
- (void)addMasonry {
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(84);
    }];
    // 手机号
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(26));
        make.right.mas_equalTo(kIphone6Width(-26));
        make.height.mas_equalTo(kIphone6Width(44));
        make.top.mas_equalTo(kIphone6Width(80)+84);
    }];
    // 验证码
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTextField);
        make.right.mas_equalTo(self.phoneTextField);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).mas_offset(kIphone6Width(20));
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTextField.mas_bottom).mas_offset(kIphone6Width(50));
        make.width.mas_equalTo(kIphone6Width(260));
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
    }];
    // 确定绑定
    [self.sureBindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTextField.mas_bottom).mas_offset(kIphone6Width(150));
        make.width.mas_equalTo(kIphone6Width(260));
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
    }];
    // 手机号
    
    [self.getAuthCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.codeTextField);
        make.height.mas_equalTo(self.codeTextField);
        make.centerY.mas_equalTo(self.codeTextField);
    }];
    [self.cancelBindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sureBindButton.mas_bottom).mas_offset(kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(260));
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
    }];
    
}

#pragma mark - # Getter
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kNavigationHeight)];
        _naviView.backgroundColor = kWhiteColor;
        _naviView.title = @"用户登录";
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
- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        [_phoneTextField setDelegate:self];
        [_phoneTextField setPlaceholder:@"请输入手机号"];
        _phoneTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.font = kPingFangSC_Regular(14);
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kIphone6Width(39), ScreenWidth - kIphone6Width(52), 1)];
        lineView.backgroundColor = kHexRGB(0XF5F5F5);;
        [_phoneTextField addSubview:lineView];
    }
    return _phoneTextField;
}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] init];
        [_codeTextField setDelegate:self];
        [_codeTextField setPlaceholder:@"请输入验证码"];
        _codeTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        _codeTextField.font = kPingFangSC_Regular(14);
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kIphone6Width(39), ScreenWidth - kIphone6Width(52), 1)];
        lineView.backgroundColor = kHexRGB(0XF5F5F5);
        [_codeTextField addSubview:lineView];
    }
    return _codeTextField;
}

- (UIButton *)sureBindButton {
    if (!_sureBindButton) {
        _sureBindButton = [[UIButton alloc] init];
        [_sureBindButton addTarget:self action:@selector(sureBindButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        _sureBindButton.titleLabel.font = kFont18;
        [_sureBindButton setBackgroundColor:kHexRGB(0x3d3b4f)];
        _sureBindButton.layer.cornerRadius = kIphone6Width(25);
        _sureBindButton.layer.shadowColor = kHexRGB(0x3d3b4f).CGColor;
        _sureBindButton.layer.shadowOffset = CGSizeMake(0,6);
        _sureBindButton.layer.shadowOpacity = 1;
        _sureBindButton.layer.shadowRadius = 9;
        _sureBindButton.layer.masksToBounds = NO;
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)kHexRGB(0xff6ca3).CGColor,(__bridge id)kHexRGB(0xff2992).CGColor];
        
        gradientLayer.locations = @[@0.2,@0.8];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = _sureBindButton.bounds;
        [_sureBindButton.layer addSublayer:gradientLayer];
        [_sureBindButton setTitle:@"确认登录" forState:UIControlStateNormal];
    }
    return _sureBindButton;
}
- (UIButton *)cancelBindButton {
    if (!_cancelBindButton) {
        _cancelBindButton = [[UIButton alloc] init];
        [_cancelBindButton setTitle:@"取消登录" forState:UIControlStateNormal];
        _cancelBindButton.titleLabel.font = kFont15;
        [_cancelBindButton setTitleColor:kHexRGB(0x3d3b4f) forState:UIControlStateNormal];
        [_cancelBindButton addTarget:self action:@selector(cancelBindButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBindButton;
}

- (UIButton *)getAuthCodeBtn {
    if (!_getAuthCodeBtn) {
        _getAuthCodeBtn = [[UIButton alloc] init];
        [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getAuthCodeBtn.titleLabel.font = kFont15;
        [_getAuthCodeBtn setTitleColor:kHexRGB(0x3d3b4f) forState:UIControlStateNormal];
        [_getAuthCodeBtn addTarget:self action:@selector(getAuthCodeBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getAuthCodeBtn;
}
-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.textColor = kHexRGB(0X898989);
        _subTitleLabel.font = kPingFangSC_Regular(12);
        NSString * str = @"登录代表你已同意注册协议和隐私政策";
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:str];
        [attributedText addAttribute:NSForegroundColorAttributeName value:kHexRGB(0X4169E1) range:[str rangeOfString:@"注册协议"]];
        [attributedText addAttribute:NSForegroundColorAttributeName value:kHexRGB(0X4169E1) range:[str rangeOfString:@"隐私政策"]];
        _subTitleLabel.attributedText = attributedText;
    }
    return _subTitleLabel;
}
-(void)getAuthCodeBtnTouchUpInside:(UIButton *)sender{
    BOOL isSafe = [self.phoneTextField isAvailablePhone];
    if (isSafe == NO) {
        [ToastManage showTopToastWith:@"请输入正确的手机号"];
        return;
    }
    sender.enabled = NO;
    if ([sender.titleLabel.text isEqualToString:@"重新获取验证码"]) {
        timeNum  = 30;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setupTimer) userInfo:nil repeats:YES];
    [self setupTimer];
    //发送验证码
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.phoneTextField.text andTemplate:@"知礼账本" resultBlock:^(int number, NSError *error) {
        if (error) {
            [ToastManage showTopToastWith:@"短信发送失败"];
        }else{
            [ToastManage showTopToastWith:@"短信发送成功"];
        }
    }];
}
- (void)setupTimer{
    if (timeNum == 0) {
        self.getAuthCodeBtn.enabled = YES;
        [_timer invalidate];
        _timer = nil;
        [self.getAuthCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.getAuthCodeBtn setTitleColor:kHexRGB(0x3d3d4f) forState:UIControlStateNormal];
    }else{
        timeNum--;
        self.getAuthCodeBtn.enabled = NO;
        [self.getAuthCodeBtn setTitle:[NSString stringWithFormat:@"%lds",(long)timeNum] forState:UIControlStateNormal];
        [self.getAuthCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}
-(void)cancelBindButtonTouchUpInside:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sureBindButtonTouchUpInside:(UIButton *)sender{
    [BmobUser logout];
    kMemberInfoManager.objectId = 0;
    self.codeNumber = self.codeTextField.text;
    if (self.codeNumber.length != 6 ) {
        [ToastManage showTopToastWith:@"请输入正确的验证码"];
    }else{
        [self loginWithPhoneNumber:self.phoneTextField.text code:self.codeNumber];
    }
}
-(void)loginWithPhoneNumber:(NSString *)phone code:(NSString *)code{
    //验证
    WS(weakSelf);
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:phone andSMSCode:code resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            BmobQuery *query = [BmobUser query];
            [query whereKey:@"mobilePhoneNumber" equalTo:phone];
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count !=0) {
                    [weakSelf userLoginWithPhone:phone andCode:code];
                }else{
                    [weakSelf newUserLoginWithPhoneNumber:phone];
                }
            }];
            
        } else {
            [ToastManage showTopToastWith:@"验证码不正确"];
        }
    }];
}
//
-(void)userLoginWithPhone:(NSString *)phone andCode:(NSString *)code{
    [self showLoadingAnimation];
    WS(weakSelf);
    [BmobUser loginInbackgroundWithAccount:phone andPassword:@"zhiliBook" block:^(BmobUser *user, NSError *error) {
        [weakSelf hiddenLoadingAnimation];
        if (error) {
            [ToastManage showTopToastWith:@"用户登录失败"];
        }else{
            [ToastManage showTopToastWith:@"用户登录成功"];
            kMemberInfoManager.objectId = user.objectId;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
-(void)newUserLoginWithPhoneNumber:(NSString *)phone{
    [self showLoadingAnimation];
    BmobUser *buser = [[BmobUser alloc] init];;
    buser.mobilePhoneNumber = phone;
    [buser setObject:[NSNumber numberWithBool:YES] forKey:@"mobilePhoneNumberVerified"];
    NSString *strName = [FCUUID uuid];
    NSString *nickName = [UserManager getNameString];
    [buser setUsername:strName];
    [buser setPassword:@"zhiliBook"];
    WS(weakSelf);
    [buser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        [weakSelf hiddenLoadingAnimation];
        if (isSuccessful){
            [buser setObject:nickName forKey:@"nickName"];
            [buser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                [ToastManage showTopToastWith:@"用户注册登录成功"];
                BmobUser *newUser = [BmobUser currentUser];
                [UserManager sharedInstance].user_id = newUser.objectId;
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            NSLog(@"%@",error);
        }
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
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
