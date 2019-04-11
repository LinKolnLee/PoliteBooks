//
//  InputClassTagCollectionViewCell.m
//  Buauty
//
//  Created by llk on 2019/1/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "InputClassTagCollectionViewCell.h"

@interface InputClassTagCollectionViewCell ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property(nonatomic,strong)UILabel * titleLabel;

@end

@implementation InputClassTagCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bgImageView];
        [self.contentView addSubview:self.titleLabel];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)addMasonry {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_offset(kIphone6Width(40));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.bgImageView.mas_bottom);
    }];
}

#pragma mark - # Getter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = kHexRGB(0x817090);
        _bgImageView.layer.cornerRadius = kIphone6Width(20);
        _bgImageView.clipsToBounds = YES;
        
    }
    return _bgImageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont12;
        _titleLabel.textColor = kBlackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"结婚";
    }
    return _titleLabel;
}
-(void)setColor:(UIColor *)color{
    self.bgImageView.backgroundColor = color;
}
-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}
@end
