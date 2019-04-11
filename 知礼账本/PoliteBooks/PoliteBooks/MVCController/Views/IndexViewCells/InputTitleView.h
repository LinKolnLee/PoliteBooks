//
//  InputContentView.h
//  PoliteBooks
//
//  Created by llk on 2019/1/14.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputTitleView : UIView


/**
 type:
 1：进账
 2：出账
 */
@property (copy , nonatomic) void(^InputTitleViewTouchButtonClickBlock)(NSInteger type);

@property(nonatomic,strong)NSString * title;

@property(nonatomic,assign)NSInteger colorIndex;


@end

NS_ASSUME_NONNULL_END
