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

@interface AppDelegate ()

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
    } else {}
    if(self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self setup3DTouch];
    }
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
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"1" localizedTitle:@"记一笔" localizedSubtitle:@"快速记账" icon:icon1 userInfo:nil];
     [[UIApplication sharedApplication] setShortcutItems:@[item1]];
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
