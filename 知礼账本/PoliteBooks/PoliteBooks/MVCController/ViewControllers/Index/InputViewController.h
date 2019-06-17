//
//  InputViewController.h
//  PoliteBooks
//
//  Created by llk on 2019/1/14.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputViewController : BaseViewController

@property(nonatomic,strong)PBBookModel * bookModel;

@property (copy , nonatomic) void(^InputViewControllerPopBlock)(void);

@property(nonatomic,strong)PBTableModel * tableModel;

@property(nonatomic,assign)BOOL isEdit;
@end

NS_ASSUME_NONNULL_END
