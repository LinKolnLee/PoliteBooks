//
//  EveryDayChartViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/27.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "EveryDayChartViewController.h"
#import "EveryDayChartHeadView.h"
@interface EveryDayChartViewController ()

@property (nonatomic, strong) AAChartView *aaChartView;


@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)EveryDayChartHeadView * headView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSMutableArray<NSString *> * colorArray;

@property(nonatomic,strong)NSMutableArray * monthDataArray;

@property(nonatomic,strong)NSMutableArray<NSString *> * monthColorArray;

@property(nonatomic,strong)NSMutableArray * yearDataArray;

@property(nonatomic,strong)NSMutableArray<NSString *> * yearColorArray;

@end

@implementation EveryDayChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    self.colorArray = [[NSMutableArray alloc] init];
    self.monthDataArray = [[NSMutableArray alloc] init];
    self.monthColorArray = [[NSMutableArray alloc] init];
    self.yearDataArray = [[NSMutableArray alloc] init];
    self.yearColorArray = [[NSMutableArray alloc] init];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.headView];
    [self addMasonry];
    [self requestOutData];
}
-(void)requestOutData{
    [self.dataArray removeAllObjects];
    [self.colorArray removeAllObjects];
    [self.monthDataArray removeAllObjects];
    [self.monthColorArray removeAllObjects];
    [self.yearDataArray removeAllObjects];
    [self.yearColorArray removeAllObjects];
    [self queryForWeekDayWithType:0];
    [self queryForMonthDayWithType:0];
    [self queryForYearDayWithType:0];
}
-(void)requestIncomeData{
    [self.dataArray removeAllObjects];
    [self.colorArray removeAllObjects];
    [self.monthDataArray removeAllObjects];
    [self.monthColorArray removeAllObjects];
    [self.yearDataArray removeAllObjects];
    [self.yearColorArray removeAllObjects];
    [self queryForWeekDayWithType:1];
    [self queryForMonthDayWithType:1];
    [self queryForYearDayWithType:1];
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationHeight);
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.naviView.mas_bottom);
        make.height.mas_equalTo(kIphone6Width(50));
    }];
    
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.title = @"日常流水图表 -> 支出·";
        _naviView.titleFont = kFont16;
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightHidden = YES;
        _naviView.isShadow = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
             [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
        };
        __weak PBIndexNavigationBarView * newNavi = _naviView;

        _naviView.PBIndexNavigationBarViewTitleLabelBlock = ^{
            VIBRATION;
            [LEEAlert actionsheet].config
            .LeeTitle(@"选择")
            .LeeContent(@"选择支出、收入")
            .LeeAction(@"支出", ^{
                
                [weakSelf requestOutData];
                newNavi.title  = @"日常流水图表 -> 支出·";
                weakSelf.headView.selectIndex = 0;
            })
            .LeeAction(@"收入", ^{
                [weakSelf requestIncomeData];
                newNavi.title  = @"日常流水图表 -> 收入·";
                weakSelf.headView.selectIndex = 0;

            })
            .LeeCancelAction(@"取消", nil)
            .LeeBackgroundStyleBlur(UIBlurEffectStyleLight)
            .LeeShow();
        };
    }
    return _naviView;
}
-(EveryDayChartHeadView *)headView{
    if (!_headView ) {
        _headView = [[EveryDayChartHeadView alloc] init];
        WS(weakSelf);
        _headView.everyDayChartHeadViewSegementSelectBlock = ^(NSInteger index) {
            VIBRATION;
            switch (index) {
                case 0:
                    {
                        [weakSelf reloadMonthChatsWithDatas:weakSelf.dataArray whitXDatas:weakSelf.colorArray andName:@"周汇总"];
                    }
                    break;
                case 1:
                {
                    [weakSelf reloadMonthChatsWithDatas:weakSelf.monthDataArray whitXDatas:weakSelf.monthColorArray andName:@"月汇总"];
                }
                    break;
                case 2:
                {
                    [weakSelf reloadMonthChatsWithDatas:weakSelf.yearDataArray whitXDatas:weakSelf.yearColorArray andName:@"年汇总"];
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _headView;
}
-(AAChartView *)aaChartView{
    if (!_aaChartView) {
        _aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(10, 150, ScreenWidth - 20, ScreenHeight - 200)];
        _aaChartView.scrollEnabled = YES;
        
    }
    return _aaChartView;
}

-(void)queryForWeekDayWithType:(NSInteger)type{
    [self showLoadingAnimation];
    WS(weakSelf);
    [PBWatherExtension queryWeekBookListWithDate:[NSDate new]  withType:type success:^(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull bookList) {
        //
        for (NSMutableArray * arr in bookList) {
            CGFloat weekPrice = 0.0;
            NSString * weekNumber = @"";
            for (PBWatherModel * model in arr) {
                weekPrice += [model.price doubleValue];
                weekNumber = [NSString stringWithFormat:@"%ld周",(long)model.weekNum];
            }
           
        [weakSelf.dataArray addObject:@[weekNumber,@(weekPrice)]];
        [weakSelf.colorArray addObject:weekNumber];
        }
        [weakSelf.aaChartView removeFromSuperview];
        [weakSelf.view addSubview:weakSelf.aaChartView];
        AAOptions *aaOptions = [weakSelf configureChartWithBackgroundImage:weakSelf.dataArray];
        [weakSelf.aaChartView aa_drawChartWithOptions:aaOptions];
        [weakSelf hiddenLoadingAnimation];
    } fail:^(id _Nonnull error) {
    }];
}
-(void)queryForMonthDayWithType:(NSInteger)type{
    WS(weakSelf);
    [PBWatherExtension queryMonthBookListWithDate:[NSDate new] withType:type success:^(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull bookList) {
        for (NSMutableArray * arr in bookList) {
            CGFloat monthPrice = 0.0;
            NSString * monthkNumber = @"";
            for (PBWatherModel * model in arr) {
                monthPrice += [model.price doubleValue];
                monthkNumber = [NSString stringWithFormat:@"%ld月",(long)model.month];
            }
            
            [weakSelf.monthDataArray addObject:@[monthkNumber,@(monthPrice)]];
            [weakSelf.monthColorArray addObject:monthkNumber];
        }
    } fail:^(id _Nonnull error) {
        
    }];
}
-(void)queryForYearDayWithType:(NSInteger)type{
    WS(weakSelf);
    [PBWatherExtension queryYearBookListWithDate:[NSDate new] withType:type success:^(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull bookList) {
        for (NSMutableArray * arr in bookList) {
            CGFloat yearPrice = 0.0;
            NSString * yearNumber = @"";
            for (PBWatherModel * model in arr) {
                yearPrice += [model.price doubleValue];
                yearNumber = [NSString stringWithFormat:@"%ld年",(long)model.year];
            }
            
            [weakSelf.yearDataArray addObject:@[yearNumber,@(yearPrice)]];
            [weakSelf.yearColorArray addObject:yearNumber];
        }
    } fail:^(id _Nonnull error) {
        
    }];
}
-(void)reloadMonthChatsWithDatas:(NSMutableArray *)datas whitXDatas:(NSMutableArray *)xDatas andName:(NSString *)name{
    AAChartModel *aaChartModel= AAChartModel.new
    .chartTypeSet(AAChartTypeLine)
    .titleSet(@"")
    .subtitleSet(self.title)
    .dataLabelEnabledSet(true)//是否直接显示扇形图数据
    .yAxisTitleSet(@"金额")
    
    //.colorsThemeSet(self.colorArray)
    .seriesSet(
               @[AASeriesElement.new
                 .nameSet(name)
                 .dataSet(datas)
                 .colorSet((id)[AAGradientColor configureGradientColorWithStartColorString:@"#555555" endColorString:@"#999999"])
                 .stepSet((id)@true)]
               )
    ;
    aaChartModel
    .categoriesSet(xDatas);
    [self.aaChartView aa_refreshChartWithChartModel:aaChartModel];
}
- (AAOptions *)configureChartWithBackgroundImage:(NSMutableArray *)datas {
    AAChartModel *aaChartModel= AAChartModel.new
    .chartTypeSet(AAChartTypeLine)
    .titleSet(@"")
    .subtitleSet(self.title)
    .dataLabelEnabledSet(true)//是否直接显示扇形图数据
    .yAxisTitleSet(@"金额")
    
    //.colorsThemeSet(self.colorArray)
    .seriesSet(
               @[AASeriesElement.new
                 .nameSet(@"周汇总")
                 .dataSet(datas)
                 .colorSet((id)[AAGradientColor configureGradientColorWithStartColorString:@"#555555" endColorString:@"#999999"])
                 .stepSet((id)@true)]
               )
    ;
    aaChartModel
    .categoriesSet(self.colorArray);
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    return aaOptions;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
