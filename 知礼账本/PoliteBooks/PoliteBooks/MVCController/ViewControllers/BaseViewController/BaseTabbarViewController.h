//
//  BaseTabbarViewController.h
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcAE_TabBar.h"
#import "TestTabBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTabbarViewController : UITabBarController
@property (nonatomic, strong) AxcAE_TabBar *axcTabBar;

@end

NS_ASSUME_NONNULL_END
