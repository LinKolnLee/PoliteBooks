//
//  BmobBookExtension.h
//  PoliteBooks
//
//  Created by llk on 2019/6/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBBookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BmobBookExtension : NSObject


+(void)inserDataForModel:(PBBookModel *)model success:(void (^)(id responseObject))success;

+(void)delegateDataForModel:(PBBookModel *)model success:(void (^)(id responseObject))success;

+ (void)queryBookListsuccess:(void (^)(NSMutableArray<PBBookModel *> *bookList))success fail:(void (^)(id))fail;

/**
 @param type 0:进礼 1：收礼
 */
+(void)updataForModel:(PBBookModel *)model withType:(NSInteger)type success:(void (^)(id responseObject))success;

+(void)updataAuthorForModel:(PBBookModel *)model andNewUser:(BmobUser *)user success:(void (^)(id responseObject))success;
@end

NS_ASSUME_NONNULL_END
