//
//  BeautyLoadView.h
//  Beauty
//
//  Created by llk on 2018/8/20.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyLoadView : UIView
- (void)startAnimating;

- (void)stopAnimating;

- (void)startAnimatingWithMessage:(NSString *)message;

//-(void)startAnimatingWithProgress:(CGFloat)value message:(NSString *)message;
@end
