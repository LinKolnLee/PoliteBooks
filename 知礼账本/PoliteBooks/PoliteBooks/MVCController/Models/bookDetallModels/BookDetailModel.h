//
//  BookDetailModel.h
//  PoliteBooks
//
//  Created by llk on 2019/1/18.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookDetailModel : NSObject

/**
 出账id
 */
@property(nonatomic,strong)NSString * bookDetailId;

/**
 出账姓名
 */
@property(nonatomic,strong)NSString * userName;

/**
 出账金额
 */
@property(nonatomic,strong)NSString * money;

/**
 出账日期
 */
@property(nonatomic,strong)NSString * dataString;

/**
 是否本人
 */
@property(nonatomic,strong)NSString * selfType;

/**
 出账类型
 */
@property(nonatomic,strong)NSString * classType;


@end

NS_ASSUME_NONNULL_END
