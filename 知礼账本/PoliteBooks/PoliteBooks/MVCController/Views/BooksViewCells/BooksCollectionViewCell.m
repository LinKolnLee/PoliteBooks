//
//  BooksCollectionViewCell.m
//  Buauty
//
//  Created by llk on 2019/1/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BooksCollectionViewCell.h"
#import "TranslationMicTipView.h"

@interface BooksCollectionViewCell ()
@property(nonatomic,strong)TranslationMicTipView * micTipView;

/// 图片
@property (nonatomic, strong) UIImageView *bgImageView;

/// 日期
@property (nonatomic, strong) UILabel *nameLabel;

/// 出账
@property (nonatomic, strong) UILabel *outTypeLabel;

/// 进账
@property (nonatomic, strong) UILabel *inTypeLabel;
@end

@implementation BooksCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bgImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.outTypeLabel];
        [self.contentView addSubview:self.inTypeLabel];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)addMasonry {
    // 图片
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(kIphone6Width(30));
    }];
    [self.outTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(10));
    make.bottom.mas_equalTo(self.inTypeLabel.mas_top).offset(kIphone6Width(-5));
    }];
    [self.inTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(10));
        make.bottom.mas_equalTo(-2);
    }];
}

#pragma mark - # Getter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        //_bgImageView.image = [UIImage imageNamed:@"backImage2"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.layer.cornerRadius = kIphone6Width(5);
        _bgImageView.clipsToBounds = YES;
        _bgImageView.layer.shadowColor = kHexRGB(0xC9AF99).CGColor;
        _bgImageView.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
        _bgImageView.layer.shadowOpacity = 3.5;
        _bgImageView.layer.shadowRadius = 2.0;
        _bgImageView.layer.masksToBounds = YES;
    }
    return _bgImageView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFont12;
        _nameLabel.textColor = kWhiteColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"出账";
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
-(UILabel *)outTypeLabel{
    if (!_outTypeLabel) {
        _outTypeLabel = [[UILabel alloc] init];
        _outTypeLabel.font = kFont7;
        _outTypeLabel.textColor = kWhiteColor;
        _outTypeLabel.textAlignment = NSTextAlignmentCenter;
        _outTypeLabel.text = @"进礼";
        _outTypeLabel.hidden = YES;
        _outTypeLabel.numberOfLines = 0;
    }
    return _outTypeLabel;
}
-(UILabel *)inTypeLabel{
    if (!_inTypeLabel) {
        _inTypeLabel = [[UILabel alloc] init];
        _inTypeLabel.font = kFont7;
        _inTypeLabel.textColor = kWhiteColor;
        _inTypeLabel.textAlignment = NSTextAlignmentCenter;
        _inTypeLabel.text = @"收礼";
        _inTypeLabel.hidden = YES;
        _inTypeLabel.numberOfLines = 0;
    }
    return _inTypeLabel;
}


-(void)setBookModel:(PBBookModel *)bookModel{
    self.bgImageView.backgroundColor = TypeColor[bookModel.bookColor];
    if (bookModel.bookColor == 7) {
        self.nameLabel.textColor = kWhiteColor;
    }
    self.nameLabel.text = bookModel.bookName;
    if (bookModel.bookOutMoney) {
        self.inTypeLabel.text = [NSString stringWithFormat:@"进礼 : %@",[[NSString stringWithFormat:@"%ld",bookModel.bookOutMoney] getCnMoney]];
        self.inTypeLabel.hidden = NO;
    }else{
        self.inTypeLabel.hidden = YES;
    }
    if (bookModel.bookInMoney) {
        self.outTypeLabel.text = [NSString stringWithFormat:@"收礼 : %@",[[NSString stringWithFormat:@"%ld",bookModel.bookInMoney] getCnMoney]];
        self.outTypeLabel.hidden = NO;
    }else{
        self.outTypeLabel.hidden = YES;
    }
}

@end
