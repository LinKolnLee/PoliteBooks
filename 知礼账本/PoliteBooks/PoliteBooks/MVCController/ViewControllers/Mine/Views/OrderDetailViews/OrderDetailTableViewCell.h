//
//  OrderDetailTableViewCell.h
//  PoliteBooks
//
//  Created by llk on 2019/7/16.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * orderDataSource;
@end

NS_ASSUME_NONNULL_END
