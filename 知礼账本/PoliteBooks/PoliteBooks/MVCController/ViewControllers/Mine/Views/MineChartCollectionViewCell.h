//
//  MineChartCollectionViewCell.h
//  PoliteBooks
//
//  Created by llk on 2019/6/14.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineChartCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSMutableArray<PBBookModel *> * bookModels;

@property(nonatomic,assign)NSInteger index;
@end

NS_ASSUME_NONNULL_END
