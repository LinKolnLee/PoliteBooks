//
//  KeepAccountCollectionViewCell.h
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeepAccountCollectionViewCell : UICollectionViewCell

@property(nonatomic,assign)NSInteger row;


@property (copy , nonatomic) void(^keepAccountCollectionViewCellBtnSelectBlock)(NSInteger row);

@end

NS_ASSUME_NONNULL_END
