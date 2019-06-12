//
//  InputTextView.m
//  Buauty
//
//  Created by llk on 2019/1/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "InputTextView.h"

@interface InputTextView () <
UITextFieldDelegate
>

/// 底部线条
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, strong) UIImageView *tagImageView;


@end

@implementation InputTextView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bottomLineView];
        [self addSubview:self.tagImageView];
        [self addSubview: self.tagLabel];
        [self addSubview:self.numberField];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)addMasonry {
    // 底部线条
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kIphone6Width(2));
    }];
    [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(15));
        make.top.mas_equalTo(kIphone6Width(15));
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(25));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagImageView.mas_right).offset(kIphone6Width(5));
        make.centerY.mas_equalTo(self.tagImageView.mas_centerY);
    }];
    // money
    [self.numberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(5));
        //make.top.mas_equalTo(kIphone6Width(15));
        make.bottom.mas_equalTo(self.bottomLineView.mas_top);
        make.width.mas_equalTo(kIphone6Width(150));
        make.height.mas_equalTo(kIphone6Width(30));
    }];
}

#pragma mark - # Getter
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = kHexRGB(0xBF9D66);
        
    }
    return _bottomLineView;
}
-(UILabel *)tagLabel{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.text = @"结婚";
        _tagLabel.textColor = TypeColor[0];
        _tagLabel.font = kPingFangTC_Light(12);
    }
    return _tagLabel;
}
- (UIImageView *)tagImageView {
    if (!_tagImageView) {
        _tagImageView = [[UIImageView alloc] init];
        _tagImageView.contentMode = UIViewContentModeScaleAspectFit;
        _tagImageView.backgroundColor = TypeColor[0];
        _tagImageView.layer.cornerRadius = kIphone6Width(12.5);
        _tagImageView.layer.masksToBounds = YES;
    }
    return _tagImageView;
}

- (UITextField *)numberField {
    if (!_numberField) {
        _numberField = [[UITextField alloc] init];
        [_numberField setDelegate:self];
        [_numberField setPlaceholder:@"¥:"];
        _numberField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _numberField.leftViewMode = UITextFieldViewModeAlways;
        _numberField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _numberField.font = kPingFangSC_Regular(16);
        _numberField.textAlignment = NSTextAlignmentRight;
    }
    return _numberField;
}
-(void)setModel:(PBBookModel *)model{
    _model = model;
    self.tagImageView.backgroundColor = TypeColor[model.bookColor];
    self.bottomLineView.backgroundColor = TypeColor[model.bookColor];
    self.tagLabel.text = model.bookName;
    self.tagLabel.textColor = TypeColor[model.bookColor];
}
@end
