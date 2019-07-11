//
//  MyHeadView.m
//  PoliteBooks
//
//  Created by llk on 2019/7/1.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "MyHeadView.h"
#import <StoreKit/StoreKit.h>
@interface MyHeadView()

@property(nonatomic,strong)UIImageView * headImageview;

@property(nonatomic,strong)UILabel * titleLabel;

@property(nonatomic,strong)UILabel * waterLabel;

@property(nonatomic,strong)UILabel * politeLabel;

@property(nonatomic,strong)UIView * lineView;

@property(nonatomic,strong)UIButton * shareBtn;

@property(nonatomic,strong)UIButton * commendAppBtn;

@end

@implementation MyHeadView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headImageview];
        [self addSubview:self.titleLabel];
        [self addSubview:self.shareBtn];
        [self addSubview:self.commendAppBtn];
        [self addSubview:self.waterLabel];
        [self addSubview:self.politeLabel];
        [self addSubview:self.lineView];
        self.backgroundColor = kBlackColor;
        [self addMasonry];
    }
    return self;
}
-(void)addMasonry{
    [_headImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(18));
        make.width.height.mas_equalTo(kIphone6Width(50));
        make.centerY.mas_equalTo(-10);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageview.mas_right).offset(kIphone6Width(10));
        make.centerY.mas_equalTo(self.headImageview.mas_centerY);
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kIphone6Width(12.5));
        make.centerY.mas_equalTo(-kIphone6Width(30));
        make.width.mas_equalTo(kIphone6Width(80));
        make.height.mas_equalTo(kIphone6Width(25));
    }];
    [self.commendAppBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kIphone6Width(12.5));
        make.centerY.mas_equalTo(kIphone6Width(30));
        make.width.mas_equalTo(kIphone6Width(80));
        make.height.mas_equalTo(kIphone6Width(25));
    }];
    [self.waterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(18));
        make.top.mas_equalTo(self.headImageview.mas_bottom).offset(kIphone6Width(35));
        make.width.mas_equalTo(kIphone6Width(100));
        
    }];
    [self.politeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.waterLabel.mas_right).offset(kIphone6Width(30));
        make.top.mas_equalTo(self.headImageview.mas_bottom).offset(kIphone6Width(35));
        make.width.mas_equalTo(kIphone6Width(100));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
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
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"分享App" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _shareBtn.backgroundColor = kWhiteColor;
        _shareBtn.hidden = YES;
        _shareBtn.titleLabel.font = kFont13;
        _shareBtn.layer.cornerRadius =  kIphone6Width(12.5);
        _shareBtn.layer.masksToBounds = YES;
        [_shareBtn addTarget:self action:@selector(shareBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
-(UIButton *)commendAppBtn{
    if (!_commendAppBtn) {
        _commendAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commendAppBtn setTitle:@"评论App" forState:UIControlStateNormal];
        [_commendAppBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _commendAppBtn.titleLabel.font= kFont13;
        _commendAppBtn.backgroundColor = kWhiteColor;
        _commendAppBtn.layer.cornerRadius =  kIphone6Width(12.5);
        _commendAppBtn.layer.masksToBounds = YES;
        [_commendAppBtn addTarget:self action:@selector(commendAppBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commendAppBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont14;
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.text = @"登陆后同步数据";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UILabel *)waterLabel{
    if (!_waterLabel) {
        _waterLabel = [[UILabel alloc] init];
        _waterLabel.font = kFont14;
        _waterLabel.textColor = kWhiteColor;
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
        _politeLabel.textColor = kWhiteColor;
        _politeLabel.text = @"3账";
        _politeLabel.textAlignment = NSTextAlignmentCenter;
        _politeLabel.numberOfLines = 0;
    }
    return _politeLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kBlackColor;
    }
    return _lineView;
}
-(void)headImageviewTouchUpInside:(UIGestureRecognizer *)tap{
    if (self.myHeadViewBtnSelectBlock) {
        self.myHeadViewBtnSelectBlock();
    }
}
-(void)setLogin:(BOOL)login{
    _login = login;
    if (login) {
        self.titleLabel.text = @"已登陆";
    }else{
        self.titleLabel.text = @"登陆后同步数据";;
    }
}
-(void)setWatherNum:(NSInteger)watherNum{
    _watherNum = watherNum;
    _waterLabel.text = [NSString stringWithFormat: @"流水账\r%ld笔",(long)watherNum];
}
-(void)setPoliteNum:(NSInteger)politeNum{
    _politeNum = politeNum;
    _politeLabel.text = [NSString stringWithFormat: @"礼账\r%ld本",(long)politeNum];
}
-(void)commendAppBtnTouchUpInside:(UIButton *)sender{
NSString*itunesurl = @"itms-apps://itunes.apple.com/cn/app/id1457792252?mt=8&action=write-review";
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
}
-(void)shareBtnTouchUpInside:(UIButton *)sender{
    
}
@end
