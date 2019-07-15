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

@property(nonatomic,strong)NSMutableArray * dayArray;
@property(nonatomic,strong)NSMutableArray * monthArray;

@property(nonatomic,strong)NSMutableArray * moneyArray;
@end
@implementation ToopsTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //self.contentView.backgroundColor = kBlackColor;
        [self addSubview:self.aaChartView];
        self.dayArray = [[NSMutableArray alloc] init];
        self.moneyArray = [[NSMutableArray alloc] init];
        //self.monthArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(AAChartView *)aaChartView{
    if (!_aaChartView) {
        _aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth , kIphone6Width(300))];
        _aaChartView.scrollEnabled = YES;
        
    }
    return _aaChartView;
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
    NSMutableArray * dayArr = [[NSMutableArray alloc] init];
    
    for (PBWatherModel * model in dataSource) {
        [dayArr addObject:TypeClassStr[model.type]];
        CGFloat price = [model.price floatValue];
        [self.moneyArray addObject:@[TypeClassStr[model.type],@(price)]];
    }
    self.dayArray = dayArr;
    AAOptions *aaOptions = [self configureChartWithBackgroundImage:self.moneyArray];
    [self.aaChartView aa_drawChartWithOptions:aaOptions];
}
-(void)setMonthDataSource:(NSMutableArray *)monthDataSource{
    _monthDataSource = monthDataSource;
    NSMutableArray * monthArr = [[NSMutableArray alloc] init];
    for (NSMutableArray * arr in monthDataSource) {
        [monthArr addObject:arr[0]];
    }
    self.dayArray = monthArr;
    AAOptions *aaOptions = [self configureChartWithBackgroundImage:monthDataSource];
    [self.aaChartView aa_drawChartWithOptions:aaOptions];
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
