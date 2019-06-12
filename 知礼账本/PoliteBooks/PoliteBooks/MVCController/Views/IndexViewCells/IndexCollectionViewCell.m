
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

/// 账本名称
@property (nonatomic, strong) UILabel *nameLabel;

/// 账本日期
@property (nonatomic, strong) UILabel *dateLabel;

/// 账本总和
@property (nonatomic, strong) UILabel *moneySum;



@end

@implementation IndexCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //阴影颜色
        
        [self.contentView addSubview:self.backpaperView];
        [self.backpaperView addSubview:self.nameLabel];
        [self.backpaperView addSubview:self.dateLabel];
        [self.backpaperView addSubview:self.moneySum];
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
    // 账本名称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(10));
        make.top.mas_equalTo(kIphone6Width(45));
        make.width.mas_equalTo(kIphone6Width(300));
        make.height.mas_equalTo(kIphone6Width(40));
    }];
    // 账本日期
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kIphone6Width(10));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(kIphone6Width(10));
    }];
    // 账本总和
    [self.moneySum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(25));
        make.bottom.mas_equalTo(-kIphone6Width(30));
        make.width.mas_equalTo(kIphone6Width(15));
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

- (UILabel *)moneySum {
    if (!_moneySum) {
        _moneySum = [[UILabel alloc] init];
        _moneySum.font = kPingFangSC_Semibold(13);
        _moneySum.textAlignment = NSTextAlignmentCenter;
        _moneySum.textColor = kWhiteColor;
        _moneySum.numberOfLines = 0;
    }
    return _moneySum;
}


-(void)setModel:(PBBookModel *)model{
    self.backpaperView.backgroundColor = TypeColor[model.bookColor];
    if (model.bookColor == 7) {
        self.nameLabel.textColor = kWhiteColor;
        self.dateLabel.textColor = kWhiteColor;
    }
    self.nameLabel.text = model.bookName;
    self.dateLabel.text = model.bookDate;
//    NSArray *personArr = [kDataBase jq_lookupTable:[NSString stringWithFormat:@"AccountBooks%@",model.bookName] dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",model.bookName];
//    if (personArr.count != 1) {
//        self.moneySum.hidden = NO;
//        NSInteger price = 0;
//        for (BooksModel * newModel in personArr) {
//            price += [newModel.money integerValue];
//        }
//        self.moneySum.text = [NSString stringWithFormat:@"总：%@",[[NSString stringWithFormat:@"%ld",price] getCnMoney]];
//    }else{
//        self.moneySum.hidden = YES;
//    }
    
}
@end
