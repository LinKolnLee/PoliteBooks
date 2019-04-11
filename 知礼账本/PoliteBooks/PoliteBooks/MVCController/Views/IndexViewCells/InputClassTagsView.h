//
//  InputClassTagsView.h
//  PoliteBooks
//
//  Created by llk on 2019/1/14.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputClassTagsView : UIView

@property (copy , nonatomic) void(^InputClassTagsViewCellTypeClickBlock)(NSInteger colorIndex);


@end

NS_ASSUME_NONNULL_END
