//
//  PBTableExtension.m
//  PoliteBooks
//
//  Created by llk on 2019/6/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "PBTableExtension.h"

@implementation PBTableExtension

+(void)inserDataForModel:(PBTableModel *)model andBookModel:(PBBookModel *)bookModel success:(void (^)(id _Nonnull))success{
    BmobObject  *table = [BmobObject objectWithClassName:@"userTables"];
    //设置帖子的标题和内容
    [table setObject:model.userMoney forKey:@"dUserMoney"];
    [table setObject:model.userName forKey:@"dUserName"];
    [table setObject:model.userDate forKey:@"dUserData"];
    [table setObject:model.userType forKey:@"dUserType"];
    [table setObject:@(model.inType) forKey:@"dUserInType"];
    [table setObject:@(model.outType) forKey:@"dUserOutType"];
    BmobObject *bookAu = [BmobObject objectWithoutDataWithClassName:@"userBooks" objectId:bookModel.objectId];
    [table setObject:bookAu forKey:@"bookAu"];
    //异步保存
    [table saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            success(@"1");
        }else{
            if (error) {
            }
        }
    }];
}
+(void)delegateDataForModel:(PBTableModel *)model success:(void (^)(id _Nonnull))success{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userTables"];
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
+(void)queryBookListWithModel:(PBBookModel *)model success:(void (^)(NSMutableArray<PBTableModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userTables"];
    BmobObject *bookAu = [BmobObject objectWithoutDataWithClassName:@"userBooks" objectId:model.objectId];
    [query whereKey:@"bookAu" equalTo:bookAu];
    //匹配查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            fail(error);
        } else if (array){
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (BmobObject *book in array) {
                PBTableModel * model = [[PBTableModel alloc] init];
                model.userName = [book objectForKey:@"dUserName"];
                model.userType = [book objectForKey:@"dUserType"];
                model.userMoney = [book objectForKey:@"dUserMoney"];
                model.userDate = [book objectForKey:@"dUserData"];
                model.inType = [[book objectForKey:@"dUserInType"] integerValue];
                model.outType = [[book objectForKey:@"dUserOutType"] integerValue];
                model.objectId = book.objectId;
                [arr addObject:model];
            }
            success(arr);
        }
    }];
}
+(void)updataForModel:(PBTableModel *)model success:(void (^)(id _Nonnull))success{
    
}
/*
+(void)inserDataForModel:(PBTableModel *)model andBookModel:(PBBookModel*)bookModel succ{
    BmobObject  *table = [BmobObject objectWithClassName:@"userTables"];
    //设置帖子的标题和内容
    [table setObject:model.userMoney forKey:@"userMoney"];
    [table setObject:model.userName forKey:@"userName"];
    [table setObject:model.userDate forKey:@"userDate"];
    [table setObject:model.userType forKey:@"userType"];
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"userTables" objectId:bookModel.objectId];
    [table setObject:author forKey:@"author"];
    //异步保存
    [table saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
        }else{
            if (error) {
            }
        }
    }];
}
+(void)delegateDataForModel:(PBTableModel*)model{
 
}
+(void)queryBookListWithModel:(PBBookModel *)model success:(void (^)(NSMutableArray<PBTableModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userTables"];
    //构建objectId为vbhGAAAY 的作者
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    //添加作者是objectId为vbhGAAAY条件
    [query whereKey:@"author" equalTo:author];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            fail(error);
        } else if (array){
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (BmobObject *book in array) {
                PBBookModel * model = [[PBBookModel alloc] init];
                model.bookName = [book objectForKey:@"bookName"];
                model.bookDate = [book objectForKey:@"bookData"];
                model.bookColor = [[book objectForKey:@"bookColor"] integerValue];
                model.objectId = book.objectId;
                [arr addObject:model];
            }
            success(arr);
        }
    }];
}*/
@end
