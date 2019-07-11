//
//  InputDateMarkView.m
//  Buauty
//
//  Created by llk on 2019/1/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "InputDateMarkView.h"
#import "SPMultipleSwitch.h"
@interface InputDateMarkView () <
UITextFieldDelegate
>

@property (nonatomic, strong) UIButton *dataButton;

@property (nonatomic, strong) UILabel *markLabel;

/// 标注
@property (nonatomic, strong) UIImageView *dataImageView;

@property (nonatomic,strong)UIView * lineView;

@property(nonatomic,strong)SPMultipleSwitch * moneyTypeSwitch;
@end

@implementation InputDateMarkView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dataButton];
        [self addSubview:self.markLabel];
        [self addSubview:self.moneyTypeSwitch];
        [self addSubview:self.markTextField];
        [self addSubview:self.dataImageView];
        [self addSubview:self.lineView];
        [self addMasonry];
        [self.dataButton setTitle:[[NSDate getCurrentTimes] getCNDate] forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)addMasonry {
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kIphone6Width(-100));
        make.top.mas_equalTo(kIphone6Width(10));
        make.width.mas_equalTo(kIphone6Width(70));
        make.height.mas_equalTo(kIphone6Width(20));
    }];
    // 标注
    [self.markTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.markLabel.mas_right);
        make.bottom.mas_equalTo(self.markLabel);
        make.width.mas_equalTo(kIphone6Width(80));
        make.height.mas_equalTo(kIphone6Width(25));
    }];
    [self.moneyTypeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kIphone6Width(-10));
        make.top.mas_equalTo(self.markLabel.mas_bottom).offset(kIphone6Width(34));
        make.width.mas_equalTo(kIphone6Width(150));
        make.height.mas_equalTo(kIphone6Width(40));
    }];
    [self.dataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kIphone6Width(-160));
        make.top.mas_equalTo(self.moneyTypeSwitch.mas_bottom).offset(kIphone6Width(34));
        make.width.mas_equalTo(kIphone6Width(20));
        make.height.mas_equalTo(kIphone6Width(20));
    }];
    [self.dataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dataImageView.mas_right).mas_offset(0);
        make.top.mas_equalTo(self.dataImageView);
        make.width.mas_equalTo(kIphone6Width(150));
        make.height.mas_equalTo(kIphone6Width(20));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.markTextField.mas_bottom);
        make.left.mas_equalTo(self.markTextField.mas_left);
        make.width.mas_equalTo(self.markTextField.mas_width);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - # Getter
- (UIButton *)dataButton {
    if (!_dataButton) {
        _dataButton = [[UIButton alloc] init];
        [_dataButton setTitle:@"貳零壹玖年壹月肆号" forState:UIControlStateNormal];
        [_dataButton setTitleColor:kBlackColor forState:UIControlStateNormal];
        _dataButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _dataButton.titleLabel.font = kPingFangSC_Regular(12);
        [_dataButton addTarget:self action:@selector(dataButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dataButton;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [[UILabel alloc] init];
        _markLabel.textColor = kBlackColor;
        _markLabel.font = kFont13;
        _markLabel.textAlignment = NSTextAlignmentLeft;
        _markLabel.text = @"礼尚往来：";
    }
    return _markLabel;
}

- (UITextField *)markTextField {
    if (!_markTextField) {
        _markTextField = [[UITextField alloc] init];
        [_markTextField setDelegate:self];
        [_markTextField setPlaceholder:@"往来姓名"];
        _markTextField.textAlignment = NSTextAlignmentCenter;
        _markTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, 0)];
        _markTextField.returnKeyType = UIReturnKeyDone;
        _markTextField.leftViewMode = UITextFieldViewModeAlways;
        //_markTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _markTextField.font = kPingFangSC_Regular(14);
        //_markTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _markTextField;
}

- (UIImageView *)dataImageView {
    if (!_dataImageView) {
        _dataImageView = [[UIImageView alloc] init];
        _dataImageView.contentMode = UIViewContentModeScaleAspectFill;
        _dataImageView.image = [UIImage imageNamed:@"Date"];
    }
    return _dataImageView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kBlackColor;
    }
    return _lineView;
}
-(SPMultipleSwitch *)moneyTypeSwitch{
    if (!_moneyTypeSwitch) {
        _moneyTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"进礼",@"收礼"]];
        _moneyTypeSwitch.backgroundColor = kWhiteColor;
        _moneyTypeSwitch.selectedTitleColor = kWhiteColor;
        _moneyTypeSwitch.titleColor = kHexRGB(0x665757);
        _moneyTypeSwitch.contentInset = 5;
        _moneyTypeSwitch.spacing = 10;
        _moneyTypeSwitch.titleFont = kFont14;
        _moneyTypeSwitch.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        _moneyTypeSwitch.layer.borderColor = kHexRGB(0x665757).CGColor;
//        _moneyTypeSwitch.layer.cornerRadius = kIphone6Width(20);
//        _moneyTypeSwitch.layer.masksToBounds = YES;
        [_moneyTypeSwitch addTarget:self action:@selector(moneyTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moneyTypeSwitch;
}
-(void)dataButtonTouchUpInside:(UIButton *)sender{
    if (self.InputDateMarkViewTouchClickBlock) {
        self.InputDateMarkViewTouchClickBlock();
    }
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [_dataButton setTitle:titleStr forState:UIControlStateNormal];
}
-(void)moneyTypeSwitchAction:(SPMultipleSwitch *)swit{
    if (self.InputDateMarkViewTypeSelectBlock) {
        self.InputDateMarkViewTypeSelectBlock( swit.selectedSegmentIndex);
    }
}

-(void)setBookModel:(PBBookModel *)bookModel{
    _bookModel = bookModel;
    _moneyTypeSwitch.trackerColor = TypeColor[bookModel.bookColor];
}
@end
