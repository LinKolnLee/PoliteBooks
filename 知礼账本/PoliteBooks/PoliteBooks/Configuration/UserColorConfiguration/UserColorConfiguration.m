//
//  UserColorConfiguration.m
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "UserColorConfiguration.h"

@implementation UserColorConfiguration
+(NSMutableArray<UserColorModel *> *)colors{

    NSString * str = [UserDefaultStorageManager readObjectForKey:kUSERCOLORDEFAULTKEY];
    NSMutableArray<UserColorModel *> * models = [self dictionaryWithJsonString:str][@"models"];
    
    return models;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(void)initUserColorsInFirstboot{
    NSArray * colors = @[@"backImage1",@"backImage2",@"backImage3"];
    NSArray * names = @[@"出：",@"进：",@"慨掷："];
    NSMutableArray * models = [[NSMutableArray alloc] init];
    for (int i = 0; i<colors.count; i++) {
        UserColorModel * model = [[UserColorModel alloc] init];
        model.image = colors[i];
        model.bookName = names[i];
        model.bookCreatDate = [NSDate getCurrentYear];
        model.moneySun = @"110";
        [models addObject:model];
    }
    NSDictionary * dic = @{@"models":models};
    //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[models yy_modelToJSONData] options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [dic yy_modelToJSONString];
    [UserDefaultStorageManager saveObject:str forKey:kUSERCOLORDEFAULTKEY];
}
+(void)changeUserColorsWithColor:(NSInteger)color WithIndex :(NSInteger)index{
//     NSMutableArray <UserColorModel *> *array = [NSKeyedUnarchiver unarchiveObjectWithData:[UserDefaultStorageManager readObjectForKey:kUSERCOLORDEFAULTKEY]];
//    [array removeObjectAtIndex:index];
//    [array insertObject:@(color) atIndex:index];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
//    [UserDefaultStorageManager saveObject:jsonData forKey:kUSERCOLORDEFAULTKEY];
    
}
+(void)deleteUserColorsWithIndex:(NSInteger)index{
    NSMutableArray * colors = [UserDefaultStorageManager readObjectForKey:kUSERCOLORDEFAULTKEY];
    [colors removeObjectAtIndex:index];
    [UserDefaultStorageManager saveObject:colors forKey:kUSERCOLORDEFAULTKEY];
}
@end
