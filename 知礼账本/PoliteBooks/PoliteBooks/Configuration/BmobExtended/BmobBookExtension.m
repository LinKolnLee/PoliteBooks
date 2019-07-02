//
//  BmobBookExtension.m
//  PoliteBooks
//
//  Created by llk on 2019/6/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "BmobBookExtension.h"

@implementation BmobBookExtension

+(void)inserDataForModel:(PBBookModel *)model success:(nonnull void (^)(id _Nonnull))success{
    BmobObject  *book = [BmobObject objectWithClassName:@"userBooks"];
    //设置帖子的标题和内容
    [book setObject:model.bookDate forKey:@"bookData"];
    [book setObject:model.bookName forKey:@"bookName"];
    [book setObject:@(0) forKey:@"bookInMoney"];
    [book setObject:@(0) forKey:@"bookOutMoney"];
    [book setObject:[NSString stringWithFormat:@"%ld",(long)model.bookColor] forKey:@"bookColor"];
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
+(void)delegateDataForModel:(PBBookModel *)model success:(nonnull void (^)(id _Nonnull))success{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userBooks"];
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
+(void)queryBookListsuccess:(void (^)(NSMutableArray<PBBookModel *> * _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    BmobQuery *query = [BmobQuery queryWithClassName:@"userBooks"];
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
                PBBookModel * model = [[PBBookModel alloc] init];
                model.bookName = [book objectForKey:@"bookName"];
                model.bookDate = [book objectForKey:@"bookData"];
                model.bookColor = [[book objectForKey:@"bookColor"] integerValue];
                model.objectId = book.objectId;
                model.bookInMoney = [[book objectForKey:@"bookInMoney"] integerValue];
                model.bookOutMoney = [[book objectForKey:@"bookOutMoney"] integerValue];
                [arr addObject:model];
            }
            success(arr);
        }
    }];
}
+(void)updataForModel:(PBBookModel *)model withType:(NSInteger)type success:(void (^)(id _Nonnull))success{
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"userBooks"];
    //查找GameScore表里面id为0c6db13c的数据
    [[BeautyLoadingHUD shareManager] startAnimating];
    [bquery getObjectInBackgroundWithId:model.objectId block:^(BmobObject *object,NSError *error){
        [[BeautyLoadingHUD shareManager] stopAnimating];
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:@"userBooks" objectId:model.objectId];
                if (type == 0) {
                     [obj1 setObject:@(model.bookOutMoney) forKey:@"bookOutMoney"];
                }else if (type == 1){
                    [obj1 setObject:@(model.bookInMoney) forKey:@"bookInMoney"];
                }else{
                    [obj1 setObject:@(model.bookOutMoney) forKey:@"bookOutMoney"];
                    [obj1 setObject:@(model.bookInMoney) forKey:@"bookInMoney"];
                }
                //异步更新数据
                [obj1 updateInBackground];
                success(@"1");
            }
        }else{
             [[BeautyLoadingHUD shareManager] stopAnimating];
        }
    }];
}
+(void)updataAuthorForModel:(PBBookModel *)model andNewUser:(BmobUser *)user success:(void (^)(id _Nonnull))success{
     BmobQuery   *bquery = [BmobQuery queryWithClassName:@"userBooks"];
    [bquery getObjectInBackgroundWithId:model.objectId block:^(BmobObject *object,NSError *error){
        [[BeautyLoadingHUD shareManager] stopAnimating];
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:@"userBooks" objectId:model.objectId];
                BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
                [obj1 setObject:author forKey:@"author"];
                //异步更新数据
                [obj1 updateInBackground];
                success(@"1");
            }
        }else{
            [[BeautyLoadingHUD shareManager] stopAnimating];
        }
    }];
}
@end
