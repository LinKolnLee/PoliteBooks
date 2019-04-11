//
//  NSDate+String.m
//  Beauty
//
//  Created by llk on 2018/4/4.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import "NSDate+String.h"

@implementation NSDate (String)
-(NSString *)timeToString{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *YMDDateString = [selectDateFormatter stringFromDate:self]; // 把date类型转为设置好格式的string类型
    return YMDDateString;
}
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}
+(NSString *)getCurrentYear{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY"];
    
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[currentTimeString doubleValue]]];
    //通过NSNumberFormatter转换为大写的数字格式 eg:一千二百三十四
    //替换大写数字转为金额
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"一" withString:@"壹"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"二" withString:@"贰"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"三" withString:@"叁"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"四" withString:@"肆"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"五" withString:@"伍"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"六" withString:@"陆"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"七" withString:@"柒"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"八" withString:@"捌"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"九" withString:@"玖"];formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"〇" withString:@"零"];
    
    if ([formattedNumberString containsString:@"千"]) {
        formattedNumberString =[formattedNumberString stringByReplacingOccurrencesOfString:@"千" withString:@""];
    }
    if ([formattedNumberString containsString:@"百"]) {
        formattedNumberString =[formattedNumberString stringByReplacingOccurrencesOfString:@"百" withString:@""];
    }
    if ([formattedNumberString containsString:@"十"]) {
        formattedNumberString =[formattedNumberString stringByReplacingOccurrencesOfString:@"十" withString:@""];
    }
    return [NSString stringWithFormat:@"%@年",formattedNumberString];
}

@end
