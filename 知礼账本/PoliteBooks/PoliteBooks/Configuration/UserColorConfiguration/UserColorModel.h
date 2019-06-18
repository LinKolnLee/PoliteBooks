//
//  UserColorModel.h
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserColorModel : NSObject

/**
 账簿颜色
 */
@property(nonatomic,strong)NSString * image;

/**
 账簿纸张颜色
 */
@property(nonatomic,assign)NSInteger paperColor;

/**
 账簿名称
 */
@property(nonatomic,strong)NSString * bookName;

/**
 账簿创建时间
 */
@property(nonatomic,strong)NSString * bookCreatDate;

/**
 账簿金额总和
 */
@property(nonatomic,strong)NSString * moneySun;

@end

NS_ASSUME_NONNULL_END
