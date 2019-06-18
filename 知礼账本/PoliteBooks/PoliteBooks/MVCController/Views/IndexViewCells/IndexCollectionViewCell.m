
//
//  IndexCollectionViewCell.m
//  Buauty
//
//  Created by llk on 2019/1/11.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "IndexCollectionViewCell.h"

@interface IndexCollectionViewCell ()

/// 背景图片
@property (nonatomic, strong) UIImageView *backpaperView;

/// 账簿名称
@property (nonatomic, strong) UILabel *nameLabel;

/// 账簿日期
@property (nonatomic, strong) UILabel *dateLabel;

/// 出账
@property (nonatomic, strong) UILabel *outTypeLabel;

/// 进账
@property (nonatomic, strong) UILabel *inTypeLabel;

@end

@implementation IndexCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //阴影颜色
        
        [self.contentView addSubview:self.backpaperView];
        [self.backpaperView addSubview:self.nameLabel];
        [self.backpaperView addSubview:self.dateLabel];
        [self.backpaperView addSubview:self.outTypeLabel];
        [self.backpaperView addSubview:self.inTypeLabel];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)addMasonry {
    // 背景图片
    [self.backpaperView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.mas_equalTo(0);
        make.left.top.mas_equalTo(kIphone6Width(10));
        make.right.bottom.mas_equalTo(kIphone6Width(-10));
    }];
    // 账簿名称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(10));
        make.top.mas_equalTo(kIphone6Width(45));
        make.width.mas_equalTo(kIphone6Width(300));
        make.height.mas_equalTo(kIphone6Width(40));
    }];
    // 账簿日期
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(10));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(kIphone6Width(10));
    }];
    [self.outTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(10));
        make.width.mas_equalTo(20);
        make.top.mas_equalTo(self.dateLabel.mas_bottom).offset(kIphone6Width(10));
    }];
    [self.inTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(50));
       make.width.mas_equalTo(20); make.top.mas_equalTo(self.dateLabel.mas_bottom).offset(kIphone6Width(10));
    }];
    
}

#pragma mark - # Getter
- (UIImageView *)backpaperView {
    if (!_backpaperView) {
        _backpaperView = [[UIImageView alloc] init];
        _backpaperView.contentMode = UIViewContentModeScaleAspectFill;
        _backpaperView.layer.cornerRadius = kIphone6Width(20);
        _backpaperView.clipsToBounds = YES;
        _backpaperView.layer.shadowColor = kHexRGB(0xC9AF99).CGColor;
        _backpaperView.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
        _backpaperView.layer.shadowOpacity = 3.5;
        _backpaperView.layer.shadowRadius = 2.0;
        _backpaperView.layer.masksToBounds = YES;
    }
    return _backpaperView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kPingFangSC_Regular(41);
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.textColor = kWhiteColor;
    }
    return _nameLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = kPingFangSC_Regular(13);
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.textColor = kWhiteColor;
    }
    return _dateLabel;
}

-(UILabel *)outTypeLabel{
    if (!_outTypeLabel) {
        _outTypeLabel = [[UILabel alloc] init];
        _outTypeLabel.font = kFont14;
        _outTypeLabel.textColor = kWhiteColor;
        _outTypeLabel.textAlignment = NSTextAlignmentCenter;
        _outTypeLabel.text = @"進禮";
        _outTypeLabel.hidden = YES;
        _outTypeLabel.numberOfLines = 0;
    }
    return _outTypeLabel;
}
-(UILabel *)inTypeLabel{
    if (!_inTypeLabel) {
        _inTypeLabel = [[UILabel alloc] init];
        _inTypeLabel.font = kFont14;
        _inTypeLabel.textColor = kWhiteColor;
        _inTypeLabel.textAlignment = NSTextAlignmentCenter;
        _inTypeLabel.text = @"收禮";
        _inTypeLabel.hidden = YES;
        _inTypeLabel.numberOfLines = 0;
    }
    return _inTypeLabel;
}


-(void)setModel:(PBBookModel *)model{
    self.backpaperView.backgroundColor = TypeColor[model.bookColor];
    if (model.bookColor == 7) {
        self.nameLabel.textColor = kWhiteColor;
        self.dateLabel.textColor = kWhiteColor;
    }
    self.nameLabel.text = model.bookName;
    self.dateLabel.text = model.bookDate;
    
    if (model.bookOutMoney) {
        self.inTypeLabel.text = [NSString stringWithFormat:@"進禮 .. %@",[[NSString stringWithFormat:@"%ld",model.bookOutMoney] getCnMoney]];
        self.inTypeLabel.hidden = NO;
    }else{
        self.inTypeLabel.hidden = YES;
    }
    if (model.bookInMoney) {
        self.outTypeLabel.text = [NSString stringWithFormat:@"收禮 .. %@",[[NSString stringWithFormat:@"%ld",model.bookInMoney] getCnMoney]];
        self.outTypeLabel.hidden = NO;
    }else{
        self.outTypeLabel.hidden = YES;
    }
}
@end
