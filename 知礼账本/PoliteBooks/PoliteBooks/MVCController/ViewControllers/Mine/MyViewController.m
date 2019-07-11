//
//  MyViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/7/1.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "MyViewController.h"
#import "MyHeadView.h"
#import <Social/Social.h>
#import "GuideViewController.h"
#import "DateViewController.h"
#import "SearchViewController.h"
#import "WKWebViewController.h"
#import "FeedbackViewController.h"
#import "ExportExcellViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"
#import "MyTableViewSectionView.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MyHeadView * headView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)NSMutableArray<PBBookModel *> * dataSource;
@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * orderDataSource;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.orderDataSource =[[NSMutableArray alloc] init];
    self.titles = @[@"查看日历",@"礼账搜索",@"意见反馈",@"注册协议",@"隐私政策",@"关于虾米"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![BmobUser currentUser].mobilePhoneNumber){
        self.headView.login = NO;
    }else{
        self.headView.login = YES;
    }
    [self queryWaterList];
    [self queryBookList];
    [self queryMonthList];
}
-(MyHeadView *)headView{
    if (!_headView) {
        _headView = [[MyHeadView alloc] init];
        WS(weakSelf);
        _headView.myHeadViewBtnSelectBlock = ^{
            if (![BmobUser currentUser].mobilePhoneNumber) {
                LoginViewController * login = [[LoginViewController alloc] init];
                [weakSelf.navigationController hh_pushErectViewController:login];
            }else{
                [weakSelf loginOut];
            }
        };
    }
    return _headView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kTabBarSpace  - kTabbarHeight) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.bounces = NO;
        _tableView.backgroundColor = kWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableHeaderView = self.headView;
        _tableView.tableHeaderView.height = kIphone6Width(200);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[MyTableViewSectionView class] forHeaderFooterViewReuseIdentifier:@"MyTableViewSectionView"];
    }
    return _tableView;
}
#pragma make TableViewDelegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kIphone6Width(50);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    cell.textLabel.font = kFont15;
    cell.textLabel.textColor = kHexRGB(0X020D1B);
    cell.detailTextLabel.textColor = kHexRGB(0X999999);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.detailTextLabel.font = kFont14;
//    NSString * currentVolum = [NSString stringWithFormat:@"%.2fMB",[self filePath]];
//    cell.detailTextLabel.text = currentVolum;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            DateViewController * date = [[DateViewController alloc] init];
            [self.navigationController hh_presentBackScaleVC:date height:ScreenHeight-kIphone6Width(230) completion:nil];
        }
            break;
//        case 1:
//        {
//            ExportExcellViewController * export = [[ExportExcellViewController alloc] init];
//            [self.navigationController hh_pushBackViewController:export];
//        }
//            break;
        case 1:
        {
            SearchViewController * searchVc = [[SearchViewController alloc] init];
            [self.navigationController hh_pushBackViewController:searchVc];
        }
            break;
        case 2:
        {
            FeedbackViewController * feedBack = [[FeedbackViewController alloc] init];
            [self.navigationController hh_pushBackViewController:feedBack];
        }
            break;
        case 3:
        {
            WKWebViewController *webVC = [[WKWebViewController alloc] init];
            webVC.titleStr  = @"注册协议";
            webVC.urlStr = [[[NSBundle mainBundle] URLForResource:@"RegistrationAgreement.html" withExtension:nil] absoluteString];
            [self.navigationController pushViewController:webVC  animated:NO];
        }
            break;
        case 4:
        {
            WKWebViewController *webVC = [[WKWebViewController alloc] init];
            webVC.titleStr  = @"隐私政策";
            webVC.urlStr = [[[NSBundle mainBundle] URLForResource:@"PrivacyAgreement.html" withExtension:nil] absoluteString];
            [self.navigationController pushViewController:webVC  animated:NO];
        }
            break;
        case 5:
        {
            AboutViewController * about = [[AboutViewController alloc] init];
            about.dataSource = self.dataSource;
            [self.navigationController hh_pushBackViewController:about];
        }
            break;
            
        default:
            break;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyTableViewSectionView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyTableViewSectionView"];
    if(!sectionHeadView){
        sectionHeadView = [[MyTableViewSectionView alloc] initWithReuseIdentifier:@"MyTableViewSectionView"];
    }
    sectionHeadView.backgroundColor = kWhiteColor;
    sectionHeadView.model = self.orderDataSource;
    //WS(weakSelf);
    sectionHeadView.myTableViewSectionViewGotoButtonBlock = ^{
        
    };
    return sectionHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kIphone6Width(100);
}
-(void)queryBookList{
    //[self showLoadingAnimation];
    WS(weakSelf);
    [BmobBookExtension queryBookListsuccess:^(NSMutableArray<PBBookModel *> * _Nonnull bookList) {
       // [weakSelf hiddenLoadingAnimation];
        weakSelf.dataSource = bookList;
        weakSelf.headView.politeNum = bookList.count;
        [weakSelf.tableView reloadData];
    } fail:^(id _Nonnull error) {
        //[weakSelf hiddenLoadingAnimation];
    }];
}
-(void)queryWaterList{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"userWatherTables"];
    bquery.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    BmobUser *author = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:kMemberInfoManager.objectId];
    //添加作者是objectId为vbhGAAAY条件
    [bquery whereKey:@"author" equalTo:author];
    WS(weakSelf);
    [bquery countObjectsInBackgroundWithBlock:^(int number,NSError  *error){
        weakSelf.headView.watherNum = number;
    }];
}
-(void)queryMonthList{
    WS(weakSelf);
    [PBWatherExtension queryMonthOrderListWithDate:[NSDate new] success:^(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull bookList) {
        if (bookList.count != 0) {
            weakSelf.orderDataSource = bookList[0];
            [weakSelf.tableView reloadData];
        }
    } fail:^(id _Nonnull error) {
    }];
}
-(void)loginOut{
    WS(weakSelf);
    [LEEAlert alert].config
    .LeeAddTitle(^(UILabel *label) {
        label.text = @"确认退出?";
        label.textColor = kBlackColor;
    })
    .LeeAddContent(^(UILabel *label) {
        label.text = @"退出后将无法同步数据";
        label.textColor = [kBlackColor colorWithAlphaComponent:0.75f];
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeCancel;
        action.title = @"取消退出";
        action.titleColor = kColor_Main_Color;
        action.backgroundColor = kBlackColor;
        action.clickBlock = ^{
        };
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeDefault;
        action.title = @"退出";
        action.titleColor = kColor_Main_Color;
        action.backgroundColor = kBlackColor;
        action.clickBlock = ^{
            
            [BmobUser logout];
            kMemberInfoManager.objectId = 0;
            [UserManager showUserLoginView];
            [ToastManage showTopToastWith:@"账户已退出登陆"];
            weakSelf.headView.login = NO;
        };
    })
    .LeeHeaderColor(kColor_Main_Color)
    .LeeShow();
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
