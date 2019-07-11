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

/// 出账
@property (nonatomic, strong) UILabel *outTypeLabel;

/// 进账
@property (nonatomic, strong) UILabel *inTypeLabel;

///标签
@property (nonatomic, strong) UILabel *tableLabel;

@property (nonatomic, strong) UILabel *relationLabel;

/**
 标签线条
 */
@property(nonatomic,strong)UIView * lineView;
@end

@implementation DetailOrderCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.relationLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.outTypeLabel];
        [self.contentView addSubview:self.inTypeLabel];
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
        make.top.mas_equalTo(kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(20));
        make.height.mas_equalTo(kIphone6Width(80));
        make.centerX.mas_equalTo(0);
    }];
    [self.relationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.width.mas_equalTo(kIphone6Width(15));
        make.top.mas_equalTo(10);
    }];
    // 金额
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(kIphone6Width(0));
        make.width.mas_equalTo(kIphone6Width(20));
        make.height.mas_equalTo(kIphone6Width(150));
        make.centerX.mas_equalTo(0);
    }];
    // 日期
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).mas_offset(kIphone6Width(15));
        make.width.mas_equalTo(kIphone6Width(ScreenWidth/4 - 10));
        make.height.mas_equalTo(kIphone6Width(70));
        make.centerX.mas_equalTo(0);
    }];
    [self.outTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_offset(kIphone6Width(24));
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(45));
        make.left.mas_equalTo(15);
        
    }];
    [self.inTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_offset(kIphone6Width(24));
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(45));
        make.right.mas_equalTo(-15);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.tableLabel.mas_centerX);
        make.width.mas_equalTo(kIphone6Width(1));
        make.height.mas_equalTo(kIphone6Width(10));
    }];
    [self.tableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lineView.mas_top);
        make.width.mas_equalTo(kIphone6Width(25));
        make.height.mas_equalTo(kIphone6Width(65));
        make.centerX.mas_equalTo(0);
    }];
    
}

#pragma mark - # Getter
-(UILabel *)relationLabel{
    if (!_relationLabel) {
        _relationLabel = [[UILabel alloc] init];
        _relationLabel.font = kFont10;
        _relationLabel.textAlignment = NSTextAlignmentCenter;
        _relationLabel.text = @"朋友";
        _relationLabel.numberOfLines = 0;
    }
    return _relationLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFont14;
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
        _moneyLabel.font = kFont18;
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
        _dateLabel.textColor = kHexRGB(0x3d3d4f);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = @"貳零壹玖年一月";
        _dateLabel.numberOfLines = 0;
    }
    return _dateLabel;
}

-(UILabel *)outTypeLabel{
    if (!_outTypeLabel) {
        _outTypeLabel = [[UILabel alloc] init];
        _outTypeLabel.font = kFont14;
        _outTypeLabel.textColor = kWhiteColor;
        //_outTypeLabel.backgroundColor =
        _outTypeLabel.textAlignment = NSTextAlignmentCenter;
        _outTypeLabel.text = @"进礼";
        _outTypeLabel.layer.cornerRadius = kIphone6Width(12.5);
        _outTypeLabel.clipsToBounds = YES;
        _outTypeLabel.hidden = YES;
        _outTypeLabel.numberOfLines = 0;
    }
    return _outTypeLabel;
}
-(UILabel *)inTypeLabel{
    if (!_inTypeLabel) {
        _inTypeLabel = [[UILabel alloc] init];
        _inTypeLabel.font = kFont14;
        _inTypeLabel.textColor = kHexRGB(0x3d3d4f);
        _inTypeLabel.backgroundColor = kHexRGB(0x7bcfa6);
        _inTypeLabel.textAlignment = NSTextAlignmentCenter;
        _inTypeLabel.text = @"收礼";
        _inTypeLabel.hidden = YES;
        _inTypeLabel.layer.cornerRadius = kIphone6Width(12.5);
        _inTypeLabel.clipsToBounds = YES;
        _inTypeLabel.numberOfLines = 0;
    }
    return _inTypeLabel;
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
-(void)setModel:(PBTableModel *)model{
    _model = model;
    self.nameLabel.text = model.userName;
    self.tableLabel.text = model.userType;
    NSArray * datas = [model.userDate componentsSeparatedByString:@"年"];
    NSArray * month = [datas[1] componentsSeparatedByString:@"月"];
    NSString * date = [NSString stringWithFormat:@"%@年\r%@月\r%@",datas[0],month[0],month[1]];
    self.dateLabel.text = date;
    //self.tableLabel.backgroundColor = TypeColor[model.tableType];
    if (model.inType) {
        self.outTypeLabel.hidden = NO;
    }else{
        self.outTypeLabel.hidden = YES;
    }
    if (model.outType) {
        self.inTypeLabel.hidden = NO;
    }else{
        self.inTypeLabel.hidden = YES;
    }
    self.outTypeLabel.backgroundColor = TypeColor[model.bookColor];
    self.tableLabel.backgroundColor = TypeColor[model.bookColor];
    
    NSString * moneyStr =[NSString stringWithFormat:@"%@整",[model.userMoney getCnMoney]];
    self.moneyLabel.text = moneyStr;
    if (moneyStr.length > 4) {
        self.moneyLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(18 - (moneyStr.length - 2) )];
    }
   self.relationLabel.text = model.userRelation;
    self.relationLabel.textColor = TypeColor[model.bookColor];
}

@end
