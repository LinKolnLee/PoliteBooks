//
//  CreatBookView.m
//  Buauty
//
//  Created by llk on 2019/1/18.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "CreatBookView.h"

@interface CreatBookView () <
UITextFieldDelegate
>


/// 背景
@property (nonatomic, strong) UIView *lineView;

@property(nonatomic,strong)UIView * oneLineView;

@property(nonatomic,strong)UIView * twoLineView;

@property(nonatomic,strong)UIView * threeLineView;


@property (nonatomic,strong)UILabel * dateLabel;

///
@property (nonatomic, strong) UIButton *closeButton;

/// 保存按钮
@property (nonatomic, strong) UIButton *saveButton;

@property(nonatomic,assign)NSInteger colorType;

@end

@implementation CreatBookView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = kIphone6Width(20);
        self.layer.masksToBounds = YES;
        self.layer.borderColor = kBlackColor.CGColor;
        self.layer.borderWidth = kIphone6Width(1);
        self.backgroundColor = TypeColor[0];
        self.colorType = 0;
        [self addSubview:self.lineView];
        [self addSubview:self.bookNameTextField];
        [self addSubview:self.dateLabel];
        [self addSubview:self.saveButton];
        [self setupLineViews];
        [self addMasonry];
        //[self animationWithView:self duration:0.25];
    }
    return self;
}
-(void)setupLineViews{
    CGFloat width = self.frame.size.height/8;
    for (int i = 0; i < 8; i++) {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, width *i, kIphone6Width(20), width)];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorSelector:)];
        [lineView addGestureRecognizer:tap];
        lineView.backgroundColor = TypeColor[i];
        lineView.tag = 200 + i;
        [self addSubview:lineView];
    }
}
-(void)colorSelector:(UIGestureRecognizer *)ges{
    self.backgroundColor = TypeColor[ges.view.tag - 200];
    self.colorType = ges.view.tag - 200;
}
#pragma mark - # Event Response
- (void)closeButtonTouchUpInside:(UIButton *)sender {
    
}

- (void)saveButtonTouchUpInside:(UIButton *)sender {
    if (self.bookNameTextField.text.length == 0 || self.bookNameTextField.text.length > 5) {
        return;
    }else{
        if (self.CreatBookViewSaveButtonClickBlock) {
        self.CreatBookViewSaveButtonClickBlock(self.bookNameTextField.text, self.dateLabel.text,self.colorType);
        }
    }
}

#pragma mark - # Private Methods
- (void)addMasonry {
    // 背景
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(kIphone6Width(20));
        make.width.mas_equalTo(1);
    }];
//    [self.oneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(self.lineView.mas_right);
//        make.centerY.mas_equalTo(0);
//        make.height.mas_equalTo(1);
//    }];
//    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(0);
//        make.top.mas_equalTo(self.mas_bottom).offset(-kIphone6Width(10));
//        make.width.height.mas_equalTo(kIphone6Width(20));
//    }];
    // 书本名称
    [self.bookNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_offset(35);
        make.top.mas_equalTo(55);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_offset(35);
        make.top.mas_equalTo(self.bookNameTextField.mas_bottom).offset(25);
    }];
    // 颜色
//    [self.colorButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.bottom.mas_equalTo(-10);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(40);
//    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - # Getter
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kBlackColor;
    }
    return _lineView;
}
-(UIView *)oneLineView{
    if (!_oneLineView) {
        _oneLineView = [[UIView alloc] init];
        _oneLineView.backgroundColor = kBlackColor;
    }
    return _oneLineView;
}
- (UITextField *)bookNameTextField {
    if (!_bookNameTextField) {
        _bookNameTextField = [[UITextField alloc] init];
        [_bookNameTextField setDelegate:self];
        _bookNameTextField.layer.cornerRadius = kIphone6Width(5);
        _bookNameTextField.layer.masksToBounds = YES;
        _bookNameTextField.layer.borderColor = kWhiteColor.CGColor;
        _bookNameTextField.layer.borderWidth = 1;
        _bookNameTextField.clearsOnInsertion = YES;
        _bookNameTextField.textAlignment = NSTextAlignmentCenter;
        _bookNameTextField.textColor = kWhiteColor;
        _bookNameTextField.tintColor = kWhiteColor;
        _bookNameTextField.font = kPingFangSC_Semibold(22);
        _bookNameTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _bookNameTextField.leftViewMode = UITextFieldViewModeAlways;
        //_serchTextField.placeholder = @"搜索教学视频";
        NSMutableParagraphStyle *style = [_bookNameTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
        style.alignment = NSTextAlignmentCenter;
        UIFont * font = kPingFangSC_Semibold(20);
        _bookNameTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"账本名称" attributes:@{NSForegroundColorAttributeName:kWhiteColor,NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    }
    return _bookNameTextField;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = kWhiteColor;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = kPingFangSC_Semibold(13);
        _dateLabel.text = [[NSDate getCurrentTimes] getCNDate];
    }
    return _dateLabel;
}
-(void)cleanBtnClick:(UIButton *)sender{
    
}


- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        _saveButton.layer.cornerRadius = kIphone6Width(20);
        _saveButton.layer.masksToBounds = YES;
        [_saveButton setTitle:@"存" forState:UIControlStateNormal];
        _saveButton.backgroundColor = kWhiteColor;
        [_saveButton setTitleColor:kBlackColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFont15;
        [_saveButton addTarget:self action:@selector(saveButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.text.length == 0) {
        return NO;
    }
    return YES;
}
@end

