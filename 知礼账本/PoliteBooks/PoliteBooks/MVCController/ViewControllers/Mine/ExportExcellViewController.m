//
//  ExportExcellViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/19.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ExportExcellViewController.h"
#import "YWExcelView.h"
//#import "MFMailComposeViewController.h"
@interface ExportExcellViewController ()<YWExcelViewDataSource>
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
        _naviView.backgroundColor = kWhiteColor;
        _naviView.titleFont = kFont14;
        _naviView.title = @"导出Excel";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"export";
        _naviView.rightHidden = NO;
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
        make.height.mas_equalTo(kIphone6Width(74));
    }];
}
-(void)setupExcelView{
    YWExcelViewMode *mode = [YWExcelViewMode new];
    mode.style = YWExcelViewStyleDefalut;
    mode.headTexts = @[@"账本名称",@"姓名",@"金额",@"进礼",@"收礼",@"关系",@"日期"];
    mode.defalutHeight = 40;
    YWExcelView *exceView = [[YWExcelView alloc] initWithFrame:CGRectMake(0, 84, ScreenWidth, ScreenHeight-100) mode:mode];
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
    [self uploadWithPath:filePath];
}
-(void)uploadWithPath:(NSString *)filePath{
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    BmobFile *file = [[BmobFile alloc]initWithFileName:[NSString stringWithFormat:@"知礼账本_%@.xls",kMemberInfoManager.objectId] withFileData:fileData];
    WS(weakSelf);
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
        //如果文件保存成功，则把文件添加到filetype列
        if (isSuccessful) {
            [weakSelf hiddenLoadingAnimation];
            DLog(@"%@",file.url);
            [weakSelf setupEmailNumber];
        }else{
            //进行处理
            [weakSelf hiddenLoadingAnimation];
        }
    }];
}
-(void)setupEmailNumber{
    __block UITextField *tf = nil;
    [LEEAlert alert].config
    .LeeTitle(@"请输入您的邮箱地址")
    .LeeContent(@"稍后会报Excel邮件发送到您的邮箱,大概需要1-2个小时")
    .LeeAddTextField(^(UITextField *textField) {
        textField.placeholder = @"name@163.com";
        textField.textColor = kBlackColor;
        tf = textField;
    })
    .LeeAction(@"导出", ^{
        if (tf.text.length == 0) {
            [ToastManage showTopToastWith:@"请输入正确的邮箱地址"];
        }else{
            BmobUser * user = [BmobUser currentUser];
            [user setObject:tf.text forKey:@"email"];
            [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                [ToastManage showTopToastWith:@"邮件已经导出成功，请稍后查看"];
            }];
        }
    })
    .LeeCancelAction(@"取消", nil) // 点击事件的Block如果不需要可以传nil
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
