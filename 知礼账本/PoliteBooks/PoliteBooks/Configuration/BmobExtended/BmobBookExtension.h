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
@end

NS_ASSUME_NONNULL_END
