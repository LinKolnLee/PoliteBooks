//
//  ExportExcellViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/19.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ExportExcellViewController.h"
#import "YWExcelView.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
//#import "MFMailComposeViewController.h"
@interface ExportExcellViewController ()<YWExcelViewDataSource,SKPSMTPMessageDelegate>
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)YWExcelView * excelView;

@property(nonatomic,strong)NSMutableArray * dateSourcelist;

@property(nonatomic,strong)NSMutableArray<PBTableModel *> * xlsSourceList;

@end

@implementation ExportExcellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    self.dateSourcelist = [[NSMutableArray alloc] init];
    self.xlsSourceList = [[NSMutableArray alloc] init];
    [self addMasonry];
    [self queryExcelDataSource];
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.titleFont = kFont18;
        _naviView.title = @"导出Excel";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"export";
        _naviView.rightHidden = NO;
        _naviView.isShadow = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            [weakSelf shareXLSFile];
        };
    }
    return _naviView;
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationHeight);
    }];
}
-(void)setupExcelView{
    YWExcelViewMode *mode = [YWExcelViewMode new];
    mode.style = YWExcelViewStyleDefalut;
    mode.headTexts = @[@"账本名称",@"姓名",@"金额",@"进礼",@"收礼",@"关系",@"日期"];
    mode.defalutHeight = 40;
    YWExcelView *exceView = [[YWExcelView alloc] initWithFrame:CGRectMake(0, kNavigationHeight + 10, ScreenWidth, ScreenHeight-kNavigationHeight - 10) mode:mode];
    exceView.showBorderColor = kBlackColor;
    self.excelView = exceView;
    exceView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    exceView.dataSource = self;
    exceView.showBorder = YES;
    [self.view addSubview:exceView];
    
}
//多少行
- (NSInteger)excelView:(YWExcelView *)excelView numberOfRowsInSection:(NSInteger)section{
    return self.dateSourcelist.count;
}
//多少列
- (NSInteger)itemOfRow:(YWExcelView *)excelView{
    return 7;
}
- (void)excelView:(YWExcelView *)excelView label:(UILabel *)label textAtIndexPath:(YWIndexPath *)indexPath{
    if (indexPath.row < self.dateSourcelist.count) {
        NSDictionary *dict = self.dateSourcelist[indexPath.row];
        if (indexPath.item == 0) {
            label.text = dict[@"grade"];
        }else{
            NSArray *values = dict[@"score"];
            label.text = values[indexPath.item - 1];
        }
    }
}
-(void)queryExcelDataSource{
    [self showLoadingAnimation];
    WS(weakSelf);
    [PBTableExtension queryRealtionTableLissuccess:^(NSMutableArray<PBTableModel *> * _Nonnull tableList) {
        [weakSelf hiddenLoadingAnimation];
        weakSelf.xlsSourceList = tableList;
        for (PBTableModel * model in tableList) {
            
            [weakSelf.dateSourcelist addObject:@{@"grade":model.userType,@"score":@[model.userName,[model.userMoney getCnMoney],[NSString stringWithFormat:@"%ld",model.outType],[NSString stringWithFormat:@"%ld",model.inType],model.userRelation,model.userDate]}];
        }
        [weakSelf setupExcelView];
        if (self.dateSourcelist.count == 0) {
            self.naviView.rightHidden = YES;
        }else{
            self.naviView.rightHidden = NO;
        }
        
    } fail:^(id _Nonnull error) {
        [weakSelf hiddenLoadingAnimation];
    }];
}

- (void)shareXLSFile {
    [self showLoadingAnimation];
    // 创建存放XLS文件数据的数组
    NSMutableArray * headArray = [NSMutableArray arrayWithObjects:@"账本名称",@"姓名",@"金额",@"进礼",@"收礼",@"关系",@"日期", nil];
    // 100行数据
    for (int i = 0; i < self.xlsSourceList.count; i ++) {
        [headArray addObject:self.xlsSourceList[i].userType];
        [headArray addObject:self.xlsSourceList[i].userName];
        [headArray addObject:[self.xlsSourceList[i].userMoney getCnMoney]];
        [headArray addObject:[NSString stringWithFormat:@"%ld",self.xlsSourceList[i].outType]];
        [headArray addObject:[NSString stringWithFormat:@"%ld",self.xlsSourceList[i].inType]];
        [headArray addObject:self.xlsSourceList[i].userRelation];
        [headArray addObject:self.xlsSourceList[i].userDate];
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
        if ( i > 0 && (i%7 == 0) ) {
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
    [self hiddenLoadingAnimation];
    [self setupEmailNumberWithPath:filePath];
}
-(void)setupEmailNumberWithPath:(NSString *)filePath{
    __block UITextField *tf = nil;
    [LEEAlert alert].config
    .LeeTitle(@"请输入您的邮箱地址")
    .LeeContent(@"稍后会报Excel邮件发送到您的邮箱,大概需要1-2个小时")
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
            [self sendEmailWithPath:filePath andEmail:tf.text];
        }
    })
    
    .LeeShow();
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
    [ToastManage showTopToastWith:@"邮件发送失败"];
}


@end
