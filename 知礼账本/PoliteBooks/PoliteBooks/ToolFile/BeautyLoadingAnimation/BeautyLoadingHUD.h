//
//  BeautyLoadingHUD.h
//  Beauty
//
//  Created by llk on 2018/7/18.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautyLoadView.h"
@interface BeautyLoadingHUD : UIView
+ (BeautyLoadingHUD *)shareManager;

@property (nonatomic,strong) BeautyLoadView * loadView;

- (void)startAnimating;

- (void)stopAnimating;

- (void)startAnimatingWithMessage:(NSString *)message;

//-(void)startAnimatingWithProgress:(CGFloat)value message:(NSString *)message;

@end
