//
//  ScreeningHeadView.h
//  PoliteBooks
//
//  Created by llk on 2019/7/3.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScreeningHeadView : UIView

@property(nonatomic,strong)NSArray *titles;

@property (copy , nonatomic) void(^screeningHeadViewCollectionViewCellBtnSelectBlock)(NSInteger type);

@end

NS_ASSUME_NONNULL_END
