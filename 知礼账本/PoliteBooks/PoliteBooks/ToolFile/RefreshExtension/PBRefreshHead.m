//
//  PBRefreshHead.m
//  PoliteBooks
//
//  Created by llk on 2019/6/27.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "PBRefreshHead.h"

@implementation PBRefreshHead

+(MJRefreshNormalHeader *)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    [header setTitle:@"查看下个月的账本数据" forState:MJRefreshStateIdle];
    [header setTitle:@"查看下个月的账本数据" forState:MJRefreshStatePulling];
    [header setTitle:@"查看下个月的账本数据" forState:MJRefreshStateRefreshing];
    header.stateLabel.font = kFont15;
    header.stateLabel.textColor =TypeColor[1];
    header.lastUpdatedTimeLabel.hidden = YES;
    return header;
}

@end
