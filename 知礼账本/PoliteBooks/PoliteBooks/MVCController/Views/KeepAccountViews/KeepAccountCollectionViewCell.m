//
//  KeepAccountCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "KeepAccountCollectionViewCell.h"
@interface KeepAccountCollectionViewCell()

@property(nonatomic,strong)UIImageView * iconView;
@property(nonatomic,strong)UILabel * titleLabel;

@end
@implementation KeepAccountCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kIphone6Width(20));
            make.top.mas_equalTo(kIphone6Width(5));
            make.right.mas_equalTo(-kIphone6Width(20));
            make.bottom.mas_equalTo(-kIphone6Width(20));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kIphone6Width(10));
            make.right.mas_equalTo(-kIphone6Width(10));
            make.top.mas_equalTo(self.iconView.mas_bottom).offset(kIphone6Width(5));
        }];
        
    }
    return self;
}
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _iconView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kMBFont13;
        _titleLabel.textColor = kColor_Loding;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(void)setRow:(NSInteger)row{
    _row = row;
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"nclassImage_%ld.png",(long)row]];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    _iconView.image = image;
    self.titleLabel.text = TypeClassStr[row];
}
-(void)setSection:(NSInteger)section{
    _section = section;
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"inComeClass_%ld.png",(long)section]];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    _iconView.image = image;
    self.titleLabel.text = IncomeClassStr[section];
}
@end
