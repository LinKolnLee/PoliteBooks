//
//  FeedbackViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/19.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<
UITextViewDelegate
>
/**
 navi
 */
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;
@property (nonatomic, strong) UITextView *feedbackTextView;
/// 字数
@property(nonatomic,strong)UILabel * wordNumberLabel;

@property(nonatomic,strong)NSString * feedbackStr;

@property(nonatomic,strong)UIButton * makeSureButton;

@property(nonatomic,strong)UILabel * tipLabel;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.feedbackTextView];
    [self.view addSubview:self.wordNumberLabel];
    [self.view addSubview:self.makeSureButton];
    [self.view addSubview:self.tipLabel];
    [self addMasonry];
    // Do any additional setup after loading the view.
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.titleFont = kFont18;
        _naviView.title = @"意见反馈";
        _naviView.leftImage = @"NavigationBack";
        _naviView.isShadow = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _naviView;
}
- (UITextView *)feedbackTextView {
    if (!_feedbackTextView) {
        _feedbackTextView = [[UITextView alloc] init];
        [_feedbackTextView setDelegate:self];
        [_feedbackTextView setTextColor:[UIColor blackColor]];
        _feedbackTextView.layer.cornerRadius = 5;
        _feedbackTextView.layer.masksToBounds = YES;
        _feedbackTextView.layer.borderColor = kColor_Loding.CGColor;
        _feedbackTextView.layer.borderWidth  = 1;
        _feedbackTextView.font = kPingFangSC_Regular(14);
    }
    return _feedbackTextView;
}
-(UILabel *)wordNumberLabel{
    if (!_wordNumberLabel) {
        _wordNumberLabel = [[UILabel alloc] init];
        _wordNumberLabel.text = @"0/500";
        _wordNumberLabel.font = kPingFangTC_Light(13);
        _wordNumberLabel.textColor = [UIColor blackColor];
        _wordNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _wordNumberLabel;
}
-(UIButton *)makeSureButton{
    if (!_makeSureButton) {
        _makeSureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_makeSureButton setTitle:@"意见反馈" forState:UIControlStateNormal];
        [_makeSureButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _makeSureButton.titleLabel.font = kPingFangTC_Light(15);
        _makeSureButton.backgroundColor = kColor_Loding;
        _makeSureButton.layer.cornerRadius = kIphone6Width(15);
        _makeSureButton.layer.masksToBounds = YES;
        [_makeSureButton addTarget:self action:@selector(makeSureButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makeSureButton;
}
-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"感谢您使用虾米账本~\r您对虾米账本的任何意见和建议都会让虾米账本变的更好。\r如果您对虾米账本有更好的建议，被采纳后您将会获得虾米账本送出的小礼品。\r对于您的意见虾米账本会认真严肃的对待。\r再次感谢您的使用~";
        _tipLabel.font = kPingFangTC_Light(13);
        _tipLabel.textColor = kColor_Loding;
        _tipLabel.numberOfLines = 0;
    }
    return _tipLabel;
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationHeight);
    }];
    // 建议文本框
    [self.feedbackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(15));
        make.width.mas_equalTo(ScreenWidth - kIphone6Width(30));
        make.top.mas_equalTo(self.naviView.mas_bottom).mas_offset(kIphone6Width(45));
        make.height.mas_equalTo(kIphone6Width(130));
    }];
    // 字数Label
    [self.wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.feedbackTextView.mas_bottom).offset(kIphone6Width(-15));
        make.right.equalTo(self.feedbackTextView.mas_right).offset(kIphone6Width(-10));
        make.width.mas_equalTo(kIphone6Width(60));
        make.height.mas_equalTo(kIphone6Width(17));
    }];
    [self.makeSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.feedbackTextView.mas_bottom).offset(kIphone6Width(40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kIphone6Width(100));
        make.height.mas_equalTo(kIphone6Width(30));
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(15));
        make.right.mas_equalTo(kIphone6Width(-100));
        make.top.mas_equalTo(self.makeSureButton.mas_bottom).offset(kIphone6Width(30));
    }];
}
#pragma mark Delegate

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if(textView.text.length < 1){
        [ToastManage showTopToastWith:@"请填写后在提交~~"];
        return NO;
    }else{
        self.feedbackStr = textView.text;
        return YES;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"请填写您的意见建议"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *tem = [[text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![text isEqualToString:tem]) {
        return NO;
    }else{
        return YES;
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    self.wordNumberLabel.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
}
-(void)makeSureButtonTouchUpInside:(UIButton *)sender{
    if (self.feedbackStr.length == 0) {
        [ToastManage showTopToastWith:@"请填写后在提交~~"];
        return;
    }
    BmobObject  *book = [BmobObject objectWithClassName:@"userFeedback"];
    //设置帖子的标题和内容
    [book setObject:self.feedbackStr forKey:@"content"];
    [book setObject:kMemberInfoManager.objectId forKey:@"userID"];
    //异步保存
    [self showLoadingAnimation];
    [book saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [[BeautyLoadingHUD shareManager] stopAnimating];
            [ToastManage showTopToastWith:@"反馈成功！谢谢"];
        }else{
            if (error) {
                [[BeautyLoadingHUD shareManager] stopAnimating];
            }
        }
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
