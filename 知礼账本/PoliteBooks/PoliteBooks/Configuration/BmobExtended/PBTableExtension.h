//
//  PBTableExtension.h
//  PoliteBooks
//
//  Created by llk on 2019/6/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>
#
NS_ASSUME_NONNULL_BEGIN

@interface PBTableExtension : NSObject
+(void)inserDataForModel:(PBTableModel *)model andBookModel:(PBBookModel*)bookModel success:(void (^)(id responseObject))success;

+(void)delegateDataForModel:(PBTableModel *)model success:(void (^)(id responseObject))success;

+ (void)queryBookListWithModel:(PBBookModel *)model success:(void (^)(NSMutableArray<PBTableModel *> *tableList))success fail:(void (^)(id))fail;

+(void)updataForModel:(PBTableModel *)model success:(void (^)(id responseObject))success;
@end

NS_ASSUME_NONNULL_END
