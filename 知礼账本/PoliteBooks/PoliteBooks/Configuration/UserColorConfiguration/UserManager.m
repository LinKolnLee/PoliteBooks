//
//  UserManager.m
//  PoliteBooks
//
//  Created by llk on 2019/6/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "UserManager.h"
#import "FCUUID.h"
static UserManager *manager = nil;

@implementation UserManager
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[UserManager alloc] init];
        }
    });
    return manager;
}
+(void) showUserLoginView{
    //直接注册
    BmobUser *bUser = [[BmobUser alloc] init];
    NSString *strName = [FCUUID uuid];
    NSString *nickName = [UserManager getNameString];
    [bUser setUsername:strName];
    [bUser setPassword:@"zhiliBook"];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            [bUser setObject:nickName forKey:@"nickName"];
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                BmobUser *newUser = [BmobUser currentUser];
//                [UserManager sharedInstance].user_id = newUser.objectId;
//                PBBookModel * bookModel = [[PBBookModel alloc] init];
//                bookModel.bookName = @"婚礼账簿";
//                bookModel.bookColor = 0;
//                bookModel.bookDate = [[NSDate getCurrentTimes] getCNDate];;
//                [BmobBookExtension inserDataForModel:bookModel success:^(id  _Nonnull responseObject) {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserRegiseBook" object:nil];
//                    DLog(@"用户注册成功");
//                }];
            }];
        } else {
            NSLog(@"%@",error);
        }
    }];
}
//获取随机名字
+(NSString*)getNameString{
    NSArray*nameArray=
    @[@"齐御风",@"无崖子",@"程灵素",@"袁紫衣",
      @"苏星河",@"丁春秋",@"任盈盈",@"岳灵珊",
    @"阮星竹",@"鸠摩智",@"仪琳",@"曲非烟",
      @"邓百川",@"公冶乾",@"苗若兰",@"小龙女",
      
      @"包不同",@"风波恶",@"陆无双",@"李莫愁",
      
      @"吴长风",@"白世镜",@"王语嫣",@"木婉清",
      
      @"马大元",@"全冠清",@"刀白凤",@"秦红棉",
      
      @"王重阳",@"周伯通",@"甘宝宝",@"阿朱",
      
      @"丘处机",@"孙不二",@"阿紫",@"李秋水",
      
      @"黄药师",@"欧阳锋",@"黄蓉",@"穆念慈",
      ];
    int textInt = arc4random() % 39;
    return  nameArray[textInt];
}

@end
