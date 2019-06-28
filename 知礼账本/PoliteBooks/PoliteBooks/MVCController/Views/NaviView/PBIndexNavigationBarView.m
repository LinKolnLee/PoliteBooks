//
//  PBIndexNavigationBarView.m
//  Buauty
//
//  Created by llk on 2019/1/10.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "PBIndexNavigationBarView.h"

@interface PBIndexNavigationBarView ()

/// 左侧按钮
@property (nonatomic, strong) UIButton *leftButton;

/// 右侧按钮
@property (nonatomic, strong) UIButton *rightButton;

/// titlt
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PBIndexNavigationBarView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.titleLabel];
        self.backgroundColor = kColor_Main_Color;
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Event Response
- (void)leftButtonTouchUpInside:(UIButton *)sender {
    if (self.PBIndexNavigationBarViewLeftButtonBlock) {
        self.PBIndexNavigationBarViewLeftButtonBlock();
    }
}

- (void)rightButtonTouchUpInside:(UIButton *)sender {
    if (self.PBIndexNavigationBarViewRightButtonBlock) {
        self.PBIndexNavigationBarViewRightButtonBlock();
    }
}

#pragma mark - # Private Methods
- (void)addMasonry {
    // titlt
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kIphone6Width(180));
        make.height.mas_equalTo(kIphone6Width(25));
        make.centerX.mas_equalTo(-5);
        make.centerY.mas_equalTo(kIphone6Width(10));
    }];
    // 左侧按钮
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(25));
        make.centerY.mas_equalTo(self.titleLabel);

    }];
    // 右侧按钮
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(25));
         make.centerY.mas_equalTo(self.titleLabel);
    }];
    
}

#pragma mark - # Getter
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        _leftButton.adjustsImageWhenDisabled = NO;
        _leftButton.adjustsImageWhenHighlighted = NO;
        [_leftButton addTarget:self action:@selector(leftButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.adjustsImageWhenDisabled = NO;
        _rightButton.adjustsImageWhenHighlighted = NO;
        [_rightButton addTarget:self action:@selector(rightButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont22;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelTouchClick:)];
        _titleLabel.userInteractionEnabled = YES;
        [_titleLabel addGestureRecognizer:tap];
    }
    return _titleLabel;
}
-(void)setLeftImage:(NSString *)leftImage{
    [self.leftButton setImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
}
-(void)setRightImage:(NSString *)rightImage{
    [self.rightButton setImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
}
-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}
-(void)setTitleFont:(UIFont *)titleFont{
    self.titleLabel.font = titleFont;
}
-(void)setRightHidden:(BOOL)rightHidden{
    _rightHidden = rightHidden;
    if (rightHidden) {
        self.rightButton.hidden = rightHidden;
    }
}
-(void)titleLabelTouchClick:(UIGestureRecognizer *)ges{
    if (self.PBIndexNavigationBarViewTitleLabelBlock) {
        self.PBIndexNavigationBarViewTitleLabelBlock();
    }
}
@end
