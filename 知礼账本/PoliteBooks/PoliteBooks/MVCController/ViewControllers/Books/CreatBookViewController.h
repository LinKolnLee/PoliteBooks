//
//  CreatBookViewController.h
//  PoliteBooks
//
//  Created by 宋增宇 on 2019/4/2.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreatBookViewController : BaseViewController

@property (copy , nonatomic) void(^creatBookViewControllerBlock)(void);


@end

NS_ASSUME_NONNULL_END
