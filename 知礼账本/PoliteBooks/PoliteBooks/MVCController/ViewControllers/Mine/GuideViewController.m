//
//  GuideViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/4/28.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "GuideViewController.h"
#import "TABCardView.h"
#import "CardView.h"
@interface GuideViewController ()<TABCardViewDelegate>

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property (nonatomic,strong) TABCardView * cardView;

@property(nonatomic,strong) UILabel * stateLabel;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
self.cardView = [[TABCardView alloc] initWithFrame:CGRectMake(ScreenWidth/4, (ScreenHeight - 320)/2, ScreenWidth * 0.5, ScreenHeight * 0.5)
                                       showCardsNumber:4];
    self.cardView.isShowNoDataView = YES;
    self.cardView.noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"占位图"]];
    self.cardView.delegate = self;
    //self.view.backgroundColor = TypeColor[5];
    [self getData];
    [self.view addSubview:self.cardView];
    [self.view addSubview:self.stateLabel];
    // Do any additional setup after loading the view.
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 74)];
        _naviView.title = @"新手引导";
        _naviView.titleFont = kFont16;
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"BookChars";
        _naviView.rightHidden = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _naviView;
}
-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ScreenHeight-100, ScreenWidth - 20, 55)];
        _stateLabel.font = kPingFangTC_Light(15);
        _stateLabel.text = @"账簿目录列表： 可以查看和删除账簿";
        _stateLabel.textColor = TypeColor[5];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.numberOfLines  =0;
    }
    return _stateLabel;
}
#pragma mark - Target Method

- (void)getData {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i ++) {
        CardView *view = [[CardView alloc] init];
        [view updateViewWithData:[NSString stringWithFormat:@"%d.PNG",i+1]];
        view.clickBlock = ^{
           // NSLog(@"点击了卡片");
        };
        [array addObject:view];
    }
    NSMutableArray * newArr = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    [self.cardView loadCardViewWithData:newArr];
}

#pragma mark - TABCardViewDelegate

- (void)tabCardViewCurrentIndex:(NSInteger)index {
    //NSLog(@"当前处于卡片数组下标:%ld",(long)index);
    switch (index) {
        case 0:
            {
                self.stateLabel.text = @"记账页面：可以输入金额、姓名、日期";
            }
            break;
        case 1:
        {
            self.stateLabel.text = @"日期页面：可以查看当前的日期，农历或者阳历";
        }
            break;
        case 2:
        {
            self.stateLabel.text = @"图示页面：可以查看各个账簿金额所占的比例";
        }
            break;
        case 3:
        {
             self.stateLabel.text = @"账簿详情页面：可以查看和删除当前账簿里的每一条详细信息";
        }
            break;
        case 4:
        {
           self.stateLabel.text = @"新建账簿页面：点击左边颜色条可以创建不同颜色的账簿";
        }
            break;
        case 5:
        {
            self.stateLabel.text = @"账簿目录列表： 可以查看和删除账簿";
        }
            break;
            
        default:
            break;
    }
    
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
