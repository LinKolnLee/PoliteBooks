//
//  PBTableModel.h
//  PoliteBooks
//
//  Created by llk on 2019/6/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBTableModel : NSObject
@property(nonatomic,strong)NSString * objectId;
/**
 金额
 */
@property(nonatomic,strong)NSString * userMoney;
/**
姓名
 */
@property(nonatomic,strong)NSString * userName;
/**
 日期
 */
@property(nonatomic,strong)NSString * userDate;

@property(nonatomic,strong)NSString * userType;

@property(nonatomic,assign)NSInteger inType;

@property(nonatomic,assign)NSInteger outType;

@property(nonatomic,assign)NSInteger bookColor;
@end

NS_ASSUME_NONNULL_END
