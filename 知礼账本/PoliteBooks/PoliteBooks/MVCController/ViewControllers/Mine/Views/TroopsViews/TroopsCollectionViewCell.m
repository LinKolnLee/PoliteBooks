//
//  TroopsCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/7/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "TroopsCollectionViewCell.h"
#import "ToopsTableViewCell.h"
@interface TroopsCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * dayDataSource;

@end
@implementation TroopsCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.tableView];
        self.dayDataSource = [[NSMutableArray alloc] init];
        self.monthDataSource = [[NSMutableArray alloc] init];
    }
    return self;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kNavigationHeight - kIphone6Width(70) - kTabBarSpace) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.backgroundColor = kWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerClass:[ToopsTableViewCell class] forCellReuseIdentifier:@"ToopsTableViewCell"];
//        [_tableView registerClass:[AccountDetailSectionView class] forHeaderFooterViewReuseIdentifier:@"AccountDetailSectionView"];
    }
    return _tableView;
}
#pragma mark Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ToopsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToopsTableViewCell"];
    if (cell == nil) {
        cell = [[ToopsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ToopsTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.dataSource = self.dayDataSource;
        cell.title = @"日汇总";
    }else{
        cell.monthDataSource = self.monthDataSource;
        cell.title = @"月汇总";
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kIphone6Width(330);
}
-(void)setDataSource:(NSMutableArray<PBWatherModel *> *)dataSource{
    _dataSource = dataSource;
    self.dayDataSource = dataSource;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
-(void)setMonthDataSource:(NSMutableArray *)monthDataSource{
    _monthDataSource = monthDataSource;
    [self.tableView reloadData];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
