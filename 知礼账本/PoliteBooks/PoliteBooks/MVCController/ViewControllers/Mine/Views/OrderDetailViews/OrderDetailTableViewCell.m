//
//  OrderDetailTableViewCell.m
//  Buauty
//
//  Created by llk on 2019/7/16.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@interface OrderDetailTableViewCell ()

@property (nonatomic, strong) UILabel *monthLabel;

@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *outputLabel;

@property (nonatomic, strong) UILabel *sumLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation OrderDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.monthLabel];
        [self.contentView addSubview:self.incomeLabel];
        [self.contentView addSubview:self.outputLabel];
        [self.contentView addSubview:self.sumLabel];
        [self.contentView addSubview:self.lineView];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Private Methods
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
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - # Getter
- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.backgroundColor = kWhiteColor;
        _monthLabel.textColor = kBlackColor;
        _monthLabel.font = kFont12;
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.text = @"结余";
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
        _incomeLabel.text = @"100";
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
        _outputLabel.text = @"100";
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
        _sumLabel.text = @"100";
    }
    return _sumLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}
-(void)setOrderDataSource:(NSMutableArray<PBWatherModel *> *)orderDataSource{
    _orderDataSource = orderDataSource;
    CGFloat incomeMoney = 0.0;
    CGFloat outMoney = 0.0;
    CGFloat sumMoney = 0.0;
    for (PBWatherModel * model in orderDataSource) {
        if (model.moneyType) {
            incomeMoney += [model.price floatValue];
        }else{
            outMoney += [model.price floatValue];
        }
        self.monthLabel.text = [NSString stringWithFormat:@"%ld月",model.month];

    }
    sumMoney = incomeMoney - outMoney;
    NSString * outStr = [NSString stringWithFormat:@"%.2f元",outMoney];
    NSString * incomeStr= [NSString stringWithFormat:@"%.2f元",incomeMoney];
    NSString * sumStr = [NSString stringWithFormat:@"%.2f元",sumMoney];
    [self.incomeLabel setAttributedText:[NSAttributedString createMath:incomeStr integer:kMBFont14 decimal:kMBFont12]];
    [self.outputLabel setAttributedText:[NSAttributedString createMath:outStr integer:kMBFont14 decimal:kMBFont12]];
    [self.sumLabel setAttributedText:[NSAttributedString createMath:sumStr integer:kMBFont14 decimal:kMBFont12]];
}
@end
