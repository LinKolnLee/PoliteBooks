//
//  KeepAccountPuliteCollectionViewCell.h
//  PoliteBooks
//
//  Created by llk on 2019/6/28.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeepAccountPuliteCollectionViewCell : UICollectionViewCell
@property (copy , nonatomic) void(^KeepAccountPuliteCollectionViewCellClickBlock)(PBBookModel * model);

@property (copy , nonatomic) void(^KeepAccountPuliteCollectionViewCellChertBlock)(void);

@property(nonatomic,assign)BOOL request;
@end

NS_ASSUME_NONNULL_END
