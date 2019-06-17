//
//  PBSearchView.h
//  PoliteBooks
//
//  Created by llk on 2019/6/17.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBSearchView : UIView

@property (copy , nonatomic) void(^serachViewTextfiledReturnBlock)(NSString * str);


@end

NS_ASSUME_NONNULL_END
