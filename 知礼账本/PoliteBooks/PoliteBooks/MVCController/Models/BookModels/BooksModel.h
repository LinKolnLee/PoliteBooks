//
//  BooksModel.h
//  PoliteBooks
//
//  Created by llk on 2019/1/18.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BooksModel : NSObject

/**
 账簿
 */
@property(nonatomic,assign)NSInteger  bookId;

/**
 账簿名称
 */
@property(nonatomic,strong)NSString * bookName;

/**
 账簿图片
 */
@property(nonatomic,assign)NSInteger  bookImage;

/**
 账簿日期
 */
@property(nonatomic,strong)NSString * bookDate;

/**
 账簿金额
 */
@property(nonatomic,strong)NSString * bookMoney;

/**
 名称
 */
@property(nonatomic,strong)NSString * name;

/**
 金额
 */
@property(nonatomic,strong)NSString *money;

/**
 日期
 */
@property(nonatomic,strong)NSString *data;

/**
 是否本人
 */
@property(nonatomic,strong)NSString *isself;

/**
 类别
 */
@property(nonatomic,assign)NSInteger tableType;
@end

NS_ASSUME_NONNULL_END
