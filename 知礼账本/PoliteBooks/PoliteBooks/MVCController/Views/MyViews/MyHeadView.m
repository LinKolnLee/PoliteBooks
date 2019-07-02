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

@property(nonatomic,strong)UILabel * waterLabel;

@property(nonatomic,strong)UILabel * politeLabel;

@end

@implementation MyHeadView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headImageview];
        [self addSubview:self.titleLabel];
        [self addSubview:self.waterLabel];
        [self addSubview:self.politeLabel];
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
    [self.waterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(18));
        make.top.mas_equalTo(self.headImageview.mas_bottom).offset(kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(100));
        
    }];
    [self.politeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.waterLabel.mas_right).offset(kIphone6Width(30));
        make.top.mas_equalTo(self.headImageview.mas_bottom).offset(kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(100));
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
-(UILabel *)waterLabel{
    if (!_waterLabel) {
        _waterLabel = [[UILabel alloc] init];
        _waterLabel.font = kFont14;
        _waterLabel.textColor = kBlackColor;
        _waterLabel.text = @"流水账";
        _waterLabel.textAlignment = NSTextAlignmentCenter;
        _waterLabel.numberOfLines = 0;
    }
    return _waterLabel;
}
-(UILabel *)politeLabel{
    if (!_politeLabel) {
        _politeLabel = [[UILabel alloc] init];
        _politeLabel.font = kFont14;
        _politeLabel.textColor = kBlackColor;
        _politeLabel.text = @"3账";
        _politeLabel.textAlignment = NSTextAlignmentCenter;
        _politeLabel.numberOfLines = 0;
    }
    return _politeLabel;
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
-(void)setWatherNum:(NSInteger)watherNum{
    _watherNum = watherNum;
    _waterLabel.text = [NSString stringWithFormat: @"流水账\r%ld条",(long)watherNum];
}
-(void)setPoliteNum:(NSInteger)politeNum{
    _politeNum = politeNum;
    _politeLabel.text = [NSString stringWithFormat: @"礼账\r%ld本",(long)politeNum];
}
@end
