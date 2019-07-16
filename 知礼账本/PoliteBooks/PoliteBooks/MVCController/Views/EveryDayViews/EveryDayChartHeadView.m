//
//  EveryDayChartHeadView.m
//  PoliteBooks
//
//  Created by llk on 2019/6/27.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "EveryDayChartHeadView.h"
@interface EveryDayChartHeadView()

@property(nonatomic,strong)SPMultipleSwitch * classTypeSwitch;


@end
@implementation EveryDayChartHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor_Main_Color;
        [self addSubview:self.classTypeSwitch];
    }
    return self;
}
-(SPMultipleSwitch *)classTypeSwitch{
    if (!_classTypeSwitch) {
        _classTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"周",@"月",@"年"]];
        _classTypeSwitch.frame = CGRectMake(kIphone6Width(10),   kIphone6Width(10), ScreenWidth-kIphone6Width(150), kIphone6Width(30));
        _classTypeSwitch.backgroundColor = kWhiteColor;
        _classTypeSwitch.selectedTitleColor = kWhiteColor;
        _classTypeSwitch.titleColor = kHexRGB(0x665757);
        _classTypeSwitch.trackerColor = kBlackColor;
        _classTypeSwitch.contentInset = 5;
        _classTypeSwitch.spacing = 10;
        _classTypeSwitch.titleFont = kFont14;
        //        _relationTypeSwitch.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        //        _relationTypeSwitch.layer.borderColor = kHexRGB(0x665757).CGColor;
        [_classTypeSwitch addTarget:self action:@selector(classTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classTypeSwitch;
}
-(void)classTypeSwitchAction:(SPMultipleSwitch *)swit{
    if (self.everyDayChartHeadViewSegementSelectBlock) {
        self.everyDayChartHeadViewSegementSelectBlock(swit.selectedSegmentIndex);
    }
}
-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex= selectIndex;
    self.classTypeSwitch.selectedSegmentIndex = 0;
}
@end
