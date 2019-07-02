//
//  ToolCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/7/1.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ToolCollectionViewCell.h"
@interface ToolCollectionViewCell()

@property(nonatomic,strong)UIButton * iconBtn;

@property(nonatomic,strong)UILabel * titleLabel;

@property(nonatomic,strong)UILabel * typeLabel;
@end
@implementation ToolCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.typeLabel];
        [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kIphone6Width(10));
            make.centerX.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.top.mas_equalTo(self.iconBtn.mas_bottom).offset(kIphone6Width(5));
            make.left.mas_equalTo(kIphone6Width(10));
            make.right.mas_equalTo(-kIphone6Width(10));
        }];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kIphone6Width(5));
            make.left.mas_equalTo(kIphone6Width(10));
            make.right.mas_equalTo(-kIphone6Width(10));
        }];
        
    }
    return self;
}
-(UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_iconBtn addTarget:self action:@selector(iconBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _iconBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont13;
        _titleLabel.textColor = kColor_Loding;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = kFont13;
        _typeLabel.textColor = kColor_Loding;
        _typeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLabel;
}
-(void)iconBtnTouchUpInside:(UIButton *)sender{
//    if (self.keepAccountCollectionViewCellBtnSelectBlock) {
//        self.keepAccountCollectionViewCellBtnSelectBlock(self.row);
//    }
}
-(void)setModel:(PBQuickModel *)model{
    _model = model;
    if (model.moneyType) {
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString *filePath = [resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"inComeClass_%ld.png",(long)model.type]];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [self.iconBtn setImage:image forState:UIControlStateNormal];
        self.titleLabel.text = [NSString stringWithFormat:@"%@_%@元",IncomeClassStr[model.type],model.price];
    }else{
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString *filePath = [resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"classImage_%ld.png",(long)model.type]];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [self.iconBtn setImage:image forState:UIControlStateNormal];
        self.titleLabel.text = [NSString stringWithFormat:@"%@_%@元",TypeClassStr[model.type],model.price];
    }
    
    self.typeLabel.text = model.moneyType == 0 ? @"支出" : @"收入";
    self.backgroundColor = model.moneyType == 0 ? TypeColor[2] : TypeColor[3];
}
@end
