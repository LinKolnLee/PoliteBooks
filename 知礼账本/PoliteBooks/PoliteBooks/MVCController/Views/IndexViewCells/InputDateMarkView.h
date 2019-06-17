//
//  InputDateMarkView.h
//  PoliteBooks
//
//  Created by llk on 2019/1/14.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputDateMarkView : UIView

@property (copy , nonatomic) void(^InputDateMarkViewTouchClickBlock)(void);
@property (copy , nonatomic) void(^InputDateMarkViewTypeSelectBlock)(NSInteger type);

@property (strong,nonatomic)NSString * titleStr;

@property (nonatomic, strong) UITextField *markTextField;


@end

NS_ASSUME_NONNULL_END
