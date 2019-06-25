//
//  PBWatherExtension.h
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBWatherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PBWatherExtension : NSObject
+(void)inserDataForModel:(PBWatherModel *)model success:(void (^)(id responseObject))success;

+(void)delegateDataForModel:(PBWatherModel *)model success:(void (^)(id responseObject))success;

+ (void)queryBookListsuccess:(void (^)(NSMutableArray<PBWatherModel *> *bookList))success fail:(void (^)(id))fail;

+(void)updataForModel:(PBWatherModel *)model success:(void (^)(id responseObject))success;
@end

NS_ASSUME_NONNULL_END
