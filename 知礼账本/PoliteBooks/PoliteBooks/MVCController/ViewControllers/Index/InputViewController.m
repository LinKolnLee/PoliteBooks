//
//  InputViewController.m
//  Buauty
//
//  Created by llk on 2019/1/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "InputViewController.h"
#import "InputTitleView.h"
#import "InputTextView.h"
#import "InputClassTagsView.h"
#import "InputDateMarkView.h"
#import "YLNumberKeyboard.h"
#import "WSDatePickerView.h"

@interface InputViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton * sureButton;

@property(nonatomic,strong)UIButton * cancelButton;

/// 图片
@property (nonatomic, strong) UIImageView *topTitleImage;

/// title
@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic,strong)InputTitleView * titleSettingView;

@property(nonatomic,strong)InputTextView * textInputView;

@property(nonatomic,strong)InputClassTagsView * classTagView;

@property(nonatomic,strong)InputDateMarkView * dateMarkView;

/**
 进账/出账
 */
@property(nonatomic,assign)NSInteger classType;

/**
 记账明细类别
 */
@property(nonatomic,assign)NSInteger tableType;

/**
 账单金额
 */
@property(nonatomic,strong)NSString * moneyString;

/**
 账单日期
 */
@property(nonatomic,strong)NSString * dateString;

/**
 账单人
 */
@property(nonatomic,strong)NSString * nameString;

@property(nonatomic,strong)YLNumberKeyboard * keyboard;
@end

@implementation InputViewController

#pragma mark - # Life Cycle
- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.sureButton];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.topTitleImage];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleSettingView];
    [self.view addSubview:self.textInputView];
    //[self.view addSubview:self.classTagView];
    [self.view addSubview:self.dateMarkView];
    [self addMasonry];
    self.classType = 0;
    self.tableType = 0;
    self.moneyString = @"";
    self.dateString = [[NSDate getCurrentTimes] getCNDate];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self performSelector:@selector(showMoneyKeyboard) withObject:nil afterDelay:0.25];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.shouldResignOnTouchOutside = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.shouldResignOnTouchOutside = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)showMoneyKeyboard
{
    _keyboard = [[YLNumberKeyboard alloc]init];
    // 指定哪个textfield需要弹出数字键盘
    _keyboard.textFiled = self.textInputView.numberField;
    self.textInputView.numberField.inputView = _keyboard;
    [self.textInputView.numberField becomeFirstResponder];
    // 个性化设置键盘
    _keyboard.bgColor = kWhiteColor;
    _keyboard.returnBgColor = kHexRGB(0xD4CF96);
    _keyboard.returnTitleColor = kWhiteColor;
    //kHexRGB(0xD4CF96);
    _keyboard.formatString = @"00000.000";
    WS(weakSelf);
   // __weak YLNumberKeyboard *keyboard1 = _keyboard;
    _keyboard.confirmClickBlock = ^{
        weakSelf.moneyString = weakSelf.textInputView.numberField.text;
    };
    // 绘制键盘
    [_keyboard drawKeyboard];
    
}
#pragma mark - # Private Methods
- (void)addMasonry {
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(20));
        make.top.mas_equalTo(kIphone6Width(40));
        make.width.height.mas_equalTo(kIphone6Width(20));
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(20));
        make.top.mas_equalTo(kIphone6Width(40));
        make.width.height.mas_equalTo(kIphone6Width(20));
    }];
    // 图片
    [self.topTitleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(kIphone6Width(-10));
        make.top.mas_equalTo(kIphone6Width(45));
        make.width.mas_equalTo(kIphone6Width(20));
        make.height.mas_equalTo(kIphone6Width(20));
    }];
    // title
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topTitleImage.mas_right).mas_offset(0);
        make.top.mas_equalTo(kIphone6Width(45));
        make.width.mas_equalTo(kIphone6Width(60));
        make.height.mas_equalTo(kIphone6Width(20));
    }];
    [self.titleSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kIphone6Width(10));
        make.height.mas_equalTo(kIphone6Width(100));
    }];
    [self.textInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleSettingView.mas_bottom).offset(kIphone6Width(10));
        make.height.mas_equalTo(kIphone6Width(50));
    }];
    [self.dateMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textInputView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(kIphone6Width(100));
        make.width.mas_equalTo(kIphone6Width(300));
    }];
}

#pragma mark - # Getter
-(UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton addTarget:self action:@selector(sureButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setImage:[UIImage imageNamed:@"Sure"] forState:UIControlStateNormal];
    }
    return _sureButton;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton addTarget:self action:@selector(cancelButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    }
    return _cancelButton;
}
- (UIImageView *)topTitleImage {
    if (!_topTitleImage) {
        _topTitleImage = [[UIImageView alloc] init];
        _topTitleImage.image = [UIImage imageNamed:@"Chinesebrush"];
    }
    return _topTitleImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont22;
        _titleLabel.text = @"新记";
    }
    return _titleLabel;
}
-(InputTitleView *)titleSettingView{
    if (!_titleSettingView) {
        _titleSettingView = [[InputTitleView alloc] init];
        _titleSettingView.colorIndex = self.bookModel.bookColor;
    }
    return _titleSettingView;
}
-(InputTextView *)textInputView{
    if (!_textInputView) {
        _textInputView = [[InputTextView alloc] init];
        _textInputView.model = self.bookModel;
    }
    return _textInputView;
}

-(InputDateMarkView *)dateMarkView{
    if (!_dateMarkView) {
        _dateMarkView = [[InputDateMarkView alloc] init];
        _dateMarkView.markTextField.delegate = self;
        WS(weakSelf);
         __weak InputDateMarkView *dateMarkView1 = _dateMarkView;
        _dateMarkView.InputDateMarkViewTouchClickBlock = ^{
            [weakSelf.keyboard removeFromSuperview];
            [weakSelf.keyboard.textFiled resignFirstResponder];
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                
                NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                NSLog(@"选择的日期：%@",dateString);
                [weakSelf showMoneyKeyboard];
                dateMarkView1.titleStr = [dateString getCNDate];
                weakSelf.dateString = [dateString getCNDate];
            }];
            datepicker.dateLabelColor = TypeColor[weakSelf.tableType];
            datepicker.datePickerColor = TypeColor[weakSelf.tableType];
            datepicker.doneButtonColor = TypeColor[weakSelf.tableType];
            [datepicker show];
        };
    }
    return _dateMarkView;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.nameString = textField.text;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.text.length == 0) {
        return NO;
    }else{
        self.nameString = textField.text;
        return YES;
    }
    return YES;
}
-(void)sureButtonTouchUpInside:(UIButton *)sender{
    self.moneyString =  self.textInputView.numberField.text;
    if (self.nameString.length == 0 || self.moneyString.length == 0 ) {
        return;
    }
    [self setupModelConfig];
}
-(void)cancelButtonTouchUpInside:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setupModelConfig{
    PBTableModel * model = [[PBTableModel alloc] init];
    model.userName = self.nameString;
    model.userMoney = [self.moneyString getCnMoney];
    model.userDate = self.dateString;
    model.userType = self.bookModel.bookName;
    model.objectId = @"0";
    WS(weakSelf);
    [PBTableExtension inserDataForModel:model andBookModel:self.bookModel success:^(id  _Nonnull responseObject) {
        weakSelf.InputViewControllerPopBlock();
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];

}
-(void)setBookModel:(PBBookModel *)bookModel{
    _bookModel = bookModel;
}

@end
