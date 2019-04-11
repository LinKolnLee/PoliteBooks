//
//  InputTextView.h
//  PoliteBooks
//
//  Created by llk on 2019/1/14.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputTextView : UIView
/// money
@property (nonatomic, strong) UITextField *numberField;

@property(nonatomic,strong)BooksModel * model;

@end

NS_ASSUME_NONNULL_END
