//
//  DetailOtherCollectionViewCell.m
//  Buauty
//
//  Created by llk on 2019/7/18.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "DetailOtherCollectionViewCell.h"

@interface DetailOtherCollectionViewCell ()

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *outputLabel;

@property (nonatomic, strong) UILabel *classLabel;

@end

@implementation DetailOtherCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.incomeLabel];
        [self.contentView addSubview:self.outputLabel];
        [self.contentView addSubview:self.classLabel];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)addMasonry {
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.mas_equalTo(0);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(0);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(0);
    }];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-20);
        make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(kIphone6Width(25));
        make.width.mas_equalTo(kIphone6Width(45));
    }];
    [self.outputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(20);
        make.top.mas_equalTo(self.incomeLabel);
        make.height.mas_equalTo(kIphone6Width(25));
        make.width.mas_equalTo(kIphone6Width(45));
    }];
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(65));
    }];
}

#pragma mark - # Getter
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = kMBFont12;
        _typeLabel.textColor = kBlackColor;
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.text = @"同学";
    }
    return _typeLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kMBFont14;
        _nameLabel.textColor = kBlackColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"李白";
    }
    return _nameLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = kMBFont18;
        _moneyLabel.textColor = kBlackColor;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.text = @"壹佰伍拾元";
    }
    return _moneyLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = kMBFont11;
        _dateLabel.textColor = kHexRGB(0x3d3d4f);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = @"貳零壹玖年一月";
    }
    return _dateLabel;
}

- (UILabel *)incomeLabel {
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc] init];
        _incomeLabel.font = kMBFont14;
        _incomeLabel.textColor = kHexRGB(0x3d3d4f);
        _incomeLabel.backgroundColor = kHexRGB(0x7bcfa6);
        _incomeLabel.textAlignment = NSTextAlignmentCenter;
        _incomeLabel.text = @"收礼";
        _incomeLabel.hidden = YES;
        _incomeLabel.layer.cornerRadius = kIphone6Width(12.5);
        _incomeLabel.clipsToBounds = YES;
    }
    return _incomeLabel;
}

- (UILabel *)outputLabel {
    if (!_outputLabel) {
        _outputLabel = [[UILabel alloc] init];
        _outputLabel.font = kMBFont14;
        _outputLabel.textColor = kWhiteColor;
        //_outTypeLabel.backgroundColor =
        _outputLabel.textAlignment = NSTextAlignmentCenter;
        _outputLabel.text = @"进礼";
        _outputLabel.layer.cornerRadius = kIphone6Width(12.5);
        _outputLabel.clipsToBounds = YES;
        _outputLabel.hidden = YES;
    }
    return _outputLabel;
}

- (UILabel *)classLabel {
    if (!_classLabel) {
        _classLabel = [[UILabel alloc] init];
        _classLabel.backgroundColor = kHexRGB(0xA20115);
        _classLabel.text = @"结婚";
        _classLabel.textColor = kWhiteColor;
        _classLabel.font = kMBFont12;
        _classLabel.numberOfLines = 0;
        _classLabel.textAlignment = NSTextAlignmentCenter;
        _classLabel.layer.cornerRadius = kIphone6Width(12.5);
        _classLabel.clipsToBounds = YES;
    }
    return _classLabel;
}
-(void)setModel:(PBTableModel *)model{
    _model = model;
    self.nameLabel.text = model.userName;
    self.classLabel.text = model.userType;
    NSArray * datas = [model.userDate componentsSeparatedByString:@"年"];
    NSArray * month = [datas[1] componentsSeparatedByString:@"月"];
    NSString * date = [NSString stringWithFormat:@"%@年%@月%@",datas[0],month[0],month[1]];
    self.dateLabel.text = date;
    //self.tableLabel.backgroundColor = TypeColor[model.tableType];
    if (model.inType) {
        self.outputLabel.hidden = NO;
    }else{
        self.outputLabel.hidden = YES;
    }
    if (model.outType) {
        self.incomeLabel.hidden = NO;
    }else{
        self.incomeLabel.hidden = YES;
    }
    self.outputLabel.backgroundColor = TypeColor[model.bookColor];
    self.classLabel.backgroundColor = TypeColor[model.bookColor];
    
    NSString * moneyStr =[NSString stringWithFormat:@"%@整",[model.userMoney getCnMoney]];
    self.moneyLabel.text = moneyStr;
    if (moneyStr.length > 4) {
        self.moneyLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(18 - (moneyStr.length - 2) )];
    }
    self.typeLabel.text = model.userRelation;
    self.typeLabel.textColor = TypeColor[model.bookColor];
}
@end
