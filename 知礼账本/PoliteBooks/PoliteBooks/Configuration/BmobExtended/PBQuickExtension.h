//
//  PBQuickExtension.h
//  PoliteBooks
//
//  Created by llk on 2019/7/1.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBQuickExtension : NSObject
+(void)inserDataForModel:(PBQuickModel *)model success:(void (^)(id responseObject))success;

+(void)delegateDataForModel:(PBQuickModel *)model success:(void (^)(id responseObject))success;

+ (void)queryBookListsuccess:(void (^)(NSMutableArray<PBQuickModel *> *bookList))success fail:(void (^)(id))fail;

@end

NS_ASSUME_NONNULL_END
