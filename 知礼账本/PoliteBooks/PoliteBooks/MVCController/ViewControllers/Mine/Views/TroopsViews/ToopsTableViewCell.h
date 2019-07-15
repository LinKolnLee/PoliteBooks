//
//  ToopsTableViewCell.h
//  PoliteBooks
//
//  Created by llk on 2019/7/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToopsTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * dataSource;
@property(nonatomic,strong)NSMutableArray * monthDataSource;
@property(nonatomic,strong)NSString * title;
@end

NS_ASSUME_NONNULL_END
