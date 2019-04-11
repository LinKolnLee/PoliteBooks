//
//  DetailOrderCollectionViewCell.m
//  Buauty
//
//  Created by llk on 2019/1/11.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "DetailOrderCollectionViewCell.h"

@interface DetailOrderCollectionViewCell ()

/// 名字
@property (nonatomic, strong) UILabel *nameLabel;

/// 金额
@property (nonatomic, strong) UILabel *moneyLabel;

/// 日期
@property (nonatomic, strong) UILabel *dateLabel;

/// 是否本人
@property (nonatomic, strong) UIButton *selfButton;

///标签
@property (nonatomic, strong) UILabel *tableLabel;

/**
 标签线条
 */
@property(nonatomic,strong)UIView * lineView;
@end

@implementation DetailOrderCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.tableLabel];
        // [self.contentView addSubview:self.selfButton];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Event Response
- (void)selfButtonTouchUpInside:(UIButton *)sender {
    
}

#pragma mark - # Private Methods
- (void)addMasonry {
    // 名字
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kIphone6Width(15));
        make.width.mas_equalTo(kIphone6Width(20));
        make.height.mas_equalTo(kIphone6Width(70));
        make.centerX.mas_equalTo(0);
    }];
    // 金额
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(20));
        make.height.mas_equalTo(kIphone6Width(150));
        make.centerX.mas_equalTo(0);
    }];
    // 日期
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).mas_offset(kIphone6Width(10));
        make.width.mas_equalTo(kIphone6Width(20));
        make.bottom.mas_equalTo(self.tableLabel.mas_top).offset(kIphone6Width(-5));
        make.centerX.mas_equalTo(0);
    }];
   
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.tableLabel.mas_centerX);
        make.width.mas_equalTo(kIphone6Width(1));
        make.height.mas_equalTo(kIphone6Width(10));
    }];
    [self.tableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lineView.mas_top);
        make.width.mas_equalTo(kIphone6Width(20));
        make.height.mas_equalTo(kIphone6Width(50));
        make.centerX.mas_equalTo(0);
    }];
    // 是否本人
//    [self.selfButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.tableLabel.mas_top).mas_offset(-kIphone6Width(20));
//        make.width.mas_equalTo(kIphone6Width(25));
//        make.height.mas_equalTo(kIphone6Width(25));
//        make.centerX.mas_equalTo(0);
//    }];
}

#pragma mark - # Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFont15;
        _nameLabel.textColor = kBlackColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"李煮粥";
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = kFont21;
        _moneyLabel.textColor = kBlackColor;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.text = @"壹佰伍拾元";
        _moneyLabel.numberOfLines = 0;
    }
    return _moneyLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = kPingFangTC_Light(11);
        _dateLabel.textColor = kBlackColor;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = @"貳零壹玖年一月";
        _dateLabel.numberOfLines = 0;
    }
    return _dateLabel;
}

- (UIButton *)selfButton {
    if (!_selfButton) {
        _selfButton = [[UIButton alloc] init];
        [_selfButton setTitle:@"本" forState:UIControlStateNormal];
        [_selfButton setTitleColor:kHexRGB(0x841321) forState:UIControlStateNormal];
        _selfButton.backgroundColor = kBlackColor;
        _selfButton.titleLabel.font = kFont15;
        _selfButton.layer.cornerRadius = kIphone6Width(12.5);
        [_selfButton addTarget:self action:@selector(selfButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selfButton;
}

- (UILabel *)tableLabel {
    if (!_tableLabel) {
        _tableLabel = [[UILabel alloc] init];
        _tableLabel.backgroundColor = kHexRGB(0xA20115);
        _tableLabel.text = @"结婚";
        _tableLabel.textColor = kWhiteColor;
        _tableLabel.font = kFont12;
        _tableLabel.numberOfLines = 0;
        _tableLabel.textAlignment = NSTextAlignmentCenter;
        _tableLabel.layer.cornerRadius = kIphone6Width(12.5);
        _tableLabel.clipsToBounds = YES;
    }
    return _tableLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kBlackColor;
        
    }
    return _lineView;
}
-(void)setModel:(BooksModel *)model{
    _model = model;
    self.nameLabel.text = model.name;
    self.moneyLabel.text = [model.money getCnMoney];
    self.dateLabel.text = model.data;
    self.tableLabel.text = model.bookName;
    self.tableLabel.backgroundColor = TypeColor[model.tableType];
}
@end
