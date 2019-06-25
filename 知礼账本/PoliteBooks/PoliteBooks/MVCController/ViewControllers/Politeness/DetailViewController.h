//
//  DetailViewController.h
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : BaseViewController

@property(nonatomic,strong)PBBookModel * bookModel;

@property(nonatomic,assign)BOOL isLook;

@property(nonatomic,strong)NSString * currentTableName;
@end

NS_ASSUME_NONNULL_END
