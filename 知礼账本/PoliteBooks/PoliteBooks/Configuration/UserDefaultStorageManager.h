//
//  UserDefaultStorageManager.h
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultStorageManager : NSObject

/**
 UserDefault 保存数据
 
 @param object 对象
 @param key 键值
 */
+(void)saveObject:(id)object forKey:(NSString *)key;

/**
 UserDefault 读取数据
 
 @param key 键值
 @return 对象
 */
+(id)readObjectForKey:(NSString *)key;

/**
 UserDefault 删除数据
 
 @param key 键值
 */
+(void)removeObjectForKey:(NSString *)key;



@end

NS_ASSUME_NONNULL_END
