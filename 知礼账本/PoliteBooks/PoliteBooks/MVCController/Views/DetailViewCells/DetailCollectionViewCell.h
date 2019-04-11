//
//  DetailCollectionViewCell.h
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSArray<BooksModel *> * detailDataSource;

@property(nonatomic,strong)NSString * currentTableName;

@property (copy , nonatomic) void(^detailCollectionViewCellCreateBookBlock)(void);

@end

NS_ASSUME_NONNULL_END
