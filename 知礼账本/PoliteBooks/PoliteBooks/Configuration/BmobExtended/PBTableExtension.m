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
    [[BeautyLoadingHUD shareManager] startAnimating];
    BmobObject  *table = [BmobObject objectWithClassName:@"userTables"];
    //设置帖子的标题和内容
    [table setObject:model.userMoney forKey:@"dUserMoney"];
    [table setObject:model.userName forKey:@"dUserName"];
    [table setObject:model.userDate forKey:@"dUserData"];
    [table setObject:model.userType forKey:@"dUserType"];
    [table setObject:model.userRelation forKey:@"dUserRealtion"];
    [table setObject:@(model.inType) forKey:@"dUserInType"];
    [table setObject:@(model.outType) forKey:@"dUserOutType"];
    [table setObject:@(model.bookColor) forKey:@"dUserBookColor"];
    BmobObject *bookAu = [BmobObject objectWithoutDataWithClassName:@"userBooks" objectId:bookModel.objectId];
    [table setObject:bookAu forKey:@"bookAu"];
    //异步保存
    [table saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
         [[BeautyLoadingHUD shareManager] stopAnimating];
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
         [[BeautyLoadingHUD shareManager] stopAnimating];
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
+(void)queryBookListWithModel:(PBBookModel *)model success:(void (^)(NSMutableArray<PBTableModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userTables"];
    BmobObject *bookAu = [BmobObject objectWithoutDataWithClassName:@"userBooks" objectId:model.objectId];
    [query whereKey:@"bookAu" equalTo:bookAu];
    query.cachePolicy = kBmobCachePolicyNetworkElseCache;
    //匹配查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
             [[BeautyLoadingHUD shareManager] stopAnimating];
            fail(error);
        } else if (array){
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (BmobObject *book in array) {
                PBTableModel * model = [[PBTableModel alloc] init];
                model.userName = [book objectForKey:@"dUserName"];
                model.userType = [book objectForKey:@"dUserType"];
                model.userMoney = [book objectForKey:@"dUserMoney"];
                model.userRelation = [book objectForKey:@"dUserRealtion"];
                model.userDate = [book objectForKey:@"dUserData"];
                model.inType = [[book objectForKey:@"dUserInType"] integerValue];
                model.outType = [[book objectForKey:@"dUserOutType"] integerValue];
                model.objectId = book.objectId;
                model.bookColor = [[book objectForKey:@"dUserBookColor"] integerValue];
                [arr addObject:model];
            }
            success(arr);
        }
    }];
}
+(void)updataForModel:(PBTableModel *)model success:(void (^)(id _Nonnull))success{
    
}
+(void)querySearchBookListWithStr:(NSString *)str success:(void (^)(NSMutableArray<PBTableModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    [BmobBookExtension queryBookListsuccess:^(NSMutableArray<PBBookModel *> * _Nonnull bookList) {
        if (bookList.count != 0) {
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (PBBookModel * model in bookList) {
                BmobQuery *query = [BmobQuery queryWithClassName:@"userTables"];
                BmobObject *bookAu = [BmobObject objectWithoutDataWithClassName:@"userBooks" objectId:model.objectId];
                [query whereKey:@"bookAu" equalTo:bookAu];
                [query whereKey:@"dUserName" equalTo:str];
                query.cachePolicy = kBmobCachePolicyNetworkElseCache;
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    if (error) {
                        fail(error);
                    } else if (array){
                        for (BmobObject *book in array) {
                            PBTableModel * model = [[PBTableModel alloc] init];
                            model.userName = [book objectForKey:@"dUserName"];
                            model.userType = [book objectForKey:@"dUserType"];
                            model.userMoney = [book objectForKey:@"dUserMoney"];
                            model.userDate = [book objectForKey:@"dUserData"];
                            model.inType = [[book objectForKey:@"dUserInType"] integerValue];
                            model.outType = [[book objectForKey:@"dUserOutType"] integerValue];
                            model.objectId = book.objectId;
                            model.bookColor = [[book objectForKey:@"dUserBookColor"] integerValue];
                            [arr addObject:model];
                        }
                         success(arr);
                    }
                }];
            }
        }else{
            [[BeautyLoadingHUD shareManager] stopAnimating];
        }
    } fail:^(id _Nonnull error) {
    }];
}

+(void)queryRealtionTableLissuccess:(void (^)(NSMutableArray<PBTableModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    NSMutableArray * allTableList = [[NSMutableArray alloc] init];
    [BmobBookExtension queryBookListsuccess:^(NSMutableArray<PBBookModel *> * _Nonnull bookList) {
        if (bookList.count) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"开始");
                dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                for (int i = 0; i < bookList.count; i++) {
                    [self queryBookListWithModel:bookList[i] success:^(NSMutableArray<PBTableModel *> * _Nonnull tableList) {
                        [allTableList addObjectsFromArray:tableList];
                        if (i == bookList.count - 1) {
                            [[BeautyLoadingHUD shareManager] stopAnimating];
                            success(allTableList);
                        }
                        dispatch_semaphore_signal(sema);
                    } fail:^(id _Nonnull error) {
                        [[BeautyLoadingHUD shareManager] stopAnimating];
                    }];
                    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

                }
            });
        }
    } fail:^(id _Nonnull error) {
        [[BeautyLoadingHUD shareManager] stopAnimating];
    }];
}

@end
