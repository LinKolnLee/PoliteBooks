//
//  AboutCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/6/20.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "AboutCollectionViewCell.h"
@interface AboutCollectionViewCell()

@property(nonatomic,strong)UIImageView * abImageView;


@end
@implementation AboutCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //阴影颜色
        [self.contentView addSubview:self.abImageView];
        
    }
    return self;
}
-(UIImageView *)abImageView{
    if (!_abImageView) {
        _abImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _abImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _abImageView;
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.abImageView.image = [UIImage imageNamed:imageName];
}
@end
