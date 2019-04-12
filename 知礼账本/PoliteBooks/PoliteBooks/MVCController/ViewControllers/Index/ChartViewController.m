//
//  ChartViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/4/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ChartViewController.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"
@interface ChartViewController ()

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;


@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(84);
    }];
    
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0, kIphone6Width(220), ScreenWidth, kIphone6Width(320))];
    [self.view addSubview:chart];
    CGFloat moneySum = 0.00;
    //账本名称
    NSMutableArray * models = [[NSMutableArray alloc] init];
    NSMutableArray * colors = [[NSMutableArray alloc] init];
    NSMutableArray * oldBookNames = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
    for (NSString * monryTableName in oldBookNames) {
        NSArray *personArr = [kDataBase jq_lookupTable:monryTableName dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",[monryTableName stringByReplacingOccurrencesOfString:@"AccountBooks" withString:@""]];
        for (BooksModel * newModel in personArr) {
            moneySum += [newModel.money floatValue];
        }
    }
    for (NSString * tableName in oldBookNames) {
        DVFoodPieModel *model = [[DVFoodPieModel alloc] init];
        NSInteger color = 0;
        NSInteger money = 0;
        NSString * name = @"";
        NSArray *personArr = [kDataBase jq_lookupTable:tableName dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",[tableName stringByReplacingOccurrencesOfString:@"AccountBooks" withString:@""]];
        for (BooksModel * newModel in personArr) {
            money += [newModel.money integerValue];
            color = newModel.tableType;
            name = newModel.bookName;
        }
        model.value = money;
        model.rate = money/moneySum;
        model.name = name;
        if (money != 0) {
            [colors addObject:@(color)];
            [models addObject:model];
        }
    }
    chart.colors = colors;
    chart.dataArray = models;
    
    chart.title = @"账本";
    
    [chart draw];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.backgroundColor = kWhiteColor;
        _naviView.title = @"图示";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"BookChars";
        _naviView.rightHidden = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            //右按钮点击
            ChartViewController * chart = [[ChartViewController alloc] init];
            [weakSelf.navigationController pushViewController:chart animated:YES];
        };
    }
    return _naviView;
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
