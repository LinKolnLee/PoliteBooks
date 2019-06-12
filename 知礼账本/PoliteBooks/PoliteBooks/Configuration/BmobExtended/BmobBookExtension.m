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
    [book setObject:[NSString stringWithFormat:@"%ld",(long)model.bookColor] forKey:@"bookColor"];
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    [book setObject:author forKey:@"author"];
    //异步保存
    [book saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            success(nil);
        }else{
            if (error) {
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
                [object deleteInBackground];
                success(object);
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
}
@end
