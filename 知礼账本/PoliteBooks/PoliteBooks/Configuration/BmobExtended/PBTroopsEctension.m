//
//  PBTroopsEctension.m
//  PoliteBooks
//
//  Created by llk on 2019/7/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "PBTroopsEctension.h"

@implementation PBTroopsEctension
+(void)queryDayBookListWithDate:(NSDate *)date userObjectId:(NSString *)objectId withType:(NSInteger)type success:(void (^)(NSMutableArray<PBWatherModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userWatherTables"];
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
    NSInteger year = [date year];
    [query whereKey:@"year" equalTo:@(year)];
    [query whereKey:@"month" equalTo:@([date month])];
    //[query whereKey:@"weekNum" equalTo:@([date weekOfYear])];
    [query whereKey:@"day" equalTo:@([date day])];
    [query orderByDescending:@"day"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [[BeautyLoadingHUD shareManager] stopAnimating];
        if (error) {
            fail(error);
        } else if (array){
            if (array != nil) {
                NSMutableArray * arr = [[NSMutableArray alloc] init];
                for (BmobObject *book in array) {
                    PBWatherModel * model = [[PBWatherModel alloc] init];
                    model.price = [book objectForKey:@"price"];
                    model.year = [[book objectForKey:@"year"] integerValue];
                    model.month = [[book objectForKey:@"month"] integerValue];
                    model.objectId = book.objectId;
                    model.weekNum = [[book objectForKey:@"weekNum"] integerValue];
                    model.week = [[book objectForKey:@"week"] integerValue];
                    model.type = [[book objectForKey:@"type"] integerValue];
                    model.day = [[book objectForKey:@"day"] integerValue];
                    model.mark = [book objectForKey:@"mark"] ;
                    model.moneyType = [[book objectForKey:@"moneyType"] integerValue];
                    [arr addObject:model];
                }
                success(arr);
            }
        }
    }];
}
+(void)queryMonthBookListWithDate:(NSDate *)date withType:(NSInteger)type userObjectId:(nonnull NSString *)objectId success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userWatherTables"];
    //构建objectId为vbhGAAAY 的作者
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
    NSInteger year = [date year];
    [query whereKey:@"year" equalTo:@(year)];
    [query whereKey:@"month" equalTo:@([date month])];
    [query whereKey:@"moneyType" equalTo:@(type)];
    [query orderByAscending:@"day"];
    // query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [[BeautyLoadingHUD shareManager] stopAnimating];
        if (error) {
            fail(error);
        } else if (array){
            if (array != nil) {
                NSMutableArray * arr = [[NSMutableArray alloc] init];
                for (BmobObject *book in array) {
                    PBWatherModel * model = [[PBWatherModel alloc] init];
                    model.price = [book objectForKey:@"price"];
                    model.year = [[book objectForKey:@"year"] integerValue];
                    model.month = [[book objectForKey:@"month"] integerValue];
                    model.objectId = book.objectId;
                    model.weekNum = [[book objectForKey:@"weekNum"] integerValue];
                    model.week = [[book objectForKey:@"week"] integerValue];
                    model.type = [[book objectForKey:@"type"] integerValue];
                    model.day = [[book objectForKey:@"day"] integerValue];
                    model.mark = [book objectForKey:@"mark"] ;
                    model.moneyType = [[book objectForKey:@"moneyType"] integerValue];
                    [arr addObject:model];
                }
                NSMutableArray *dateMutableArray = [[NSMutableArray alloc] init];
                for (int i = 0; i < arr.count; i ++) {
                    PBWatherModel * oldmodel = arr[i];
                    NSMutableArray *tempArray = [[NSMutableArray alloc] init];;
                    [tempArray addObject:oldmodel];
                    for (int j = i+1; j < arr.count; j ++) {
                        PBWatherModel * newModel = arr[j];
                        if(oldmodel.day == newModel.day){
                            [tempArray addObject:newModel];
                            [arr removeObjectAtIndex:j];
                            j -= 1;
                        }
                    }
                    [dateMutableArray addObject:tempArray];
                }
                success(dateMutableArray);
            }
        }
    }];
}
+(void)queryUserTroopsWithPhone:(NSString *)phone success:(void (^)(NSString * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"_User"];
    [query whereKey:@"mobilePhoneNumber" equalTo:phone];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [[BeautyLoadingHUD shareManager] stopAnimating];
        if (error) {
            fail(error);
        } else if (array){
            if (array.count != 0) {
                NSString * objectId = @"";
                for (BmobUser * dic in array) {
                    objectId = [dic objectForKey:@"objectId"];
                    BmobUser * oldUser = dic;
                    [oldUser setObject:kMemberInfoManager.objectId forKey:@"troopsid"];
                    [oldUser updateInBackground];
                }
                BmobUser * user = [BmobUser currentUser];
                [user setObject:objectId forKey:@"troopsid"];
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        success(objectId);
                    }
                }];
            }else{
                [ToastManage showTopToastWith:@"该手机号未绑定用户"];
            }
        }
    }];
}
+(void)relieveTroopsWithId:(NSString *)objectId success:(void (^)(NSString * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"_User"];
    [query whereKey:@"troopsid" equalTo:objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            fail(error);
        } else if (array){
            if (array.count != 0) {
                for (BmobUser * dic in array) {
                    BmobUser * oldUser = dic;
                    [oldUser setObject:nil forKey:@"troopsid"];
                    [oldUser updateInBackground];
                }
                success(@"");
            }else{
                [ToastManage showTopToastWith:@"数据发生错误请稍后再试"];
            }
        }
    }];
}
@end
