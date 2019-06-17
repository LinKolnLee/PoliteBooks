//
//  InputContentView.m
//  Buauty
//
//  Created by llk on 2019/1/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "InputTitleView.h"

@interface InputTitleView ()

/// 线条背景
@property (nonatomic, strong) UIImageView *lineImageView;

/// 左边线条
@property (nonatomic, strong) UIView *lLineView;

/// 出账按钮
@property (nonatomic, strong) UILabel *appearButton;

@end

@implementation InputTitleView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lineImageView];
        [self addSubview:self.lLineView];
        [self addSubview:self.appearButton];
        [self addMasonry];
        CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
        keyAnimaion.keyPath = @"transform.rotation";
        keyAnimaion.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI)];//度数转弧度
        keyAnimaion.removedOnCompletion = NO;
        keyAnimaion.fillMode = kCAFillModeForwards;
        keyAnimaion.duration = 0.3;
        keyAnimaion.repeatCount = MAXFLOAT;
        [self.appearButton.layer addAnimation:keyAnimaion forKey:nil];
    }
    return self;
}


#pragma mark - # Private Methods
- (void)addMasonry {
    // 线条背景
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    // 左边线条
    [self.lLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lineImageView.mas_centerX).offset(kIphone6Width(0));
        make.top.mas_equalTo(self.lineImageView.mas_bottom).offset(kIphone6Width(-1));
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(15);
    }];
    // 出账按钮
    [self.appearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lLineView.mas_bottom).mas_offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.lLineView);
    }];

}

#pragma mark - # Getter
- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.contentMode = UIViewContentModeScaleAspectFill;
        //_lineImageView.image = [UIImage imageNamed:@"line"];
    }
    return _lineImageView;
}

- (UIView *)lLineView {
    if (!_lLineView) {
        _lLineView = [[UIView alloc] init];
        _lLineView.backgroundColor = kBlackColor;
    }
    return _lLineView;
}
- (UILabel *)appearButton {
    if (!_appearButton) {
        _appearButton = [[UILabel alloc] init];
        _appearButton.backgroundColor = kHexRGB(0xA73946);
        _appearButton.numberOfLines = 0;
        _appearButton.layer.cornerRadius = kIphone6Width(5);
        _appearButton.layer.masksToBounds = YES;
        _appearButton.font = kFont14;
        _appearButton.textColor = kWhiteColor;
        _appearButton.textAlignment = NSTextAlignmentCenter;
        //[_appearButton addTarget:self action:@selector(appearButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appearButton;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.appearButton.text = title;
}
-(void)setColorIndex:(NSInteger)colorIndex{
    _colorIndex = colorIndex;
    self.appearButton.backgroundColor = TypeColor[colorIndex];
    self.lineImageView.backgroundColor = TypeColor[colorIndex];
    self.lLineView.backgroundColor = TypeColor[colorIndex];
}
@end
