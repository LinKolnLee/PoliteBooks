//
//  PBIndexNavigationBarView.h
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBIndexNavigationBarView : UIView

/**
 左边按钮图片
 */
@property(nonatomic,strong)NSString * leftImage;

/**
 右边按钮图片
 */
@property(nonatomic,strong)NSString * rightImage;

@property(nonatomic,assign)BOOL rightHidden;

/**
 title
 */
@property(nonatomic,strong)NSString * title;

/**
 字体
 */
@property(nonatomic,strong)UIFont * titleFont;

/**
 左边按钮点击
 */
@property (copy , nonatomic) void(^PBIndexNavigationBarViewLeftButtonBlock)(void);

/**
 右边按钮点击
 */
@property (copy , nonatomic) void(^PBIndexNavigationBarViewRightButtonBlock)(void);

/**
 label点击
 */
@property (copy , nonatomic) void(^PBIndexNavigationBarViewTitleLabelBlock)(void);


@end

NS_ASSUME_NONNULL_END
