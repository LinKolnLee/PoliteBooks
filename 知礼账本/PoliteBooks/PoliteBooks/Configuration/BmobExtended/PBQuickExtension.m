//
//  PBQuickExtension.m
//  PoliteBooks
//
//  Created by llk on 2019/7/1.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "PBQuickExtension.h"

@implementation PBQuickExtension

+(void)inserDataForModel:(PBQuickModel *)model success:(void (^)(id _Nonnull))success{
    BmobObject  *book = [BmobObject objectWithClassName:@"userQuickTables"];
    //设置帖子的标题和内容
    [book setObject:model.price forKey:@"price"];
    [book setObject:model.name forKey:@"name"];
    [book setObject:@(model.type) forKey:@"type"];
    [book setObject:@(model.moneyType) forKey:@"moneyType"];
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
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userQuickTables"];
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
+(void)queryBookListsuccess:(void (^)(NSMutableArray<PBQuickModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userQuickTables"];
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
                PBQuickModel * model = [[PBQuickModel alloc] init];
                model.price = [book objectForKey:@"price"];
                model.name = [book objectForKey:@"name"];
                model.moneyType = [[book objectForKey:@"moneyType"] integerValue];
                model.type = [[book objectForKey:@"type"] integerValue];
                model.objectId = book.objectId;
                [arr addObject:model];
            }
            success(arr);
        }
    }];
}


@end
