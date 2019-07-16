//
//  ScreeningClassSubView.m
//  PoliteBooks
//
//  Created by llk on 2019/7/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ScreeningClassSubView.h"
#import "AccentDetailTableViewCell.h"
#import "AccountDetailSectionView.h"
@interface ScreeningClassSubView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SPMultipleSwitch * classTypeSwitch;

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * dataSource;
@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * weeekDataSource;
@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * monthDataSource;
@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * yearDataSource;

@property(nonatomic,assign)NSInteger selectIndex;

@end
@implementation ScreeningClassSubView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.classTypeSwitch];
        [self addSubview:self.tableView];
        self.selectIndex = 1;
        self.dataSource = [[NSMutableArray alloc] init];
        self.weeekDataSource = [[NSMutableArray alloc] init];
        self.monthDataSource = [[NSMutableArray alloc] init];
        self.yearDataSource = [[NSMutableArray alloc] init];
    }
    return self;
}
-(SPMultipleSwitch *)classTypeSwitch{
    if (!_classTypeSwitch) {
        _classTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"周",@"月",@"年"]];
        _classTypeSwitch.frame = CGRectMake(kIphone6Width(10),   10, ScreenWidth-100, kIphone6Width(30));
        _classTypeSwitch.backgroundColor = kWhiteColor;
        _classTypeSwitch.selectedTitleColor = kWhiteColor;
        _classTypeSwitch.titleColor = kHexRGB(0x665757);
        _classTypeSwitch.trackerColor = kBlackColor;
        _classTypeSwitch.contentInset = 5;
        _classTypeSwitch.spacing = 10;
        _classTypeSwitch.titleFont = kFont14;
        [_classTypeSwitch addTarget:self action:@selector(classTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classTypeSwitch;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight - kIphone6Width(180) - kNavigationHeight - 50) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.backgroundColor = kWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.layer.cornerRadius = kIphone6Width(10);
        _tableView.layer.masksToBounds = YES;
        [_tableView registerClass:[AccentDetailTableViewCell class] forCellReuseIdentifier:@"AccentDetailTableViewCell"];
        [_tableView registerClass:[AccountDetailSectionView class] forHeaderFooterViewReuseIdentifier:@"AccountDetailSectionView"];
    }
    return _tableView;
}
-(void)classTypeSwitchAction:(SPMultipleSwitch *)swit{
    self.selectIndex = swit.selectedSegmentIndex + 1;
    switch (swit.selectedSegmentIndex) {
        case 0:
            {
                self.dataSource = self.weeekDataSource;
            }
            break;
        case 1:
        {
            self.dataSource = self.monthDataSource;
        }
            break;
        case 2:
        {
            self.dataSource = self.yearDataSource;
        }
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
    [self starAnimationWithTableView:self.tableView];
}
- (void)starAnimationWithTableView:(UITableView *)tableView {
    
    [TableViewAnimationKit showWithAnimationType:2 tableView:tableView];
}
#pragma mark Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataSource.count !=0) {
         return 1;
    }else{
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccentDetailTableViewCell"];
    if (cell == nil) {
        cell = [[AccentDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AccentDetailTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    cell.screening = YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kIphone6Width(50);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AccountDetailSectionView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AccountDetailSectionView"];
    if(!sectionHeadView){
        sectionHeadView = [[AccountDetailSectionView alloc] initWithReuseIdentifier:@"AccountDetailSectionView"];
    }
    sectionHeadView.models = self.dataSource;
    sectionHeadView.selectIndex = self.selectIndex;
    return sectionHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//左滑删除 和编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)queryScreeningListForType:(NSInteger)type andMoneyType:(NSInteger)moneyType{
    [[BeautyLoadingHUD  shareManager] startAnimating];
    self.classTypeSwitch.selectedSegmentIndex = 0;
    WS(weakSelf);
    [PBWatherExtension queryListWithType:type andMoneyType:moneyType success:^(NSMutableArray<PBWatherModel *> * _Nonnull weekMonets, NSMutableArray<PBWatherModel *> * _Nonnull monthMonets, NSMutableArray<PBWatherModel *> * _Nonnull yearMonets) {
        weakSelf.weeekDataSource = weekMonets;
        weakSelf.monthDataSource = monthMonets;
        weakSelf.yearDataSource = yearMonets;
        weakSelf.dataSource = weekMonets;
        [weakSelf.tableView reloadData];
        [[BeautyLoadingHUD  shareManager] stopAnimating];
        [weakSelf starAnimationWithTableView:weakSelf.tableView];
        
    } fail:^(id _Nonnull error) {
        
    }];
}
@end
