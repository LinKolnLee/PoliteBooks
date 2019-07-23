//
//  OrderDetailViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/7/16.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailHeaderView.h"
#import "OrderDetailTableViewCell.h"
#import "OrderDetailTableSectionView.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)OrderDetailHeaderView * headView;

@property(nonatomic,strong)NSMutableArray<PBWatherModel *> * orderDataSource;
@property(nonatomic,strong)NSMutableArray<NSMutableArray<PBWatherModel *> *> * dataSource;

@property(nonatomic,strong)UILabel * shareLabel;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderDataSource = [[NSMutableArray alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.tableView];
    [self requestDateSource];
    // Do any additional setup after loading the view.
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kNavigationHeight)];
        _naviView.title = @"账单";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"share";
        _naviView.rightHidden = NO;
        _naviView.titleFont = kMBFont16;
        _naviView.isShadow = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
           UIImage * image =  [weakSelf getmakeImageWithView:weakSelf.view andWithSize:CGSizeMake(ScreenWidth, ScreenHeight)];
            if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                UIImage *thumbImage = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.5)];
                
                WXImageObject *ext = [WXImageObject object];
                // 小于10MB
                ext.imageData = imageData;
                
                WXMediaMessage *message = [WXMediaMessage message];
                message.mediaObject = ext;
                //    message.messageExt = @"";
                //    message.messageAction = @"";
                //    message.mediaTagName = @"";
                // 缩略图 小于32KB
                [message setThumbImage:thumbImage];
                
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                req.bText = NO;
                req.message = message;
                VIBRATION;
                [LEEAlert actionsheet].config
                .LeeTitle(@"账单分享")
                .LeeContent(@"选择微信好友、微信朋友圈")
                .LeeAction(@"微信好友", ^{
                    req.scene = WXSceneSession;
                    [WXApi sendReq:req];
                })
                .LeeAction(@"微信朋友圈", ^{
                    req.scene = WXSceneTimeline;
                    [WXApi sendReq:req];
                })
                .LeeCancelAction(@"取消", nil)
                .LeeBackgroundStyleBlur(UIBlurEffectStyleLight)
                .LeeShow();
            }
        };
    }
    return _naviView;
}
-(UILabel *)shareLabel{
    if (!_shareLabel) {
        _shareLabel= [[UILabel alloc] init];
        _shareLabel.text = [NSString stringWithFormat:@"%ld年度账单",[[NSDate new] year]];
        _shareLabel.textColor = kBlackColor;
        _shareLabel.font = kPingFangTC_Light(15);
        _shareLabel.textAlignment = NSTextAlignmentCenter;
        _shareLabel.backgroundColor = kWhiteColor;
        _shareLabel.frame = CGRectMake(0, 0, ScreenWidth, kNavigationHeight);
    }
    return _shareLabel;
}
-(OrderDetailHeaderView *)headView{
    if (!_headView) {
        _headView = [[OrderDetailHeaderView alloc] init];
        _headView.backgroundColor = kBlackColor;
        _headView.layer.cornerRadius = kIphone6Width(5);
        _headView.layer.masksToBounds = YES;
    }
    return _headView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kIphone6Width(10), kNavigationHeight, ScreenWidth - kIphone6Width(20), ScreenHeight - kTabBarSpace  - kTabbarHeight - kNavigationHeight) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.backgroundColor = kWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableHeaderView = self.headView;
        _tableView.tableHeaderView.height = kIphone6Width(180);
        [_tableView registerClass:[OrderDetailTableViewCell class] forCellReuseIdentifier:@"OrderDetailTableViewCell"];
        [_tableView registerClass:[OrderDetailTableSectionView class] forHeaderFooterViewReuseIdentifier:@"OrderDetailTableSectionView"];
    }
    return _tableView;
}
#pragma make TableViewDelegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kIphone6Width(50);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailTableViewCell"];
    if (cell == nil) {
        cell = [[OrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderDetailTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderDataSource = self.dataSource[indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderDetailTableSectionView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderDetailTableSectionView"];
    if(!sectionHeadView){
        sectionHeadView = [[OrderDetailTableSectionView alloc] initWithReuseIdentifier:@"AccountDetailSectionView"];
    }
    return sectionHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kIphone6Width(40);
}
-(void)requestDateSource{
    WS(weakSelf);
    [PBWatherExtension queryMonthOrderDetailListWithDate:[NSDate new] success:^(NSMutableArray<NSMutableArray<PBWatherModel *> *> * _Nonnull bookList) {
        if (bookList.count != 0) {
            weakSelf.headView.dataSource = bookList;
            weakSelf.dataSource = bookList;
            [weakSelf.tableView reloadData];
        }
    } fail:^(id _Nonnull error) {
    }];
}
#pragma mark 生成image
- (UIImage *)getmakeImageWithView:(UIView *)view andWithSize:(CGSize)size{
    self.naviView.hidden = YES;
    [self.view addSubview:self.shareLabel];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.shareLabel removeFromSuperview];
    self.naviView.hidden = NO;
    return image;
    
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
