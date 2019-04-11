//
//  UserDefaultStorageManager.m
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "UserDefaultStorageManager.h"

@implementation UserDefaultStorageManager

+(void)saveObject:(id)object forKey:(NSString *)key{
    [kUserDefault setObject:object forKey:key];
    [kUserDefault synchronize];
}

+(void)removeObjectForKey:(NSString *)key{
    if ([self readObjectForKey:key] != nil) {
        [kUserDefault removeObjectForKey:key];
    }
}

+(id)readObjectForKey:(NSString *)key{
    return [kUserDefault objectForKey:key];
}
@end
