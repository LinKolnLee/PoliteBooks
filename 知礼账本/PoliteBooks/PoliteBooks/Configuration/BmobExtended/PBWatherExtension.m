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
    [book setObject:@(model.price) forKey:@"price"];
    [book setObject:@(model.year) forKey:@"year"];
    [book setObject:@(model.month) forKey:@"month"];
    [book setObject:@(model.day) forKey:@"day"];
    [book setObject:@(model.week) forKey:@"week"];
     [book setObject:@(model.type) forKey:@"type"];
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
                [object deleteInBackground];
                success(object);
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
    query.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [[BeautyLoadingHUD shareManager] stopAnimating];
        if (error) {
            fail(error);
        } else if (array){
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (BmobObject *book in array) {
                PBWatherModel * model = [[PBWatherModel alloc] init];
                model.price = [[book objectForKey:@"price"] integerValue];
                model.year = [[book objectForKey:@"year"] integerValue];
                model.month = [[book objectForKey:@"month"] integerValue];
                model.objectId = book.objectId;
                model.week = [[book objectForKey:@"week"] integerValue];
                 model.type = [[book objectForKey:@"type"] integerValue];
                model.day = [[book objectForKey:@"day"] integerValue];
                model.mark = [book objectForKey:@"mark"] ;
                [arr addObject:model];
            }
            success(arr);
        }
    }];
}
@end
