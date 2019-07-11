//
//  AccentDetailTableViewCell.m
//  Buauty
//
//  Created by llk on 2019/6/26.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "AccentDetailTableViewCell.h"

@interface AccentDetailTableViewCell ()

@property (nonatomic, strong) UIButton *typeButton;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation AccentDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self.contentView addSubview:self.typeButton];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.bottomLineView];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Event Response
- (void)typeButtonTouchUpInside:(UIButton *)sender {
    
}

#pragma mark - # Private Methods
- (void)addMasonry {
    
    [self.typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);;
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeButton.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.typeButton);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.nameLabel);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.moneyLabel.mas_left);
         make.centerY.mas_equalTo(self.nameLabel);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}


-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = kLineColor;
    }
    return _bottomLineView;
}
- (UIButton *)typeButton {
    if (!_typeButton) {
        _typeButton = [[UIButton alloc] init];
        [_typeButton addTarget:self action:@selector(typeButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _typeButton;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kBlackColor;
        _nameLabel.font = kFont14;
    }
    return _nameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = kBlackColor;
        _dateLabel.font = kFont11;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}
- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = kBlackColor;
        _moneyLabel.font = kFont14;
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}
-(void)setModel:(PBWatherModel *)model{
    _model = model;
    if (model.moneyType) {
        self.nameLabel.text = IncomeClassStr[model.type];
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString *filePath = [resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"sinComeClass_%ld.png",(long)model.type]];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [self.typeButton setImage:image forState:UIControlStateNormal];
        self.moneyLabel.text = [NSString stringWithFormat:@"+%@",model.price];
    }else{
        self.nameLabel.text = TypeClassStr[model.type];
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString *filePath = [resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"sclassImage_%ld.png",(long)model.type]];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [self.typeButton setImage:image forState:UIControlStateNormal];
        self.moneyLabel.text = [NSString stringWithFormat:@"-%@",model.price];
    }
}
-(void)setScreening:(BOOL)screening{
    _screening = screening;
    if (screening) {
         self.dateLabel.text = [NSString stringWithFormat:@"%ld/%ld/%ld/星期%ld",self.model.year,self.model.month,self.model.day,(long)self.model.week];
    }
}
@end
