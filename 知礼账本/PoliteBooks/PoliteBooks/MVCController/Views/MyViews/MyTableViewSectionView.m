//
//  MyTableViewSectionView.m
//  PoliteBooks
//
//  Created by llk on 2019/7/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "MyTableViewSectionView.h"
@interface MyTableViewSectionView()
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *outLabel;

@property (nonatomic, strong) UILabel *sumLabel;

@property(nonatomic,strong)UIButton * gotoBtn;

@end
@implementation MyTableViewSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.gotoBtn];
        [self addSubview:self.dateLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.incomeLabel];
        [self addSubview:self.outLabel];
        [self addSubview:self.sumLabel];
        [self addMasonry];
        self.contentView.backgroundColor = kWhiteColor;
    }
    return self;
}
#pragma mark - # Private Methods
- (void)addMasonry {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(20));
        make.top.mas_equalTo(kIphone6Width(10));
    }];
    [self.gotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(10));
        make.top.mas_equalTo(kIphone6Width(10));
        make.width.height.mas_equalTo(kIphone6Width(25));
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(20));
        make.bottom.mas_equalTo(-kIphone6Width(15));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLabel.mas_right).mas_offset(kIphone6Width(30));
        make.top.mas_equalTo(self.dateLabel);
        make.bottom.mas_equalTo(self.dateLabel);
        make.width.mas_equalTo(1);
    }];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_right).mas_offset(kIphone6Width(30));
        make.centerY.mas_equalTo(self.lineView);
    }];
    [self.outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.incomeLabel.mas_right).mas_offset(kIphone6Width(30));
        make.centerY.mas_equalTo(self.lineView);
    }];
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.outLabel.mas_right).mas_offset(kIphone6Width(30));
        make.centerY.mas_equalTo(self.outLabel);
    }];
}

#pragma mark - # Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont14;
        _titleLabel.textColor = kBlackColor;
        _titleLabel.text = @"账单";
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = kFont18;
        _dateLabel.textColor = kBlackColor;
        NSString * monthStr = [NSString stringWithFormat:@"%ld月",[[NSDate new] month]];
        NSMutableAttributedString *numString = [[NSMutableAttributedString alloc] initWithString:monthStr];
        NSRange ran = NSMakeRange(numString.length - 1, 1);
        [numString addAttribute:NSFontAttributeName value:kFont11 range:ran];
        _dateLabel.attributedText=numString;
    }
    return _dateLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kBlackColor;
    }
    return _lineView;
}
-(UIButton *)gotoBtn{
    if (!_gotoBtn) {
        _gotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoBtn.hidden = YES;
        [_gotoBtn setImage:[UIImage imageNamed:@"rightDateImage"] forState:UIControlStateNormal];
        [_gotoBtn addTarget:self action:@selector(gotoBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoBtn;
}
- (UILabel *)incomeLabel {
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc] init];
        _incomeLabel.font = kFont14;
        _incomeLabel.textColor = kBlackColor;
        _incomeLabel.text = @"收入\r0元";
        _incomeLabel.textAlignment = NSTextAlignmentCenter;
        _incomeLabel.numberOfLines = 0;
    }
    return _incomeLabel;
}

- (UILabel *)outLabel {
    if (!_outLabel) {
        _outLabel = [[UILabel alloc] init];
        _outLabel.font = kFont14;
        _outLabel.textColor = kBlackColor;
        _outLabel.text = @"支出\r0元";
        _outLabel.textAlignment = NSTextAlignmentCenter;
        _outLabel.numberOfLines = 0;
    }
    return _outLabel;
}

- (UILabel *)sumLabel {
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc] init];
        _sumLabel.font = kFont14;
        _sumLabel.textColor = kBlackColor;
        _sumLabel.text = @"结余\r0元";
        _sumLabel.textAlignment = NSTextAlignmentCenter;
        _sumLabel.numberOfLines = 0;
    }
    return _sumLabel;
}
-(void)setModel:(NSMutableArray<PBWatherModel *> *)model{
    _model = model;
    CGFloat incomeMoney = 0.0;
    CGFloat outMoney = 0.0;
    CGFloat sumMoney = 0.0;
    for (PBWatherModel * model in _model) {
        if (model.moneyType) {
            incomeMoney += [model.price floatValue];
        }else{
            outMoney += [model.price floatValue];
        }
    }
    sumMoney = incomeMoney - outMoney;
    NSString * outStr = [NSString stringWithFormat:@"支出\r%.2f元",outMoney];
    NSString * incomeStr= [NSString stringWithFormat:@"收入\r%.2f元",incomeMoney];
    NSString * sumStr = [NSString stringWithFormat:@"结余\r%.2f元",sumMoney];
    [self.incomeLabel setAttributedText:[NSAttributedString createMath:incomeStr integer:kFont14 decimal:kFont12]];
    [self.outLabel setAttributedText:[NSAttributedString createMath:outStr integer:kFont14 decimal:kFont12]];
    [self.sumLabel setAttributedText:[NSAttributedString createMath:sumStr integer:kFont14 decimal:kFont12]];
}
-(void)gotoBtnTouchUpInside:(UIButton *)sender{
    if (self.myTableViewSectionViewGotoButtonBlock) {
        self.myTableViewSectionViewGotoButtonBlock();
    }
}
@end
