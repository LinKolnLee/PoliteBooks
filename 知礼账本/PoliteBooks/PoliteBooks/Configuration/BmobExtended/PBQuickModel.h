//
//  PBQuickModel.h
//  PoliteBooks
//
//  Created by llk on 2019/7/1.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBQuickModel : NSObject
@property(nonatomic,strong)NSString * objectId;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger moneyType;
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
