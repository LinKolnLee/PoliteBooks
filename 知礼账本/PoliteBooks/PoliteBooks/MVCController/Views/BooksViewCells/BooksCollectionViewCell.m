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
@property (nonatomic, strong) UILabel *dataLabel;

/// 日期
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation BooksCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bgImageView];
        [self.contentView addSubview:self.dataLabel];
        [self.contentView addSubview:self.nameLabel];
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
    // 日期
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-kIphone6Width(5));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kIphone6Width(20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(kIphone6Width(30));
    }];
}

#pragma mark - # Getter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        //_bgImageView.image = [UIImage imageNamed:@"backImage2"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.layer.cornerRadius = kIphone6Width(10);
        _bgImageView.clipsToBounds = YES;
        _bgImageView.layer.shadowColor = kHexRGB(0xC9AF99).CGColor;
        _bgImageView.layer.shadowOffset = CGSizeMake(0, 5);//偏移距离
        _bgImageView.layer.shadowOpacity = 3.5;
        _bgImageView.layer.shadowRadius = 2.0;
        _bgImageView.layer.masksToBounds = YES;
    }
    return _bgImageView;
}

- (UILabel *)dataLabel {
    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.font = kFont12;
        _dataLabel.textColor = kWhiteColor;
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        _dataLabel.text = @"貳零壹玖年壹月";
        _dataLabel.numberOfLines = 0;
    }
    return _dataLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFont20;
        _nameLabel.textColor = kWhiteColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"出账";
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
-(void)setupTipViewWithCell{
    CGFloat popHeight =kIphone6Width(35.0);
    CGRect popRect = CGRectMake(0, kIphone6Width(0), kIphone6Width(140), popHeight);
    self.micTipView = [[TranslationMicTipView alloc] initWithFrame:popRect Title:@"选中长按删除账本"];
    self.micTipView.centerX = self.frame.size.width/2;
    self.micTipView.centerY = kIphone6Width(20);
    [self.contentView addSubview:self.micTipView];
    [self performSelector:@selector(hideTipView) withObject:nil afterDelay:3.0];
}
- (void)hideTipView {
    WS(weakSelf);
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.micTipView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.micTipView.hidden = YES;
    }];
}

-(void)setBookModel:(BooksModel *)bookModel{
    self.bgImageView.backgroundColor = TypeColor[bookModel.tableType];
    if (bookModel.tableType == 7) {
        self.nameLabel.textColor = kWhiteColor;
        self.dataLabel.textColor = kWhiteColor;
    }
    self.nameLabel.text = bookModel.bookName;
    self.dataLabel.text = bookModel.bookDate;
}
-(void)setIsShowTip:(BOOL)isShowTip{
    _isShowTip = isShowTip;
    [self setupTipViewWithCell];
}
@end
