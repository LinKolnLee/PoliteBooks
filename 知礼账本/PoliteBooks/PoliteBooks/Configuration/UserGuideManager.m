//
//  UserGuideManager.m
//  PoliteBooks
//
//  Created by llk on 2019/6/17.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "UserGuideManager.h"

@implementation UserGuideManager
+(void)guideWhitIndex:(NSInteger)index{
    NSString * str = [NSString stringWithFormat:@"引导%ld",(long)index];
    [UserDefaultStorageManager saveObject:@"1" forKey:str];
}
+(BOOL)isGuideWithIndex:(NSInteger)index{
    NSString * str = [NSString stringWithFormat:@"引导%ld",(long)index];
    if(![UserDefaultStorageManager readObjectForKey:str]){
        [UserGuideManager guideWhitIndex:index];
        return YES;
    }else{
        return NO;
    }
}
@end
