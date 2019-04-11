//
//  CreatBookView.h
//  PoliteBooks
//
//  Created by llk on 2019/1/18.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreatBookView : UIView
@property (copy , nonatomic) void(^CreatBookViewSaveButtonClickBlock)(NSString * bookName,NSString * bookData,NSInteger bookColor);

/// 书本名称
@property (nonatomic, strong) UITextField *bookNameTextField;
@end

NS_ASSUME_NONNULL_END
