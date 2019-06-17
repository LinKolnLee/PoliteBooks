//
//  MineChartCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/6/14.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "MineChartCollectionViewCell.h"
#import "AAChartKit.h"

@interface MineChartCollectionViewCell()

@property (nonatomic, strong) AAChartView *aaChartView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSMutableArray * colorArray;

@property(nonatomic,strong)UILabel * noDataLabel;

@property(nonatomic,strong)NSString * title;

@end
@implementation MineChartCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dataArray = [[NSMutableArray alloc] init];
        self.colorArray = [[NSMutableArray alloc] init];
        self.title = @"";
        [self.contentView addSubview:self.noDataLabel];
    }
    return self;
}
-(UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth - 80 , 30)];
        _noDataLabel.font = kPingFangTC_Light(15);
        _noDataLabel.text = @"您还没有该创建账单，无法进行分析~";
        _noDataLabel.textColor = kHexRGB(0x3f3f4d);
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        _noDataLabel.hidden = YES;
    }
    return _noDataLabel;
}
-(AAChartView *)aaChartView{
    if (!_aaChartView) {
        _aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _aaChartView.scrollEnabled = NO;
    }
    return _aaChartView;
}
- (AAOptions *)configureChartWithBackgroundImage:(NSMutableArray *)datas {
    AAChartModel *aaChartModel= AAChartModel.new
    .chartTypeSet(AAChartTypePie)
    .titleSet(@"")
    .subtitleSet(self.title)
    .dataLabelEnabledSet(true)//是否直接显示扇形图数据
    .yAxisTitleSet(@"摄氏度")
    .colorsThemeSet(self.colorArray)
    .seriesSet(
               @[AASeriesElement.new
                 .nameSet(@"金额占比")
                 .dataSet(datas),
                 ]
               )
    ;
    
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    //aaOptions.chart.plotBackgroundImage = @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2859216016,2109779587&fm=27&gp=0.jpg";
    return aaOptions;
}
-(void)setBookModels:(NSMutableArray<PBBookModel *> *)bookModels{
    [self.dataArray removeAllObjects];
    [self.colorArray removeAllObjects];
    _bookModels = bookModels;
    NSInteger inMoney = 0;
    NSInteger outMoney = 0;
    for (PBBookModel * model in bookModels) {
        inMoney = inMoney + model.bookInMoney;
        outMoney = outMoney + model.bookOutMoney;
    }
    if (bookModels.count == 0) {
        self.aaChartView.hidden = YES;
        self.noDataLabel.hidden = NO;
    }else if (!outMoney && !self.index){
        self.aaChartView.hidden = YES;
        self.noDataLabel.hidden = NO;
    }else if (!inMoney && self.index){
        self.aaChartView.hidden = YES;
        self.noDataLabel.hidden = NO;
    }else{
        self.aaChartView.hidden = NO;
        self.noDataLabel.hidden = YES;
        [self addSubview:self.aaChartView];
        for (PBBookModel * model in bookModels) {
            if (self.index) {
                [self.dataArray addObject:@[model.bookName,@(model.bookInMoney)]];
            }else{
                [self.dataArray addObject:@[model.bookName,@(model.bookOutMoney)]];
            }
            [self.colorArray addObject:TypeColorStr[model.bookColor]];
        }
        AAOptions *aaOptions = [self configureChartWithBackgroundImage:self.dataArray];
        [self.aaChartView aa_drawChartWithOptions:aaOptions];
    }
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    if (index) {
        self.title = @"收礼金额分析";
    }else{
        self.title = @"进礼金额分析";
    }
}
@end
