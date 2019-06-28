//
//  EveryDayChartHeadView.h
//  PoliteBooks
//
//  Created by llk on 2019/6/27.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EveryDayChartHeadView : UIView

@property (copy , nonatomic) void(^everyDayChartHeadViewSegementSelectBlock)(NSInteger index);

@property(nonatomic,assign)NSInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
