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
@end

@implementation AccentDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self.contentView addSubview:self.typeButton];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.moneyLabel];
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
    self.nameLabel.text = TypeClassStr[model.type];
    [self.typeButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classImage_%ld",(long)model.type]] forState:UIControlStateNormal];
    if (model.moneyType) {
        self.moneyLabel.text = [NSString stringWithFormat:@"+%@",model.price];
    }else{
        self.moneyLabel.text = [NSString stringWithFormat:@"-%@",model.price];
    }
    
}
@end
