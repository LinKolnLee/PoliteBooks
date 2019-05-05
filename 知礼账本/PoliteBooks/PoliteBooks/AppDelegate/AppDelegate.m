//
//  AppDelegate.m
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [UserColorConfiguration initUserColorsInFirstboot];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BaseNavigationController * navi = [[BaseNavigationController alloc] initWithRootViewController:[[IndexViewController alloc]init]];
    self.window.rootViewController = navi;
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enableAutoToolbar = NO;
    keyboardManager.shouldResignOnTouchOutside = YES;
    //[Bmob registerWithAppKey:@"786255b502405006318e7c684d13e8ed"];
    [self createDefaultTable];
    // Override point for customization after application launch.
    return YES;
}
-(void)createDefaultTable{
    NSString * isDefault = [UserDefaultStorageManager readObjectForKey:@"AccountBooksDefaultDelete"];
    
    if (![isDefault isEqualToString:@"0"]) {
        //数据库名
        NSMutableArray * oldNames = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
        NSMutableArray * newNames = [[NSMutableArray alloc] init];
        //书名
        NSMutableArray * oldBookNames = [UserDefaultStorageManager readObjectForKey:kUSERBOOKNAMEKEY];
        NSMutableArray * newBookNames = [[NSMutableArray alloc] init];
        
        NSString * tableName = [NSString stringWithFormat:@"AccountBooks%@",@"婚礼往来"];
        if (![kDataBase jq_isExistTable:tableName]) {
            [kDataBase jq_createTable:tableName dicOrModel:[BooksModel class]];
            BooksModel * model = [[BooksModel alloc] init];
            model.bookName = @"婚礼往来";
            model.bookDate = [[NSDate getCurrentTimes] getCNDate];
            model.bookImage = arc4random() % 1;
            model.bookId = 0;
            model.bookMoney = @"0";
            model.name = @"";
            model.money = @"";
            model.data = @"";
            model.tableType = 0;
            BooksModel * model1 = [[BooksModel alloc] init];
            model1.bookName = @"婚礼往来";
            model1.bookDate = [[NSDate getCurrentTimes] getCNDate];
            model1.bookImage = arc4random() % 1;
            model1.bookId = 0;
            model1.bookMoney = @"0";
            model1.name = @"示例";
            model1.money = @"600";
            model1.data = [[NSDate getCurrentTimes] getCNDate];
            model1.tableType = 0;
            [kDataBase jq_inDatabase:^{
                [kDataBase jq_insertTable:tableName dicOrModel:model];
            }];
            [kDataBase jq_inDatabase:^{
                [kDataBase jq_insertTable:tableName dicOrModel:model1];
            }];
            for (NSString * name in oldNames) {
                [newNames addObject:name];
            }
            [newNames addObject:tableName];
            
            for (NSString * bookname in oldBookNames) {
                [newBookNames addObject:bookname];
            }
            [newBookNames addObject:@"婚礼往来"];
            [UserDefaultStorageManager removeObjectForKey:kUSERTABLENAMEKEY];
            [UserDefaultStorageManager saveObject:newNames forKey:kUSERTABLENAMEKEY];
            [UserDefaultStorageManager removeObjectForKey:kUSERBOOKNAMEKEY];
            [UserDefaultStorageManager saveObject:newBookNames forKey:kUSERBOOKNAMEKEY];
            [UserDefaultStorageManager saveObject:@"1" forKey:@"AccountBooksDefaultDelete"];
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
