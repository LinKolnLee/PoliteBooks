//
//  OrderDetailTableSectionView.m
//  PoliteBooks
//
//  Created by llk on 2019/7/16.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "OrderDetailTableSectionView.h"
@interface OrderDetailTableSectionView()
@property (nonatomic, strong) UILabel *monthLabel;

@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *outputLabel;

@property (nonatomic, strong) UILabel *sumLabel;
@end
@implementation OrderDetailTableSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self){
        [self.contentView addSubview:self.monthLabel];
        [self.contentView addSubview:self.incomeLabel];
        [self.contentView addSubview:self.outputLabel];
        [self.contentView addSubview:self.sumLabel];
        self.contentView.backgroundColor = kWhiteColor;
        [self addMasonry];
    }
    return self;
}
- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.backgroundColor = kWhiteColor;
        _monthLabel.textColor = kBlackColor;
        _monthLabel.font = kFont12;
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.text = @"月份";
    }
    return _monthLabel;
}

- (UILabel *)incomeLabel {
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc] init];
        _incomeLabel.backgroundColor = kWhiteColor;
        _incomeLabel.textColor = kBlackColor;
        _incomeLabel.font = kFont12;
        _incomeLabel.textAlignment = NSTextAlignmentCenter;
        _incomeLabel.text = @"收入";
    }
    return _incomeLabel;
}

- (UILabel *)outputLabel {
    if (!_outputLabel) {
        _outputLabel = [[UILabel alloc] init];
        _outputLabel.backgroundColor = kWhiteColor;
        _outputLabel.textColor = kBlackColor;
        _outputLabel.font = kFont12;
        _outputLabel.textAlignment = NSTextAlignmentCenter;
        _outputLabel.text = @"支出";
    }
    return _outputLabel;
}

- (UILabel *)sumLabel {
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc] init];
        _sumLabel.backgroundColor = kWhiteColor;
        _sumLabel.textColor = kBlackColor;
        _sumLabel.font = kFont12;
        _sumLabel.textAlignment = NSTextAlignmentCenter;
        _sumLabel.text = @"结余";
    }
    return _sumLabel;
}
- (void)addMasonry {
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(10));
        make.centerY.mas_equalTo(0);
    }];
    [self.outputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.outputLabel.mas_left);
        make.left.mas_equalTo(self.monthLabel.mas_right);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.outputLabel.mas_right).mas_offset(kIphone6Width(20));
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
}
@end
