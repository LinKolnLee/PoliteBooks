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
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "TroopsViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,SKPSMTPMessageDelegate>
@property(nonatomic,strong)MyHeadView * headView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)NSMutableArray<PBBookModel *> * dataSource;
@property(nonatomic,strong)NSMutableArray<PBTableModel *> * xlsSourceList;
@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * orderDataSource;
@property(nonatomic,strong)NSMutableArray<NSMutableArray<PBWatherModel *> *> * excelDataSource;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.orderDataSource =[[NSMutableArray alloc] init];
    self.xlsSourceList =[[NSMutableArray alloc] init];
    self.titles = @[@"组队记账",@"导出邮件",@"查看日历",@"礼账搜索",@"意见反馈",@"注册协议",@"隐私政策",@"关于虾米"];
    
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
    [self queryTableList];
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
        _tableView.bounces = YES;
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
            TroopsViewController * troops = [[TroopsViewController alloc] init];
            [self.navigationController hh_pushBackViewController:troops];
        }
            break;
        case 1:
        {
            WS(weakSelf);
            [LEEAlert actionsheet].config
            .LeeTitle(@"导出Excel")
            .LeeContent(@"导出流水账、礼账")
            .LeeAction(@"流水账", ^{
                [weakSelf setupEmailNumberWithType:0];
            })
            .LeeAction(@"礼账", ^{
                [weakSelf setupEmailNumberWithType:1];
            })
            .LeeCancelAction(@"取消", nil)
            .LeeBackgroundStyleBlur(UIBlurEffectStyleLight)
            .LeeShow();
        }
            break;
        case 2:
        {
            
            DateViewController * date = [[DateViewController alloc] init];
            [self.navigationController hh_presentBackScaleVC:date height:ScreenHeight-kIphone6Width(230) completion:nil];
        }
            break;
        case 3:
        {
            SearchViewController * searchVc = [[SearchViewController alloc] init];
            [self.navigationController hh_pushBackViewController:searchVc];
        }
            break;
        case 4:
        {
            FeedbackViewController * feedBack = [[FeedbackViewController alloc] init];
            [self.navigationController hh_pushBackViewController:feedBack];
        }
            break;
        case 5:
        {
            WKWebViewController *webVC = [[WKWebViewController alloc] init];
            webVC.titleStr  = @"注册协议";
            webVC.urlStr = [[[NSBundle mainBundle] URLForResource:@"RegistrationAgreement.html" withExtension:nil] absoluteString];
            [self.navigationController pushViewController:webVC  animated:NO];
        }
            break;
        case 6:
        {
            WKWebViewController *webVC = [[WKWebViewController alloc] init];
            webVC.titleStr  = @"隐私政策";
            webVC.urlStr = [[[NSBundle mainBundle] URLForResource:@"PrivacyAgreement.html" withExtension:nil] absoluteString];
            [self.navigationController pushViewController:webVC  animated:NO];
        }
            break;
        case 7:
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
-(void)queryTableList{
    WS(weakSelf);
    [PBTableExtension queryRealtionTableLissuccess:^(NSMutableArray<PBTableModel *> * _Nonnull tableList) {
        [weakSelf hiddenLoadingAnimation];
        weakSelf.xlsSourceList = tableList;
        
    } fail:^(id _Nonnull error) {
        [weakSelf hiddenLoadingAnimation];
    }];
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
            weakSelf.excelDataSource = bookList;
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
#pragma makr 邮件导出
-(void)setupEmailNumberWithType:(NSInteger)type{
    WS(weakSelf);
    __block UITextField *tf = nil;
    [LEEAlert alert].config
    .LeeTitle(@"请输入您的邮箱地址")
    .LeeContent(@"稍后Excel邮件发送到您的邮箱")
    .LeeAddTextField(^(UITextField *textField) {
        textField.placeholder = @"name@163.com";
        textField.textColor = kBlackColor;
        tf = textField;
    })
    .LeeCancelAction(@"取消导出", nil) // 点击事件的Block如果不需要可以传nil
    
    .LeeAction(@"导出", ^{
        if (tf.text.length == 0) {
            [ToastManage showTopToastWith:@"请输入正确的邮箱地址"];
        }else if (![tf.text isEmail]){
            [ToastManage showTopToastWith:@"请输入正确的邮箱地址"];
        }else{
            if (type) {
                [weakSelf setupPBdateSourceEmail:tf.text];
            }else{
                [weakSelf setupExportDataSourceEmail:tf.text];

            }
        }
    })
    .LeeShow();
}
-(void)setupPBdateSourceEmail:(NSString *)email{
    [self showLoadingAnimation];
    NSMutableArray * headArray = [NSMutableArray arrayWithObjects:@"账本名称",@"姓名",@"金额",@"进礼",@"收礼",@"关系",@"日期", nil];
    for (int i = 0; i < self.xlsSourceList.count; i ++) {
        [headArray addObject:self.xlsSourceList[i].userType];
        [headArray addObject:self.xlsSourceList[i].userName];
        [headArray addObject:[self.xlsSourceList[i].userMoney getCnMoney]];
        [headArray addObject:[NSString stringWithFormat:@"%ld",self.xlsSourceList[i].outType]];
        [headArray addObject:[NSString stringWithFormat:@"%ld",self.xlsSourceList[i].inType]];
        [headArray addObject:self.xlsSourceList[i].userRelation];
        [headArray addObject:self.xlsSourceList[i].userDate];
    }
    NSString *fileContent = [headArray componentsJoinedByString:@"\t"];
    NSMutableString *muStr = [fileContent mutableCopy];
    NSMutableArray *subMuArr = [NSMutableArray array];
    for (int i = 0; i < muStr.length; i ++) {
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        if (range.length == 1) {
            [subMuArr addObject:@(range.location)];
        }
    }
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
        if ( i > 0 && (i%7 == 0) ) {
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
        }
    }
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.xls"];
    NSLog(@"文件路径：\n%@",filePath);
    
    // 生成xls文件
    [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
    NSFileHandle * fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [fileHandle seekToEndOfFile];
    
    [fileHandle closeFile];
    [self hiddenLoadingAnimation];
    [self sendEmailWithPath:filePath andEmail:email];
}
-(void)setupExportDataSourceEmail:(NSString *)email{
    [self showLoadingAnimation];
    NSMutableArray * headArray = [NSMutableArray arrayWithObjects:@"日期",@"类别",@"分类",@"金额", nil];
    for (NSMutableArray * datas in self.excelDataSource) {
        for (PBWatherModel * model in datas) {
            [headArray addObject:[NSString stringWithFormat:@"%ld-%ld-%ld",model.year,model.month,model.day]];
            NSString * class = model.moneyType ? @"收入" : @"支出";
            [headArray addObject:class];
            
            NSArray * titles = model.moneyType ? IncomeClassStr : TypeClassStr;
            [headArray addObject:titles[model.type]];
            [headArray addObject:model.price];
        }
    }
    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    NSString *fileContent = [headArray componentsJoinedByString:@"\t"];
    // 字符串转换为可变字符串，方便改变某些字符
    NSMutableString *muStr = [fileContent mutableCopy];
    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    NSMutableArray *subMuArr = [NSMutableArray array];
    for (int i = 0; i < muStr.length; i ++) {
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        if (range.length == 1) {
            [subMuArr addObject:@(range.location)];
        }
    }
    // 替换末尾\t
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
        if ( i > 0 && (i%4 == 0) ) {
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
        }
    }
    // 文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    //使用UTF16才能显示汉字；如果显示为#######是因为格子宽度不够，拉开即可
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    // 文件路径
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.xls"];
    NSLog(@"文件路径：\n%@",filePath);
    
    // 生成xls文件
    [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
    NSFileHandle * fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [fileHandle seekToEndOfFile];
    
    [fileHandle closeFile];
    [self sendEmailWithPath:filePath andEmail:email];
}
-(void)sendEmailWithPath:(NSString *)filePath andEmail:(NSString *)email{
    [self showLoadingAnimation];
    SKPSMTPMessage *myMessage = [[SKPSMTPMessage alloc] init];
    myMessage.fromEmail = @"zhilibook@163.com"; //发送邮箱
    myMessage.toEmail = email; //收件邮箱
    myMessage.relayHost = @"smtp.163.com"; //发送地址host 网易企业邮箱
    myMessage.requiresAuth = YES;
    myMessage.login = @"zhilibook@163.com"; //发送邮箱的用户名
    myMessage.pass = @"liliangkui0";  //发送邮箱的密码
    myMessage.wantsSecure = YES;
    myMessage.subject = @"虾米记账"; //邮件主题
    myMessage.delegate = self;
    // 附件
    NSData *txtData = [NSData dataWithContentsOfFile:filePath];
    if (txtData.length > 0) {
        NSDictionary *txtPart = @{kSKPSMTPPartContentTypeKey:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"虾米记账.xls\"",
                                  kSKPSMTPPartContentDispositionKey:@"attachment;\r\n\tfilename=\"虾米记账.xls\"",
                                  kSKPSMTPPartMessageKey:[txtData encodeBase64ForData],
                                  kSKPSMTPPartContentTransferEncodingKey:@"base64"};
        
        myMessage.parts = [NSArray arrayWithObjects:txtPart, txtPart,nil];
    } else {
        [ToastManage showTopToastWith:@"邮件路径失效"];
        [self hiddenLoadingAnimation];
    }
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [myMessage send];
        [[NSRunLoop currentRunLoop] run]; //这里开启一下runloop要不然重试其他端口的操作不会进行
    });
}
// 发送成功
- (void)messageSent:(SKPSMTPMessage *)message {
    // 邮件发送成功
    [self hiddenLoadingAnimation];
    [ToastManage showTopToastWith:@"邮件发送成功"];
}

// 发送失败
- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error {
    // 邮件发送失败
    [self hiddenLoadingAnimation];
    [ToastManage showTopToastWith:@"请检查邮箱是否正确"];
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
