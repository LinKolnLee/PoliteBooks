//
//  AppDelegate.m
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "NewTabbarViewController.h"
#import "BaseNavigationController.h"
#import "KeepAccountViewController.h"
#import "ToolViewController.h"
@interface AppDelegate ()<WXApiDelegate>
@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [Bmob registerWithAppKey:kBmobAppkey];
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 11.0, *)) {
        
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].showsVerticalScrollIndicator =NO;
        [UICollectionView appearance].showsVerticalScrollIndicator =NO;
    } else {}
    if(self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self setup3DTouch];
    }
    [WXApi registerApp:@"wx35c4040cd67b3568"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [UserColorConfiguration initUserColorsInFirstboot];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NewTabbarViewController * tab = [[NewTabbarViewController alloc] init];
    BaseNavigationController * navi = [[BaseNavigationController alloc] initWithRootViewController:tab];
    self.window.rootViewController = navi;
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enableAutoToolbar = NO;
    keyboardManager.shouldResignOnTouchOutside = YES;
    BmobUser *bUser = [BmobUser currentUser];
    if (!bUser) {
        [UserManager showUserLoginView];
    }
    return YES;
}

-(void)setup3DTouch{
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"NewEdit"];
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"1" localizedTitle:@"记一笔" localizedSubtitle:@"记一笔" icon:icon1 userInfo:nil];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"message_normal"];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"2" localizedTitle:@"快速记账" localizedSubtitle:@"快速记账" icon:icon2 userInfo:nil];
     [[UIApplication sharedApplication] setShortcutItems:@[item1,item2]];
}
#pragma mark -  通过快捷选项进入app的时候会调用该方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    
    
    //1.获得shortcutItem的type type就是初始化shortcutItem的时候传入的唯一标识符
    NSString *type = shortcutItem.type;
    //2.可以通过type来判断点击的是哪一个快捷按钮 并进行每个按钮相应的点击事件
    if ([type isEqualToString:@"1"]) {
        KeepAccountViewController *vc = [[KeepAccountViewController alloc] init];
        [(UINavigationController *)self.window.rootViewController pushViewController:vc animated:YES];
    }else if ([type isEqualToString:@"2"]){
        ToolViewController *vc = [[ToolViewController alloc] init];
        [(UINavigationController *)self.window.rootViewController pushViewController:vc animated:YES];
    }
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}
- (void)onResp:(BaseResp *)resp{
    /*
     WXSuccess           = 0,   成功
     WXErrCodeCommon     = -1,   普通错误类型
     WXErrCodeUserCancel = -2,   用户点击取消并返回
     WXErrCodeSentFail   = -3,    发送失败
     WXErrCodeAuthDeny   = -4,   授权失败
     WXErrCodeUnsupport  = -5,    微信不支持
     */
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]){
        // 判断errCode 进行回调处理
        if (resp.errCode == 0){
            NSLog(@"分享成功");
        }
    }

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
