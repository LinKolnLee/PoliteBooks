//
//  EveryDayHomeViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "EveryDayHomeViewController.h"
#import "HomeHeader.h"
#import "AccentDetailTableViewCell.h"
#import "AccountDetailSectionView.h"
#import "EveryDayChartViewController.h"
#import "ScreeningViewController.h"
@interface EveryDayHomeViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;
@property(nonatomic,strong)NSMutableArray<NSMutableArray<PBWatherModel *> *> * dataSource;
@property(nonatomic,strong)HomeHeader * headView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSDate * selectData;
@property(nonatomic,strong)UIView * lineView;
@end
@implementation EveryDayHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.tableView];
    self.dataSource = [[NSMutableArray alloc] init];
    self.selectData = [NSDate new];
    [self addMasonry];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self queryWatherDatasourceListWithDate:[NSDate new]];
    self.headView.date = [NSDate new];
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationHeight);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.title = @"日常流水";
        _naviView.titleFont = kFont18;
        _naviView.leftImage = @"Screening";
        _naviView.rightImage = @"BookChars";
        _naviView.isShadow = NO;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            ScreeningViewController * screening = [[ScreeningViewController alloc] init];
           [weakSelf.navigationController hh_pushTiltViewController:screening];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            EveryDayChartViewController * chart = [[EveryDayChartViewController alloc] init];
            [weakSelf.navigationController hh_pushErectViewController:chart];
        };
    }
    return _naviView;
}
-(HomeHeader *)headView{
    if (!_headView) {
        _headView = [HomeHeader loadFirstNib:CGRectMake(0, kNavigationHeight, ScreenWidth, kIphone6Width(64))];
        _headView.date = [NSDate new];
        WS(weakSelf);
        _headView.everyDayHeadViewCellBtnSelectBlock = ^(NSDate * _Nonnull date) {
            weakSelf.selectData = date;
            [weakSelf queryWatherDatasourceListWithDate:date];
        };
    }
    return _headView;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kBlackColor;
    }
    return _lineView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight + kIphone6Width(64) + 1, ScreenWidth, ScreenHeight - kTabBarSpace - kIphone6Width(64) - kTabbarHeight - kNavigationHeight) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.backgroundColor = kWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.layer.cornerRadius = kIphone6Width(10);
        _tableView.layer.masksToBounds = YES;
        [_tableView registerClass:[AccentDetailTableViewCell class] forCellReuseIdentifier:@"AccentDetailTableViewCell"];
        [_tableView registerClass:[AccountDetailSectionView class] forHeaderFooterViewReuseIdentifier:@"AccountDetailSectionView"];
       // _tableView.hidden = YES;
        /*
        WS(weakSelf);
        _tableView.mj_header = [PBRefreshHead headerWithRefreshingBlock:^{
            NSString * dateStr = [weakSelf.selectData timeToString];
            NSArray * dateArr = [dateStr componentsSeparatedByString:@"-"];
            NSInteger  nextMonthDate = 0;
            NSInteger  nextYearDate = 0;
            if ([dateArr[1] integerValue] > 1) {
                nextYearDate = [dateArr[0] integerValue];
                nextMonthDate = [dateArr[1] integerValue] - 1;
            }else{
                nextMonthDate = 12;
                nextYearDate = [dateArr[0] integerValue] - 1;
            }
            NSString * newDate = [NSString stringWithFormat:@"%ld-%ld-%@",nextYearDate,nextMonthDate,dateArr[2]];
            
            [weakSelf queryWatherDatasourceListWithDate:[newDate getStringDate]];
        }];
        _tableView.mj_footer = [PBRefreshFooter footerWithRefreshingBlock:^{
            NSString * dateStr = [weakSelf.selectData timeToString];
            NSArray * dateArr = [dateStr componentsSeparatedByString:@"-"];
            NSInteger  nextMonthDate = 0;
            NSInteger  nextYearDate = 0;
            if ([dateArr[1] integerValue] < 12) {
                nextYearDate = [dateArr[0] integerValue];
                nextMonthDate = [dateArr[1] integerValue] + 1;
            }else{
                nextMonthDate = 1;
                nextYearDate = [dateArr[0] integerValue] + 1;
            }
            NSString * newDate = [NSString stringWithFormat:@"%ld-%ld-%@",nextYearDate,nextMonthDate,dateArr[2]];
            [weakSelf queryWatherDatasourceListWithDate:[newDate getStringDate]];
        }];
         */
    }
    return _tableView;
}
-(void)queryWatherDatasourceListWithDate:(NSDate *)date{
    WS(weakSelf);
    [self showLoadingAnimation];
    [PBWatherExtension queryDayBookListWithDate:date success:^(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull bookList) {
         [weakSelf hiddenLoadingAnimation];
        weakSelf.dataSource = bookList;
        weakSelf.headView.dataSource = bookList;
        [weakSelf.tableView reloadData];
    } fail:^(id _Nonnull error) {
        
    }];
}
#pragma mark Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource[section].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccentDetailTableViewCell"];
    if (cell == nil) {
        cell = [[AccentDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AccentDetailTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.section][indexPath.row];
    return cell;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kIphone6Width(50);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AccountDetailSectionView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AccountDetailSectionView"];
    if(!sectionHeadView){
        sectionHeadView = [[AccountDetailSectionView alloc] initWithReuseIdentifier:@"AccountDetailSectionView"];
     }
    sectionHeadView.models = self.dataSource[section];
    return sectionHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//左滑删除 和编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //
        [PBWatherExtension delegateDataForModel:weakSelf.dataSource[indexPath.section][indexPath.row] success:^(id  _Nonnull responseObject) {
            [weakSelf queryWatherDatasourceListWithDate:weakSelf.selectData];
        }];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

@end
