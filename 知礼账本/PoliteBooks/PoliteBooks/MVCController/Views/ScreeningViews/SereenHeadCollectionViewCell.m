//
//  SereenHeadCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/7/3.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "SereenHeadCollectionViewCell.h"
@interface SereenHeadCollectionViewCell()

@property(nonatomic,strong)UILabel * dTextLabel;

@end
@implementation SereenHeadCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.dTextLabel];
        [self addMasonry];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)addMasonry {
    [self.dTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - # Getter
- (UILabel *)dTextLabel {
    if (!_dTextLabel) {
        _dTextLabel = [[UILabel alloc] init];
        _dTextLabel.textAlignment = NSTextAlignmentCenter;
        _dTextLabel.textColor = kBlackColor;
        _dTextLabel.backgroundColor = kWhiteColor;
        _dTextLabel.font = kPingFangSC_Regular(12);
    }
    return _dTextLabel;
}
#pragma mark — 实现自适应文字宽度的关键步骤:item的layoutAttributes
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    UICollectionViewLayoutAttributes * attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    UIFont * font = kPingFangSC_Regular(12);
    CGRect rect = [self.dTextLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    rect.size.width += kIphone6Width(10);
    rect.size.height += kIphone6Width(10);
    attributes.frame = rect;
    return attributes;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.dTextLabel.text = title;
}
-(void)setSelect:(BOOL)select{
    _select = select;
    if (select) {
        self.dTextLabel.backgroundColor =kBlackColor;
        self.dTextLabel.textColor = kWhiteColor;
    }else{
        self.dTextLabel.backgroundColor = kWhiteColor;
        self.dTextLabel.textColor = kBlackColor;
    }
}
@end
