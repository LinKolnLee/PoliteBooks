//
//  PBRefreshFooter.h
//  PoliteBooks
//
//  Created by llk on 2019/6/27.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBRefreshFooter : NSObject
+ (__kindof MJRefreshAutoNormalFooter *)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
@end

NS_ASSUME_NONNULL_END
