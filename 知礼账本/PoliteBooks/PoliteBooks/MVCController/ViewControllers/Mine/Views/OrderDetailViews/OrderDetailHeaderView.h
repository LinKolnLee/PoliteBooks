//
//  OrderDetailHeaderView.h
//  PoliteBooks
//
//  Created by llk on 2019/7/16.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailHeaderView : UIView
@property(nonatomic,strong)NSMutableArray<NSMutableArray<PBWatherModel *> *> * dataSource;
@end

NS_ASSUME_NONNULL_END
