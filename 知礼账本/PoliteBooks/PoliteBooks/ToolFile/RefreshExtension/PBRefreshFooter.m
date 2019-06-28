//
//  PBRefreshFooter.m
//  PoliteBooks
//
//  Created by llk on 2019/6/27.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "PBRefreshFooter.h"

@implementation PBRefreshFooter
+(MJRefreshAutoNormalFooter *)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshingBlock];
    [footer setTitle:@"查看上个月的账本数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"查看上个月的账本数据" forState:MJRefreshStatePulling];
    [footer setTitle:@"查看上个月的账本数据" forState:MJRefreshStateRefreshing];
    footer.stateLabel.font = kFont15;
    footer.stateLabel.textColor =TypeColor[1];
    return footer;
}
@end
