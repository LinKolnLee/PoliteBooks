//
//  PBWatherExtension.m
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "PBWatherExtension.h"

@implementation PBWatherExtension

+(void)inserDataForModel:(PBWatherModel *)model success:(void (^)(id _Nonnull))success{
    BmobObject  *book = [BmobObject objectWithClassName:@"userWatherTables"];
    //设置帖子的标题和内容
    [book setObject:model.price forKey:@"price"];
    [book setObject:@(model.year) forKey:@"year"];
    [book setObject:@(model.month) forKey:@"month"];
    [book setObject:@(model.day) forKey:@"day"];
    [book setObject:@(model.week) forKey:@"week"];
    [book setObject:@(model.weekNum) forKey:@"weekNum"];
    [book setObject:@(model.type) forKey:@"type"];
    [book setObject:@(model.moneyType) forKey:@"moneyType"];
    [book setObject:model.mark forKey:@"mark"];
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    [book setObject:author forKey:@"author"];
    //异步保存
    [book saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            success(@"1");
        }else{
            if (error) {
                [[BeautyLoadingHUD shareManager] stopAnimating];
            }
        }
    }];
}
+(void)delegateDataForModel:(PBWatherModel *)model success:(void (^)(id _Nonnull))success{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userWatherTables"];
    [bquery getObjectInBackgroundWithId:model.objectId block:^(BmobObject *object, NSError *error){
        if (error) {
        }else{
            if (object) {
                //异步删除object
                [object deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                    success(object);
                }];
            }
        }
    }];
}
+(void)updataForModel:(PBWatherModel *)model success:(void (^)(id _Nonnull))success{
    
}
+(void)queryBookListsuccess:(void (^)(NSMutableArray<PBWatherModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userWatherTables"];
    //构建objectId为vbhGAAAY 的作者
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
    query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [[BeautyLoadingHUD shareManager] stopAnimating];
        if (error) {
            fail(error);
        } else if (array){
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (BmobObject *book in array) {
                PBWatherModel * model = [[PBWatherModel alloc] init];
                model.price = [book objectForKey:@"price"];
                model.year = [[book objectForKey:@"year"] integerValue];
                model.month = [[book objectForKey:@"month"] integerValue];
                model.objectId = book.objectId;
                model.week = [[book objectForKey:@"week"] integerValue];
                model.weekNum = [[book objectForKey:@"weekNum"] integerValue];
                 model.type = [[book objectForKey:@"type"] integerValue];
                 model.moneyType = [[book objectForKey:@"moneyType"] integerValue];
                model.day = [[book objectForKey:@"day"] integerValue];
                model.mark = [book objectForKey:@"mark"] ;
                [arr addObject:model];
            }
            success(arr);
        }
    }];
}
+(void)queryDayBookListWithDate:(NSDate *)date success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userWatherTables"];
    //构建objectId为vbhGAAAY 的作者
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
    NSInteger year = [date year];
    NSInteger month = [date month];
    [query whereKey:@"year" equalTo:@(year)];
    [query whereKey:@"month" equalTo:@(month)];
    [query orderByDescending:@"day"];
    query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
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
+(void)queryWeekBookListWithDate:(NSDate *)date withType:(NSInteger)type success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userWatherTables"];
    //构建objectId为vbhGAAAY 的作者
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
    NSInteger year = [date year];
    [query whereKey:@"year" equalTo:@(year)];
    [query whereKey:@"moneyType" equalTo:@(type)];
    [query orderByAscending:@"weekNum"];
    query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    
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
                        if(oldmodel.weekNum == newModel.weekNum){
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
+(void)queryMonthBookListWithDate:(NSDate *)date withType:(NSInteger)type success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userWatherTables"];
    //构建objectId为vbhGAAAY 的作者
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
    NSInteger year = [date year];
    [query whereKey:@"year" equalTo:@(year)];
     [query whereKey:@"moneyType" equalTo:@(type)];
    [query orderByAscending:@"month"];
    query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
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
                        if(oldmodel.month == newModel.month){
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
+(void)queryYearBookListWithDate:(NSDate *)date withType:(NSInteger)type success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userWatherTables"];
    //构建objectId为vbhGAAAY 的作者
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
     [query whereKey:@"moneyType" equalTo:@(type)];
    [query orderByAscending:@"year"];
    query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
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
                        if(oldmodel.year == newModel.year){
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
+(void)mergeWatherListForOldUser:(BmobUser *)user success:(nonnull void (^)(id _Nonnull))success{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userWatherTables"];
    //构建objectId为vbhGAAAY 的作者
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:user.objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [[BeautyLoadingHUD shareManager] stopAnimating];
        if (error) {
        } else if (array){
            for (int i= 0; i <array.count; i++) {
                BmobObject *book = array[i];
                BmobUser *author = [BmobUser currentUser];
                [book setObject:author forKey:@"author"];
                [book updateInBackground];
                if (i == array.count - 1) {
                    success(@"");
                }
            }
        }
    }];
}
@end
