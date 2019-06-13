//
//  BeautyLoadingHUD.m
//  Beauty
//
//  Created by llk on 2018/7/18.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import "BeautyLoadingHUD.h"

@implementation BeautyLoadingHUD
+ (BeautyLoadingHUD *)shareManager
{
    static BeautyLoadingHUD *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[BeautyLoadingHUD alloc]init];
        shareManager.loadView = [[BeautyLoadView alloc] initWithFrame:CGRectMake((ScreenWidth-kIphone6Width(100))/2, (ScreenHeight-kIphone6Width(40))/2, kIphone6Width(100), kIphone6Width(70))];
        [[self getCurrentVC].view addSubview:shareManager.loadView];
    });
    return shareManager;
}
-(void)startAnimating{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loadView startAnimating];
    });
}
- (void)startAnimatingWithMessage:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loadView startAnimatingWithMessage:message];
    });
}
//-(void)startAnimatingWithProgress:(CGFloat)value message:(NSString *)message{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.loadView startAnimatingWithProgress:value message:message];
//    });
//}
-(void)stopAnimating{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadView stopAnimating];
        });
    });
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
