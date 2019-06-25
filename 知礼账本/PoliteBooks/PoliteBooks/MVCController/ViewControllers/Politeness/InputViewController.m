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
#import "SPMultipleSwitch.h"
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

@property(nonatomic,strong)SPMultipleSwitch * relationTypeSwitch;

/**
 进账/出账
 */
@property(nonatomic,assign)NSInteger classType;


/**
 记账明细类别
 */
@property(nonatomic,assign)NSInteger tableType;

/**
 关系类别
 */
@property(nonatomic,assign)NSInteger tableRealtionType;

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

@property(nonatomic,strong)NSArray * relationItems;
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
    [self.view addSubview:self.dateMarkView];
    [self.view addSubview:self.relationTypeSwitch];
    [self addMasonry];
    self.classType = 0;
    self.tableType = 0;
    self.tableRealtionType = 0;
    self.moneyString = @"";
    self.dateString = [[NSDate getCurrentTimes] getCNDate];
    self.relationItems = @[@"亲戚",@"朋友",@"同学",@"同事",@"邻里"];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self performSelector:@selector(showMoneyKeyboard) withObject:nil afterDelay:0.25];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.shouldResignOnTouchOutside = YES;
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
    _keyboard.returnBgColor = TypeColor[self.bookModel.bookColor];;
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
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kIphone6Width(15));
        make.height.mas_equalTo(kIphone6Width(40));
    }];
    [self.textInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.titleSettingView.mas_bottom).offset(kIphone6Width(15));
        make.height.mas_equalTo(kIphone6Width(50));
    }];
    [self.dateMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textInputView.mas_bottom).offset(35);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kIphone6Width(214));
        make.width.mas_equalTo(ScreenWidth);
    }];
//    [self.relationTypeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.dateMarkView.mas_bottom).offset(kIphone6Width(20));
//        make.left.mas_equalTo(kIphone6Width(20));
//        make.right.mas_equalTo(kIphone6Width(-20));
//        make.height.mas_equalTo(kIphone6Width(40));
//    }];
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
        _titleSettingView.title = self.bookModel.bookName;
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
        _dateMarkView.bookModel = self.bookModel;
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
        _dateMarkView.InputDateMarkViewTypeSelectBlock = ^(NSInteger type) {
            weakSelf.classType = type;
        };
    }
    return _dateMarkView;
}
-(SPMultipleSwitch *)relationTypeSwitch{
    if (!_relationTypeSwitch) {
        _relationTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"亲戚",@"朋友",@"同学",@"同事",@"邻里"]];
        _relationTypeSwitch.frame = CGRectMake(15, ScreenHeight - kIphone6Width(260), ScreenWidth-30, 40);
        _relationTypeSwitch.backgroundColor = kHexRGB(0xe9f1f6);
        _relationTypeSwitch.selectedTitleColor = kWhiteColor;
        _relationTypeSwitch.titleColor = kHexRGB(0x665757);
        _relationTypeSwitch.trackerColor = TypeColor[self.bookModel.bookColor];
        _relationTypeSwitch.contentInset = 5;
        _relationTypeSwitch.spacing = 10;
        _relationTypeSwitch.titleFont = kFont14;
