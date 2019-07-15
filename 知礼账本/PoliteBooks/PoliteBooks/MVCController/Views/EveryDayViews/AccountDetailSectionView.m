//
//  AccountDetailSectionView.m
//  PoliteBooks
//
//  Created by llk on 2019/6/26.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "AccountDetailSectionView.h"
@interface AccountDetailSectionView()
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *moneySum;

@property (nonatomic, strong) UILabel *incomeMoneySum;

@property (nonatomic, strong) UIView *lineView;

@end
@implementation AccountDetailSectionView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
        {
            //self.contentView.backgroundColor = kwhi
            [self addSubview:self.dateLabel];
            [self addSubview:self.moneySum];
            [self addSubview:self.incomeMoneySum];
            [self addSubview:self.lineView];
            [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(10);
            }];
            [self.moneySum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(10);
            }];
            [self.incomeMoneySum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.moneySum.mas_left).offset(kIphone6Width(-10));
                make.top.mas_equalTo(10);
            }];
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_offset(10);
                make.height.mas_equalTo(1);
            }];
        }
    return self;
}

#pragma mark - # Getter
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = kBlackColor;
        _dateLabel.font = kFont14;
    }
    return _dateLabel;
}

- (UILabel *)moneySum {
    if (!_moneySum) {
        _moneySum = [[UILabel alloc] init];
        _moneySum.textColor = kBlackColor;
        _moneySum.font = kFont14;
        _moneySum.textAlignment = NSTextAlignmentRight;
    }
    return _moneySum;
}
- (UILabel *)incomeMoneySum {
    if (!_incomeMoneySum) {
        _incomeMoneySum = [[UILabel alloc] init];
        _incomeMoneySum.textColor = kBlackColor;
        _incomeMoneySum.font = kFont14;
        _incomeMoneySum.textAlignment = NSTextAlignmentRight;
        _incomeMoneySum.hidden = YES;
    }
    return _incomeMoneySum;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
        _lineView.hidden = YES;
    }
    return _lineView;
}
-(void)setModels:(NSMutableArray<PBWatherModel *> *)models{
    _models = models;
    PBWatherModel *newModel = models[0];
    self.dateLabel.text = [NSString stringWithFormat:@"%ld月%ld日  星期%ld",(long)newModel.month,(long)newModel.day,(long)newModel.week];
    CGFloat priceSum = 0.00;
    CGFloat incomeSum = 0.00;
    for (PBWatherModel * model in models) {
        if (model.moneyType) {
            incomeSum += [model.price doubleValue];
        }else{
            priceSum = priceSum + [model.price doubleValue];
        }
    }
    if (incomeSum != 0) {
        self.incomeMoneySum.hidden = NO;
        self.incomeMoneySum.text = [NSString stringWithFormat:@"收入 +%.2f",incomeSum];
    }else{
        self.incomeMoneySum.hidden = YES;
    }
    if (priceSum != 0) {
        self.moneySum.hidden = NO;
        self.moneySum.text = [NSString stringWithFormat:@"支出 -%.2f",priceSum];
    }else{
        self.moneySum.hidden = YES;
    }    
}
-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    switch (selectIndex) {
        case 1:
            {
                self.dateLabel.text = [NSString stringWithFormat:@"%ld周",(long)self.models[0].weekNum];
            }
            break;
        case 2:
        {
            self.dateLabel.text = [NSString stringWithFormat:@"%ld月",(long)self.models[0].month];
        }
            break;
        case 3:
        {
            self.dateLabel.text = [NSString stringWithFormat:@"%ld年",(long)self.models[0].year];
        }
            break;
            
        default:
            break;
    }
    if (self.moneySum.hidden) {
        [self.incomeMoneySum mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(kIphone6Width(-10));
            make.top.mas_equalTo(10);
        }];
    }else{
        [self.incomeMoneySum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.moneySum.mas_left).offset(kIphone6Width(-10));
            make.top.mas_equalTo(10);
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
