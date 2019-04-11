//
//  NSDate+String.h
//  Beauty
//
//  Created by llk on 2018/4/4.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (String)
//时间转字符串
-(NSString *)timeToString;
//获取当前时间
+(NSString*)getCurrentTimes;

+(NSString *)getCurrentYear;

@end
