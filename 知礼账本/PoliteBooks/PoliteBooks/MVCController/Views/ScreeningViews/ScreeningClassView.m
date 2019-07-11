//
//  ScreeningClassView.m
//  PoliteBooks
//
//  Created by llk on 2019/7/3.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ScreeningClassView.h"
@interface ScreeningClassView()

@property(nonatomic,strong)UILabel * weekLabel;

@property(nonatomic,strong)UILabel * monthLabel;

@property(nonatomic,strong)UILabel *yearLabel;


@end
@implementation ScreeningClassView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.weekLabel];
        [self addSubview:self.monthLabel];
        [self addSubview:self.yearLabel];
        [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(kIphone6Width(15));
        }];
        [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kIphone6Width(15));
            make.top.mas_equalTo(self.weekLabel.mas_bottom).offset(kIphone6Width(40));
        }];
        [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kIphone6Width(15));
            make.top.mas_equalTo(self.monthLabel.mas_bottom).offset(kIphone6Width(40));
        }];
        //[self addSubview:self.collectionview];
        //self.backgroundColor = kBlackColor;
    }
    return self;
}
-(UILabel *)weekLabel{
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc] init];
        _weekLabel.textAlignment = NSTextAlignmentCenter;
        _weekLabel.textColor = kBlackColor;
        _weekLabel.backgroundColor = kWhiteColor;
        _weekLabel.font = kFont16;
    }
    return _weekLabel;
}
-(UILabel *)monthLabel{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.textColor = kBlackColor;
        _monthLabel.backgroundColor = kWhiteColor;
        _monthLabel.font = kFont16;
    }
    return _monthLabel;
}
-(UILabel *)yearLabel{
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] init];
        _yearLabel.textAlignment = NSTextAlignmentCenter;
        _yearLabel.textColor = kBlackColor;
        _yearLabel.backgroundColor = kWhiteColor;
        _yearLabel.font = kFont16;
    }
    return _yearLabel;
}
-(void)setWeekText:(NSString *)weekText{
    _weekText = weekText;
    self.weekLabel.text = [NSString stringWithFormat:@"您本周%@支出：%@元",self.typeText,weekText];
}
-(void)setMonthText:(NSString *)monthText{
    _monthText = monthText;
    self.monthLabel.text = [NSString stringWithFormat:@"您本月%@支出：%@元",self.typeText,monthText];
}
-(void)setYearText:(NSString *)yearText{
    _yearText = yearText;
    self.yearLabel.text = [NSString stringWithFormat:@"您本年%@支出：%@元",self.typeText,yearText];
}
-(void)setTypeText:(NSString *)typeText{
    _typeText = typeText;
}
@end
