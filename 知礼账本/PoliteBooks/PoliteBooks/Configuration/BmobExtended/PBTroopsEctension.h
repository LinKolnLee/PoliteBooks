//
//  PBTroopsEctension.h
//  PoliteBooks
//
//  Created by llk on 2019/7/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBTroopsEctension : NSObject

+ (void)queryDayBookListWithDate:(NSDate *)date userObjectId:(NSString *)objectId withType:(NSInteger)type success:(void (^)(NSMutableArray<PBWatherModel *>*bookList))success fail:(void (^)(id))fail;

+ (void)queryMonthBookListWithDate:(NSDate *)date withType:(NSInteger)type userObjectId:(NSString *)objectId success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *>*bookList))success fail:(void (^)(id))fail;
+(void)queryUserTroopsWithPhone:(NSString *)phone success:(void (^)(NSString*objectId))success fail:(void (^)(id))fail;
@end

NS_ASSUME_NONNULL_END