//        _relationTypeSwitch.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
//        _relationTypeSwitch.layer.borderColor = kHexRGB(0x665757).CGColor;
        [_relationTypeSwitch addTarget:self action:@selector(relationTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _relationTypeSwitch;
}
-(void)relationTypeSwitchAction:(SPMultipleSwitch *)swit{
    self.tableRealtionType = swit.selectedSegmentIndex;
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
    if (self.isEdit) {
        [self updateModelConfig];
    }else{
        [self setupModelConfig];
    }
    self.sureButton.enabled = NO;
}
-(void)cancelButtonTouchUpInside:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)updateModelConfig{
    BmobObject  *table = [BmobObject objectWithoutDataWithClassName:@"userTables" objectId:self.tableModel.objectId];
    [table setObject:self.moneyString forKey:@"dUserMoney"];
    [table setObject:self.nameString forKey:@"dUserName"];
    [table setObject:self.relationItems[self.tableRealtionType] forKey:@"dUserRealtion"];
    WS(weakSelf);
    [table updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            if (weakSelf.bookModel.bookInMoney && weakSelf.bookModel.bookOutMoney) {
                weakSelf.bookModel.bookInMoney = weakSelf.bookModel.bookInMoney -[weakSelf.tableModel.userMoney integerValue] + [weakSelf.moneyString integerValue];
                weakSelf.bookModel.bookOutMoney = weakSelf.bookModel.bookOutMoney -[weakSelf.tableModel.userMoney integerValue] + [weakSelf.moneyString integerValue];
                [BmobBookExtension updataForModel:weakSelf.bookModel withType:2 success:^(id  _Nonnull responseObject) {
                    [table updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            [ToastManage showTopToastWith:@"账单修改成功"];
                             weakSelf.InputViewControllerPopBlock();
                            [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        } else {
                            [ToastManage showTopToastWith:@"账单修改失败"];
                        }
                    }];
                }];
                return ;
            }
            if (weakSelf.bookModel.bookInMoney) {
                weakSelf.bookModel.bookInMoney = weakSelf.bookModel.bookInMoney -[weakSelf.tableModel.userMoney integerValue] + [weakSelf.moneyString integerValue];
                [BmobBookExtension updataForModel:weakSelf.bookModel withType:1 success:^(id  _Nonnull responseObject) {
                    [table updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            [ToastManage showTopToastWith:@"账单修改成功"];
                             weakSelf.InputViewControllerPopBlock();
                            [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        } else {
                            [ToastManage showTopToastWith:@"账单修改失败"];
                        }
                    }];
                }];
            }
            if (weakSelf.bookModel.bookOutMoney) {
                weakSelf.bookModel.bookOutMoney = weakSelf.bookModel.bookOutMoney -[weakSelf.tableModel.userMoney integerValue] + [weakSelf.moneyString integerValue];
                [BmobBookExtension updataForModel:weakSelf.bookModel withType:0 success:^(id  _Nonnull responseObject) {
                    [table updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            [ToastManage showTopToastWith:@"账单修改成功"];
                             weakSelf.InputViewControllerPopBlock();
                            [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        } else {
                            [ToastManage showTopToastWith:@"账单修改失败"];
                        }
                    }];
                }];
            }
        } else {
            [ToastManage showTopToastWith:@"账单修改失败"];
        }
    }];
}
-(void)setupModelConfig{
    PBTableModel * model = [[PBTableModel alloc] init];
    model.userName = self.nameString;
    model.userMoney = self.moneyString;
    model.userDate = self.dateString;
    model.userType = self.bookModel.bookName;
    model.bookColor = self.bookModel.bookColor;
    model.userRelation = self.relationItems[self.tableRealtionType];
    if (self.classType == 0) {
        model.inType = 1;
        model.outType = 0;
        self.bookModel.bookOutMoney = self.bookModel.bookOutMoney + [self.moneyString integerValue];
        [BmobBookExtension updataForModel:self.bookModel withType:0 success:^(id  _Nonnull responseObject) {
        }];
        
    }else{
        model.inType = 0;
        model.outType = 1;
        self.bookModel.bookInMoney = self.bookModel.bookInMoney + [self.moneyString integerValue];
        [BmobBookExtension updataForModel:self.bookModel withType:1 success:^(id  _Nonnull responseObject) {
        }];
    }
    model.objectId = @"0";
    WS(weakSelf);
    [PBTableExtension inserDataForModel:model andBookModel:self.bookModel success:^(id  _Nonnull responseObject) {
        self.sureButton.enabled = YES;
        weakSelf.InputViewControllerPopBlock();
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}
-(void)setBookModel:(PBBookModel *)bookModel{
    _bookModel = bookModel;
}
-(void)setTableModel:(PBTableModel *)tableModel{
    _tableModel = tableModel;
    self.moneyString = tableModel.userMoney;
    self.textInputView.numberField.text = tableModel.userMoney;
    self.nameString = tableModel.userName;
    self.dateMarkView.markTextField.text = tableModel.userName;
    if (tableModel.userRelation) {
        for (int i = 0; i < self.relationItems.count; i++) {
            if ([tableModel.userRelation isEqualToString:self.relationItems[i]]) {
                self.tableRealtionType = i;
            }
        }
    }else{
        self.tableRealtionType = 0;
    }
}
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
}
@end
