//
//  UIViewController+PBGuide.m
//  PoliteBooks
//
//  Created by llk on 2019/6/17.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "UIViewController+PBGuide.h"
#import "XSpotLight.h"

@implementation UIViewController (PBGuide)

-(void)guidanceWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            [self setupHomeGudie];
            break;
        case 1:
            [self setupBookGudie];
            break;
        case 2:
            [self setupTableGudie];
            break;
        default:
            break;
    }
}
-(void)setupHomeGudie{
    XSpotLight *SpotLight = [[XSpotLight alloc]init];
    SpotLight.messageArray = @[@"查看账本列表",@"查看图表页面"];;
    SpotLight.rectArray = @[[NSValue valueWithCGRect:CGRectMake(kIphone6Width(30),kIphone6Width(60),kIphone6Width(50),kIphone6Width(50))],[NSValue valueWithCGRect:CGRectMake(ScreenWidth-30,kIphone6Width(60),kIphone6Width(50),kIphone6Width(50))]];;
    [self presentViewController:SpotLight animated:YES completion:^{
    }];
}
-(void)setupBookGudie{
    XSpotLight *SpotLight = [[XSpotLight alloc]init];
    SpotLight.messageArray = @[@"点击新建账本"];;
    SpotLight.rectArray = @[[NSValue valueWithCGRect:CGRectMake(ScreenWidth-30,kIphone6Width(60),kIphone6Width(50),kIphone6Width(50))]];;
    [self presentViewController:SpotLight animated:YES completion:^{
    }];
}
-(void)setupTableGudie{
    XSpotLight *SpotLight = [[XSpotLight alloc]init];
    SpotLight.messageArray = @[@"点击新建账单"];;
    SpotLight.rectArray = @[[NSValue valueWithCGRect:CGRectMake(ScreenWidth-30,kIphone6Width(60),kIphone6Width(50),kIphone6Width(50))]];;
    [self presentViewController:SpotLight animated:YES completion:^{
    }];
}
@end
