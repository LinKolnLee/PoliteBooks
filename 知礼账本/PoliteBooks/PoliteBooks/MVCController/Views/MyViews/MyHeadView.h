//
//  MyHeadView.h
//  PoliteBooks
//
//  Created by llk on 2019/7/1.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyHeadView : UIView

@property (copy , nonatomic) void(^myHeadViewBtnSelectBlock)(void);

@property(nonatomic,assign)BOOL login;

@property(nonatomic,assign)NSInteger watherNum;

@property(nonatomic,assign)NSInteger politeNum;

@end

NS_ASSUME_NONNULL_END
