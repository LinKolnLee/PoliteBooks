//
//  NSString+Money.h
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Money)
-(NSString *)getCnMoney;


-(NSString *)getCNDate;

-(NSDate *)getStringDate;

-(BOOL)isEmail;
@end

NS_ASSUME_NONNULL_END
