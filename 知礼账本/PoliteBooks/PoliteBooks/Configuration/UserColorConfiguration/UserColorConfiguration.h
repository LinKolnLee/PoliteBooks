//
//  UserColorConfiguration.h
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDefaultStorageManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserColorConfiguration : NSObject

/**
 颜色列表

 @return models
 */
+(NSArray<UserColorModel *> *)colors;

/**
 初始化账本颜色及纸张颜色
 */
+(void)initUserColorsInFirstboot;

/**
 修改账本颜色

 @param color 修改的颜色
 @param index 第几个账本的颜色被修改
 */
+(void)changeUserColorsWithColor:(NSInteger)color WithIndex:(NSInteger)index;


/**
 删除账本需要的操作
 @param index 第几个账本
 */
+(void)deleteUserColorsWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
