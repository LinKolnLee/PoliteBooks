//
//  OrderDetailHeaderView.m
//  Buauty
//
//  Created by llk on 2019/7/16.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "OrderDetailHeaderView.h"

@interface OrderDetailHeaderView ()

/// 结余
@property (nonatomic, strong) UILabel *surplusLabel;

@property (nonatomic, strong) UILabel *surplusMoneyLabel;

/// 竖线
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *incomeMoneyLabel;

@property (nonatomic, strong) UILabel *outputMoneyLabel;

@end

@implementation OrderDetailHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.surplusLabel];
        [self addSubview:self.surplusMoneyLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.incomeMoneyLabel];
        [self addSubview:self.outputMoneyLabel];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)addMasonry {
    // 结余
    [self.surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kIphone6Width(25));
        make.centerX.mas_equalTo(0);
    }];
    [self.surplusMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.surplusLabel.mas_bottom).mas_offset(kIphone6Width(10));
        make.centerX.mas_equalTo(0);
    }];
    // 竖线
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.surplusMoneyLabel.mas_bottom).mas_offset(kIphone6Width(40));
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(kIphone6Width(20));
        make.centerX.mas_equalTo(0);
    }];
    [self.incomeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.lineView.mas_left);
        make.top.mas_equalTo(self.surplusMoneyLabel.mas_bottom).mas_offset(kIphone6Width(40));
    }];
    [self.outputMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_right);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.incomeMoneyLabel);
    }];
}

#pragma mark - # Getter
- (UILabel *)surplusLabel {
    if (!_surplusLabel) {
        _surplusLabel = [[UILabel alloc] init];
        _surplusLabel.backgroundColor = kBlackColor;
        _surplusLabel.textColor = kWhiteColor;
        _surplusLabel.font = kFont12;
        _surplusLabel.textAlignment = NSTextAlignmentCenter;
        _surplusLabel.text = @"结余";
    }
    return _surplusLabel;
}

- (UILabel *)surplusMoneyLabel {
    if (!_surplusMoneyLabel) {
        _surplusMoneyLabel = [[UILabel alloc] init];
        _surplusMoneyLabel.textColor = kWhiteColor;
        _surplusMoneyLabel.font = kFont20;
        _surplusMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _surplusMoneyLabel.text = @"150.00";
    }
    return _surplusMoneyLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kWhiteColor;
    }
    return _lineView;
}

- (UILabel *)incomeMoneyLabel {
    if (!_incomeMoneyLabel) {
        _incomeMoneyLabel = [[UILabel alloc] init];
        _incomeMoneyLabel.textColor = kWhiteColor;
        _incomeMoneyLabel.font = kFont20;
        _incomeMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _incomeMoneyLabel.text = @"150.00";
    }
    return _incomeMoneyLabel;
}

- (UILabel *)outputMoneyLabel {
    if (!_outputMoneyLabel) {
        _outputMoneyLabel = [[UILabel alloc] init];
        _outputMoneyLabel.textColor = kWhiteColor;
        _outputMoneyLabel.font = kFont20;
        _outputMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _outputMoneyLabel.text = @"150.00";
    }
    return _outputMoneyLabel;
}

-(void)setDataSource:(NSMutableArray<NSMutableArray<PBWatherModel *> *> *)dataSource{
    _dataSource = dataSource;
    CGFloat incomeMoney = 0.0;
    CGFloat outMoney = 0.0;
    CGFloat sumMoney = 0.0;
    for (NSMutableArray * models in dataSource) {
        for (PBWatherModel * model in models) {
            if (model.moneyType) {
                incomeMoney += [model.price floatValue];
            }else{
                outMoney += [model.price floatValue];
            }
        }
    }
    sumMoney = incomeMoney - outMoney;
    NSString * outStr = [NSString stringWithFormat:@"支出%.2f",outMoney];
    NSString * incomeStr= [NSString stringWithFormat:@"收入%.2f",incomeMoney];
    NSString * sumStr = [NSString stringWithFormat:@"%.2f",sumMoney];
    [self.surplusMoneyLabel setAttributedText:[NSAttributedString createMath:sumStr integer:kFont20 decimal:kFont13 color:kWhiteColor]];
    
    
    [self.incomeMoneyLabel setAttributedText:[NSAttributedString createMath:incomeStr integer:kFont14 decimal:kFont12 color:kWhiteColor]];
    [self.outputMoneyLabel setAttributedText:[NSAttributedString createMath:outStr integer:kFont14 decimal:kFont12 color:kWhiteColor]];
}
@end
