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
 账本颜色
 */
@property(nonatomic,strong)NSString * image;

/**
 账本纸张颜色
 */
@property(nonatomic,assign)NSInteger paperColor;

/**
 账本名称
 */
@property(nonatomic,strong)NSString * bookName;

/**
 账本创建时间
 */
@property(nonatomic,strong)NSString * bookCreatDate;

/**
 账本金额总和
 */
@property(nonatomic,strong)NSString * moneySun;

@end

NS_ASSUME_NONNULL_END
