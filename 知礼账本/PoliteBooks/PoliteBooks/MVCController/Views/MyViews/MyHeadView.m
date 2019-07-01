//
//  MyHeadView.m
//  PoliteBooks
//
//  Created by llk on 2019/7/1.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "MyHeadView.h"
@interface MyHeadView()

@property(nonatomic,strong)UIImageView * headImageview;

@property(nonatomic,strong)UILabel * titleLabel;

@end

@implementation MyHeadView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headImageview];
        [self addSubview:self.titleLabel];
        self.backgroundColor = kColor_Main_Color;
        [self addMasonry];
    }
    return self;
}
-(void)addMasonry{
    [_headImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(18));
        make.width.height.mas_equalTo(kIphone6Width(50));
        make.centerY.mas_equalTo(10);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageview.mas_right).offset(kIphone6Width(10));
        make.centerY.mas_equalTo(self.headImageview.mas_centerY);
    }];
}
-(UIImageView *)headImageview{
    if (!_headImageview) {
        _headImageview = [[UIImageView alloc] init];
        _headImageview.backgroundColor = kBlackColor;
        _headImageview.layer.cornerRadius = kIphone6Width(25);
        _headImageview.layer.masksToBounds = YES;
        _headImageview.image = [UIImage imageNamed:@"newIcon"];
        _headImageview.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageviewTouchUpInside:)];
        [_headImageview addGestureRecognizer:tap];
    }
    return _headImageview;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont14;
        _titleLabel.textColor = kBlackColor;
        _titleLabel.text = @"登陆后同步数据";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(void)headImageviewTouchUpInside:(UIGestureRecognizer *)tap{
    if (self.myHeadViewBtnSelectBlock) {
        self.myHeadViewBtnSelectBlock();
    }
}
-(void)setLogin:(BOOL)login{
    _login = login;
    if (login) {
        self.titleLabel.text = @"已登录";
    }else{
        self.titleLabel.text = @"登陆后同步数据";;
    }
}
@end
