//
//  PBWatherModel.h
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBWatherModel : NSObject
@property(nonatomic,strong)NSString * objectId;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger weekNum;
@property (nonatomic, copy  ) NSString *mark;
@property (nonatomic, copy  ) NSString *dateStr;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger moneyType;
@end

NS_ASSUME_NONNULL_END
