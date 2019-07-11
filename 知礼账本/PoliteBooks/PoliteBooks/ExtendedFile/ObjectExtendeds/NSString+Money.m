//
//  NSString+Money.m
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "NSString+Money.h"

@implementation NSString (Money)
-(NSString *)getCnMoney{
    // 设置数据格式
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // NSLocale的意义是将货币信息、标点符号、书写顺序等进行包装，如果app仅用于中国区应用，为了保证当用户修改语言环境时app显示语言一致，则需要设置NSLocal（不常用）
    numberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    // 全拼格式
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    // 小数点后最少位数
    [numberFormatter setMinimumFractionDigits:2];
    // 小数点后最多位数
    [numberFormatter setMaximumFractionDigits:6];[numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    //通过NSNumberFormatter转换为大写的数字格式 eg:一千二百三十四
    //替换大写数字转为金额
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"一" withString:@"壹"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"二" withString:@"贰"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"三" withString:@"叁"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"四" withString:@"肆"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"五" withString:@"伍"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"六" withString:@"陆"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"七" withString:@"柒"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"八" withString:@"捌"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"九" withString:@"玖"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"〇" withString:@"零"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"千" withString:@"仟"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"百" withString:@"佰"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"十" withString:@"拾"];
    // 对小数点后部分单独处理// rangeOfString 前面的参数是要被搜索的字符串，后面的是要搜索的字符
    if ([formattedNumberString rangeOfString:@"点"].length>0){
        // 将“点”分割的字符串转换成数组，这个数组有两个元素，分别是小数点前和小数点后
        NSArray* arr = [formattedNumberString componentsSeparatedByString:@"点"];
        // 如果对一不可变对象复制，copy是指针复制（浅拷贝）和mutableCopy就是对象复制（深拷贝）。如果是对可变对象复制，都是深拷贝，但是copy返回的对象是不可变的。
        // 这里指的是深拷贝
        NSMutableString* lastStr = [[arr lastObject] mutableCopy];NSLog(@"---%@---长度%ld", lastStr, lastStr.length);if (lastStr.length>=2){
            // 在最后加上“分”
            [lastStr insertString:@"分" atIndex:lastStr.length];}
        if (![[lastStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"零"]){
                // 在小数点后第一位后边加上“角”
                [lastStr insertString:@"角" atIndex:1];
            }
        // 在小数点左边加上“元”
            formattedNumberString = [[arr firstObject] stringByAppendingFormat:@"元%@",lastStr];
        }else{
            formattedNumberString = [formattedNumberString stringByAppendingString:@"元"];
        }
    return formattedNumberString;
}
-(NSString *)getCNDate{
    NSArray * arr = [self componentsSeparatedByString:@"-"];
    NSString * yearStr = [[[arr[0] getCnMoney] stringByReplacingOccurrencesOfString:@"仟" withString:@""] stringByReplacingOccurrencesOfString:@"元" withString:@"年"];
    yearStr = [yearStr stringByReplacingOccurrencesOfString:@"拾" withString:@""];
    NSString * month = [[arr[1] getCnMoney] stringByReplacingOccurrencesOfString:@"元" withString:@"月"];
    NSString * day = [[arr[2] getCnMoney] stringByReplacingOccurrencesOfString:@"元" withString:@"日"];
    NSString * date = [NSString stringWithFormat:@"%@%@%@",yearStr,month,day];
    return date;
    
}
-(NSDate *)getStringDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
   NSDate *date = [dateFormatter dateFromString:self];
    return date;
}
-(BOOL)isEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
@end
