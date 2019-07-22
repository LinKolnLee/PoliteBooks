/**
 * 头视图
 * @author 郑业强 2018-12-16 创建文件
 */

#import "HomeHeader.h"
#import "WSDatePickerView.h"


#pragma mark - 声明
@interface HomeHeader()
@property (weak, nonatomic) IBOutlet UILabel *yearLab;
@property (weak, nonatomic) IBOutlet UILabel *incomeDescLab;
@property (weak, nonatomic) IBOutlet UILabel *payDescLab;
@property (weak, nonatomic) IBOutlet UILabel *monthLab;
@property (weak, nonatomic) IBOutlet UILabel *monthDescLab;
@property (weak, nonatomic) IBOutlet UILabel *incomeLab;
@property (weak, nonatomic) IBOutlet UILabel *payLab;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setConstraintL;
@property (weak, nonatomic) IBOutlet UIView *monthView;

@end


#pragma mark - 实现
@implementation HomeHeader


- (void)initUI {
    [self setBackgroundColor:kColor_Main_Color];
    self.yearLab.font = kPingFangSC_Semibold(12);
    [self.yearLab setTextColor:kColor_Text_Black];
    self.monthLab.font = kPingFangSC_Semibold(20);
    [self.monthLab setTextColor:kColor_Text_Black];
    self.payDescLab.font = kPingFangSC_Semibold(12);
    [self.payDescLab setTextColor:kColor_Text_Black];
    self.incomeDescLab.font = kPingFangSC_Semibold(12);
    [self.incomeDescLab setTextColor:kColor_Text_Black];
    self.monthDescLab.font = kPingFangSC_Semibold(12)
    [self.monthDescLab setTextColor:kColor_Text_Black];
    [self.line setBackgroundColor:kHexRGB(0x999999)];
    [self.lineConstraintL setConstant:ScreenWidth / 4];
    self.incomeLab.font = kPingFangSC_Semibold(12)
    [self.incomeLab setTextColor:kColor_Text_Black];
    self.payLab.font = kPingFangSC_Semibold(12)
    [self.payLab setTextColor:kColor_Text_Black];
    [self.payLab setAttributedText:[NSAttributedString createMath:@"00.00" integer:kFont14 decimal:kFont12]];
    [self.incomeLab setAttributedText:[NSAttributedString createMath:@"00.00" integer:kFont14 decimal:kFont12]];
    WS(weakSelf);
    [self.monthView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        VIBRATION;
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonth CompleteBlock:^(NSDate *selectDate) {
            if (weakSelf.everyDayHeadViewCellBtnSelectBlock) {
                weakSelf.everyDayHeadViewCellBtnSelectBlock(selectDate);
            }
            [self setDate:selectDate];
        }];
        datepicker.dateLabelColor = kBlackColor;
        datepicker.datePickerColor = kBlackColor;
        datepicker.doneButtonColor = kBlackColor;
        [datepicker show];
    }];
}


#pragma mark - set
- (void)setDate:(NSDate *)date {
    _date = date;
    _yearLab.text = [@(date.year) description];
    _monthLab.text = [@(date.month) description];
}
-(void)setDataSource:(NSMutableArray<NSMutableArray<PBWatherModel *> *> *)dataSource{
    
    _dataSource = dataSource;
    CGFloat payMoneySum = 0.00;
    CGFloat incomeMoneySum = 0.00;
    for (NSMutableArray * arr in dataSource) {
        for (PBWatherModel * model in arr) {
            if (model.moneyType == 0) {
                payMoneySum += [model.price doubleValue];
            }else{
                incomeMoneySum += [model.price doubleValue];
            }
        }
    }
    NSString *pay = [NSString stringWithFormat:@"%.2f", payMoneySum];
    NSString *income = [NSString stringWithFormat:@"%.2f",incomeMoneySum];
    [_payLab setAttributedText:[NSAttributedString createMath:pay integer:kFont14 decimal:kFont12]];
    [_incomeLab setAttributedText:[NSAttributedString createMath:income integer:kFont14 decimal:kFont12]];

}

@end
