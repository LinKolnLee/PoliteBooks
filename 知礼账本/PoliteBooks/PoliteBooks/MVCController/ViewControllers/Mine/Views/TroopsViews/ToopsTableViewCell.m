//
//  ToopsTableViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/7/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ToopsTableViewCell.h"
@interface ToopsTableViewCell()

@property (nonatomic, strong) AAChartView *aaChartView;

@property (nonatomic, strong) UILabel *chartSumLab;

@property(nonatomic,strong)NSMutableArray * dayArray;
@property(nonatomic,strong)NSMutableArray * monthArray;

@property(nonatomic,strong)NSMutableArray * moneyArray;
@end
@implementation ToopsTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.chartSumLab];
        [self addSubview:self.aaChartView];
        self.dayArray = [[NSMutableArray alloc] init];
        self.moneyArray = [[NSMutableArray alloc] init];
        //self.monthArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(AAChartView *)aaChartView{
    if (!_aaChartView) {
        _aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, kIphone6Width(25), ScreenWidth , kIphone6Width(300))];
        _aaChartView.scrollEnabled = YES;
        
    }
    return _aaChartView;
}
-(UILabel *)chartSumLab{
    if (!_chartSumLab) {
        _chartSumLab = [[UILabel alloc] init];
        _chartSumLab.frame = CGRectMake(0, 0, ScreenWidth, kIphone6Width(25));
        _chartSumLab.backgroundColor = kWhiteColor;
        _chartSumLab.textColor = kBlackColor;
        _chartSumLab.font = kFont15;
        _chartSumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _chartSumLab;
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
                 .nameSet(@"支出汇总")
                 .dataSet(datas)
                 .colorSet((id)[AAGradientColor configureGradientColorWithStartColorString:@"#555555" endColorString:@"#999999"])
                 .stepSet((id)@true)]
               )
    ;
    aaChartModel
    .categoriesSet(self.dayArray);
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    return aaOptions;
}
-(void)setDataSource:(NSMutableArray<PBWatherModel *> *)dataSource{
    _dataSource = dataSource;
    if (dataSource.count == 0) {
        self.aaChartView.hidden = YES;
        self.chartSumLab.text = [NSString stringWithFormat:@"用户当日未记账"];
        return;
    }
    self.aaChartView.hidden = NO;
    NSMutableArray * dayArr = [[NSMutableArray alloc] init];
    [self.moneyArray removeAllObjects];
    CGFloat priceSum = 0.0;
    for (PBWatherModel * model in dataSource) {
        [dayArr addObject:TypeClassStr[model.type]];
        CGFloat price = [model.price floatValue];
        [self.moneyArray addObject:@[TypeClassStr[model.type],@(price)]];
        priceSum += price;
    }
    self.dayArray = dayArr;
    AAOptions *aaOptions = [self configureChartWithBackgroundImage:self.moneyArray];
    [self.aaChartView aa_drawChartWithOptions:aaOptions];
    self.chartSumLab.text = [NSString stringWithFormat:@"本日支出金额：%.2f",priceSum];
}
-(void)setMonthDataSource:(NSMutableArray *)monthDataSource{
    _monthDataSource = monthDataSource;
    if (monthDataSource.count == 0) {
         self.aaChartView.hidden = YES;
        self.chartSumLab.text = [NSString stringWithFormat:@"用户当月未记账"];
        return;
    }
    self.aaChartView.hidden = NO;
    NSMutableArray * monthArr = [[NSMutableArray alloc] init];
     CGFloat priceSum = 0.0;
    for (NSMutableArray * arr in monthDataSource) {
        [monthArr addObject:arr[0]];
        CGFloat price = [arr[1] floatValue];
        priceSum += price;
    }
    self.dayArray = monthArr;
    AAOptions *aaOptions = [self configureChartWithBackgroundImage:monthDataSource];
    [self.aaChartView aa_drawChartWithOptions:aaOptions];
    self.chartSumLab.text = [NSString stringWithFormat:@"本月支出金额：%.2f",priceSum];
}
-(void)setTitle:(NSString *)title{
    _title = title;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
