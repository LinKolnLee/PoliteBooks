//
//  UITextField+Extension.h
//  FindDrug
//
//  Created by Admin on 2017/11/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

/**
 验证是否是手机号

 @return YES/NO;
 */
-(BOOL)isAvailablePhone;

/**创建普通textField*/
+ (UITextField *)textFieldWithFrame:(CGRect)frame TextColor:(UIColor *)textColor textFont:(UIFont *)textFont isClear:(BOOL)isClear textAlignment:(NSTextAlignment)textAlignment;
/**创建带左面图片的textField*/
+ (UITextField *)textFieldWithFrame:(CGRect)frame textColor:(UIColor *)textColor textFont:(NSInteger)textFont placeHolder:(NSString *)placeHolder image:(UIImage *)image;
/**创建带左面文字的textField*/
+ (UITextField *)textFieldWithFrame:(CGRect)frame textColor:(UIColor *)textColor textFont:(NSInteger)textFont placeHolder:(NSString *)placeHolder title:(NSString *)title;

/**设置最大的输入长度 使用此方法不可再使用addTaget:action:forControlEvents:*/
- (void)setMaxStringLength:(NSInteger)maxLength;

/**设置最大的输入长度 以及达到最大长度的回调 使用此方法不可再使用addTaget:action:forControlEvents:*/
- (void)setMaxStringLength:(NSInteger)maxLength alreadyReachedItsMaximum:(void(^)(BOOL reached))reachBlock;


/**设置查看密码模式*/
- (void)setCheckPasswordModel:(BOOL)check;

/**监测输入框是否为空*/
- (void)monitorTextIsEmpty:(void (^)(BOOL empty))emptyBlock;
@end
