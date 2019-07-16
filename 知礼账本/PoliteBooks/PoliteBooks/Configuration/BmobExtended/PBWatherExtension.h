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

+ (void)queryDayBookListWithDate:(NSDate *)date success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *>*bookList))success fail:(void (^)(id))fail;
+ (void)queryWeekBookListWithDate:(NSDate *)date withType:(NSInteger)type success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *>*bookList))success fail:(void (^)(id))fail;
+ (void)queryMonthBookListWithDate:(NSDate *)date withType:(NSInteger)type success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *>*bookList))success fail:(void (^)(id))fail;
+ (void)queryYearBookListWithDate:(NSDate *)date withType:(NSInteger)type success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *>*bookList))success fail:(void (^)(id))fail;

+(void)updataForModel:(PBWatherModel *)model success:(void (^)(id responseObject))success;

+(void)mergeWatherListForOldUser:(BmobUser *)user success:(void (^)(id responseObject))success;


+ (void)queryListWithType:(NSInteger)type andMoneyType:(NSInteger)moneyType success:(void (^)(NSMutableArray<PBWatherModel *> *weekMonets,NSMutableArray<PBWatherModel *> *monthMonets,NSMutableArray<PBWatherModel *> *yearMonets))success fail:(void (^)(id))fail;

+(void)queryMonthOrderListWithDate:(NSDate *)date success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *>*bookList))success fail:(void (^)(id))fail;

+(void)queryMonthOrderDetailListWithDate:(NSDate *)date success:(void (^)(NSMutableArray<NSMutableArray<PBWatherModel *> *>*bookList))success fail:(void (^)(id))fail;
@end

NS_ASSUME_NONNULL_END
