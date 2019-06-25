//
//  KeepAccountCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "KeepAccountCollectionViewCell.h"
@interface KeepAccountCollectionViewCell()

@property(nonatomic,strong)UIButton * iconBtn;
@property(nonatomic,strong)UILabel * titleLabel;

@end
@implementation KeepAccountCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kIphone6Width(20));
            make.top.mas_equalTo(kIphone6Width(5));
            make.right.mas_equalTo(-kIphone6Width(20));
            make.bottom.mas_equalTo(-kIphone6Width(20));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kIphone6Width(10));
            make.right.mas_equalTo(-kIphone6Width(10));
            make.top.mas_equalTo(self.iconBtn.mas_bottom).offset(kIphone6Width(5));
        }];
        
    }
    return self;
}
-(UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconBtn addTarget:self action:@selector(iconBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _iconBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont13;
        _titleLabel.textColor = kHexRGB(0x3f3f4d);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(void)iconBtnTouchUpInside:(UIButton *)sender{
    if (self.keepAccountCollectionViewCellBtnSelectBlock) {
        self.keepAccountCollectionViewCellBtnSelectBlock(self.row);
    }
}
-(void)setRow:(NSInteger)row{
    _row = row;
    //[_iconBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classImage_%ld",(long)row]] forState:UIControlStateNormal];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"classImage_%ld.png",(long)row]];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    [_iconBtn setImage:image forState:UIControlStateNormal];
        self.titleLabel.text = TypeClassStr[row];
}
@end
