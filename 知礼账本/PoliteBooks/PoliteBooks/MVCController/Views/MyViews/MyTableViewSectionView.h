//
//  MyTableViewSectionView.h
//  PoliteBooks
//
//  Created by llk on 2019/7/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewSectionView : UITableViewHeaderFooterView
@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * model;

@property (copy , nonatomic) void(^myTableViewSectionViewGotoButtonBlock)(void);
@end

NS_ASSUME_NONNULL_END
