//
//  DateViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/4/15.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "DateViewController.h"
#import "SKConstant.h"

@interface DateViewController ()<SKCalendarViewDelegate>

@property (nonatomic, strong) SKCalendarView * calendarView;

@property(nonatomic,strong)UIButton * closeButton;

@property(nonatomic,strong)UIButton * leftButton;

@property(nonatomic,strong)UIButton * rightButton;

@property(nonatomic,strong)UILabel * titleLabel;
@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    [self.view addSubview:self.titleLabel];
    // Do any additional setup after loading the view.
}
#pragma mark - 日历设置
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, 25)];
        _titleLabel.font = kFont20;
        _titleLabel.text = [NSString stringWithFormat:@"知时"];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (SKCalendarView *)calendarView
{
    if (!_calendarView) {
        _calendarView = [[SKCalendarView alloc] initWithFrame:CGRectMake(self.view.center.x - 150,kNavigationHeight, kIphone6Width(300), kIphone6Width(300))];
        _calendarView.layer.cornerRadius = 5;
        _calendarView.layer.borderColor = [UIColor blackColor].CGColor;
        _calendarView.layer.borderWidth = 0.5;
        _calendarView.delegate = self;// 获取点击日期的方法，一定要遵循协议
        _calendarView.calendarTodayTitleColor = [UIColor redColor];// 今天标题字体颜色
        _calendarView.calendarTodayTitle = @"今日";// 今天下标题
        _calendarView.dateColor = TypeColor[4];// 今天日期数字背景颜色
        _calendarView.calendarTodayColor = [UIColor whiteColor];// 今天日期字体颜色
        _calendarView.dayoffInWeekColor = TypeColor[2];
        _calendarView.springColor = [UIColor colorWithRed:48 / 255.0 green:200 / 255.0 blue:104 / 255.0 alpha:1];// 春季节气颜色
        _calendarView.summerColor = [UIColor colorWithRed:18 / 255.0 green:96 / 255.0 blue:0 alpha:8];// 夏季节气颜色
        _calendarView.autumnColor = [UIColor colorWithRed:232 / 255.0 green:195 / 255.0 blue:0 / 255.0 alpha:1];// 秋季节气颜色
        _calendarView.winterColor = [UIColor colorWithRed:77 / 255.0 green:161 / 255.0 blue:255 / 255.0 alpha:1];// 冬季节气颜色
        _calendarView.holidayColor = TypeColor[7];//节日字体颜色
//        self.lastMonth = _calendarView.lastMonth;// 获取上个月的月份
//        self.nextMonth = _calendarView.nextMonth;// 获取下个月的月份
        //self.chineseLabel.text = [NSString stringWithFormat:@"%@%@", self.calendarView.chineseCalendarMonth[self.calendarView.todayInMonth - 1], getNoneNil(self.calendarView.chineseCalendarDay[self.calendarView.todayInMonth])];
    }
    
    return _calendarView;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, kIphone6Width(20), kIphone6Width(20))];
        [_closeButton setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        _closeButton.backgroundColor = kWhiteColor;
        _closeButton.layer.cornerRadius = kIphone6Width(10);
        _closeButton.layer.masksToBounds = YES;
        _closeButton.layer.borderWidth = kIphone6Width(1);
        _closeButton.layer.borderColor = kBlackColor.CGColor;
        [_closeButton addTarget:self action:@selector(closeButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(kIphone6Width(20), kIphone6Width(384), kIphone6Width(30), kIphone6Width(30))];
        [_leftButton setImage:[UIImage imageNamed:@"dateLeftImage"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-kIphone6Width(50), kIphone6Width(384), kIphone6Width(30), kIphone6Width(30))];
        [_rightButton setImage:[UIImage imageNamed:@"rightDateImage"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
-(void)leftButtonTouchUpInside:(UIButton *)sender{
    self.calendarView.checkLastMonth = YES;// 查看上月
    [SKCalendarAnimationManage animationWithView:self.calendarView andEffect:SK_ANIMATION_REVEAL isNext:NO];
}
-(void)rightButtonTouchUpInside:(UIButton *)sender{
     self.calendarView.checkNextMonth = YES;
    [SKCalendarAnimationManage animationWithView:self.calendarView andEffect:SK_ANIMATION_REVEAL isNext:YES];
}
-(void)closeButtonTouchUpInside:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 点击日期
- (void)selectDateWithRow:(NSUInteger)row
{
//    self.chineseMonthAndDayLabel.text = [NSString stringWithFormat:@"%@%@", self.calendarView.chineseCalendarMonth[row], getNoneNil(self.calendarView.chineseCalendarDay[row])];
//    // 获取节日，注意：此处传入的参数为chineseCalendarDay(不包含节日等信息)
//    self.holidayLabel.text = [self.calendarView getHolidayAndSolarTermsWithChineseDay:getNoneNil(self.calendarView.chineseCalendarDay[row])];
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
