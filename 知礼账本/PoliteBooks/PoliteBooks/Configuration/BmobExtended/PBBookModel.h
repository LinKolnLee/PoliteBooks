//
//  PBBookModel.h
//  PoliteBooks
//
//  Created by llk on 2019/6/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBBookModel : NSObject

@property(nonatomic,strong)NSString * objectId;
/**
 账本纸张颜色
 */
@property(nonatomic,assign)NSInteger bookColor;
/**
 账本名称
 */
@property(nonatomic,strong)NSString * bookName;
/**
 账本名称
 */
@property(nonatomic,strong)NSString * bookDate;

/**
 进礼金额
 */
@property(nonatomic,assign)NSInteger bookOutMoney;

/**
 收礼金额
 */
@property(nonatomic,assign)NSInteger bookInMoney;
@end

NS_ASSUME_NONNULL_END
