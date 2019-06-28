//
//  newInputButton.m
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "NewInputButton.h"

@interface NewInputButton()

@property(nonatomic,strong)UIImageView * nimageView;

@property(nonatomic,strong)UILabel * ntitleLabel;

@end

@implementation NewInputButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.nimageView];
        [self addSubview:self.ntitleLabel];
        [self.nimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(kIphone6Width(5));
            make.width.mas_equalTo(kIphone6Width(24));
            make.height.mas_equalTo(kIphone6Width(30));
        }];
        [self.ntitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(kIphone6Width(40));
            make.width.mas_equalTo(kIphone6Width(30));
            make.height.mas_equalTo(kIphone6Width(15));
        }];
    }
    return self;
}
-(UIImageView *)nimageView{
    if (!_nimageView) {
        _nimageView = [[UIImageView alloc] init];
        _nimageView.contentMode = UIViewContentModeScaleAspectFill;
        _nimageView.image = [UIImage imageNamed:@"NewEdit"];
        _nimageView.backgroundColor = kWhiteColor;
        _nimageView.layer.cornerRadius = 5;
        _nimageView.layer.masksToBounds = YES;
    }
    return _nimageView;
}
-(UILabel *)ntitleLabel{
    if (!_ntitleLabel) {
        _ntitleLabel = [[UILabel alloc] init];
        _ntitleLabel.font = kFont13;
        _ntitleLabel.textColor = kBlackColor;
        _ntitleLabel.textAlignment = NSTextAlignmentCenter;
        _ntitleLabel.text = @"新记";
    }
    return _ntitleLabel;
}
@end
