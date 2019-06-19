//
//  DetailViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailOrderCollectionViewCell.h"
#import "InputViewController.h"
#import "TranslationMicTipView.h"
#import "BaseCollectionView.h"
#import "SPMultipleSwitch.h"
@interface DetailViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
BaseCollectionViewButtonClickDelegate
>
/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账簿列表
 */
@property (nonatomic, strong) BaseCollectionView *collectionView;

/**
 navi
 */
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)PBBookModel * naviModel;


@property (nonatomic, strong) NSIndexPath *longPressIndexPath;

@property(nonatomic,strong)NSMutableArray<PBTableModel *> * tableDataSource;
//关系处理
@property(nonatomic,strong)NSMutableArray<PBTableModel *> * stroneTableDataSource;

@property(nonatomic,strong)SPMultipleSwitch * relationTypeSwitch;

@property(nonatomic,assign)NSInteger tableRealtionType;

@property(nonatomic,strong)NSArray * relationItems;

@property(nonatomic,strong)NSMutableArray<PBTableModel *> * realtionDataSource;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.relationTypeSwitch];
    [self.view addSubview:self.collectionView];
    self.tableDataSource = [[NSMutableArray alloc] init];
    self.realtionDataSource = [[NSMutableArray alloc] init];
    self.relationItems = @[@"全部",@"亲戚",@"朋友",@"同学",@"同事",@"邻里"];
    self.tableRealtionType = 0;
    [self addMasonry];
    [self queryBookList];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_isLook) {
        InputViewController *circleVC = [InputViewController new];
        circleVC.bookModel = self.bookModel;
        WS(weakSelf);
        circleVC.InputViewControllerPopBlock = ^{
            [weakSelf queryBookList];
        };
        [self.navigationController hh_presentTiltedVC:circleVC completion:nil];
    }else{
        if ([UserGuideManager isGuideWithIndex:2]) {
            [self guidanceWithIndex:2];
        }
    }
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kIphone6Width(74));
    }];
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.backgroundColor = kWhiteColor;
        //@"貳零壹玖年壹月往来明细";
        _naviView.titleFont = kFont12;
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"Chinesebrush";
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
            //右按钮点击
            VIBRATION;
            InputViewController *circleVC = [InputViewController new];
            circleVC.bookModel = weakSelf.bookModel;
            circleVC.InputViewControllerPopBlock = ^{
                [weakSelf queryBookList];
            };
            [weakSelf.navigationController hh_presentTiltedVC:circleVC completion:nil];
            VIBRATION;
        };
    }
    return _naviView;
}
-(SPMultipleSwitch *)relationTypeSwitch{
    if (!_relationTypeSwitch) {
        _relationTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"全部",@"亲戚",@"朋友",@"同学",@"同事",@"邻里"]];
        _relationTypeSwitch.frame = CGRectMake(15, kIphone6Width(85), ScreenWidth-30, 30);
        _relationTypeSwitch.backgroundColor = kHexRGB(0xe9f1f6);
        _relationTypeSwitch.selectedTitleColor = kWhiteColor;
        _relationTypeSwitch.titleColor = kHexRGB(0x665757);
        _relationTypeSwitch.trackerColor = TypeColor[self.bookModel.bookColor];
        _relationTypeSwitch.contentInset = 5;
        _relationTypeSwitch.spacing = 10;
        _relationTypeSwitch.titleFont = kFont14;
        //        _relationTypeSwitch.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        //        _relationTypeSwitch.layer.borderColor = kHexRGB(0x665757).CGColor;
        [_relationTypeSwitch addTarget:self action:@selector(relationTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _relationTypeSwitch;
}
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(14);
        flowLayout.minimumInteritemSpacing = kIphone6Width(5);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(ScreenWidth/4, ScreenHeight - kIphone6Width(160));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, kIphone6Width(125) , ScreenWidth, ScreenHeight - 140) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        //_collectionView.bounces = NO;
        _collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"记一笔~";
        //_collectionView.noDataTitle = @"你还没有记过该类型账";
        _collectionView.backgroundColor = [UIColor whiteColor];
        // right
//        [_collectionView addPullToRefreshPosition:AAPullToRefreshPositionRight actionHandler:^(AAPullToRefresh *v){
//            [ToastManage showTopToastWith:@"没有更多数据了"];
//        }];
//        [_collectionView addPullToRefreshPosition:AAPullToRefreshPositionLeft actionHandler:^(AAPullToRefresh *v){
//            [ToastManage showTopToastWith:@"已经是最新的啦"];
//        }];
        [_collectionView registerClass:[DetailOrderCollectionViewCell class] forCellWithReuseIdentifier:@"DetailOrderCollectionViewCell"];
    }
    return _collectionView;
}
#pragma mark - # Delegate
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailOrderCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DetailOrderCollectionViewCell alloc] init];
    }
    cell.model = self.tableDataSource[indexPath.row];
    cell.layer.cornerRadius = kIphone6Width(10);
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = kHexRGB(0xf6f5ec);
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
    longPressGR.minimumPressDuration = 1;
    [cell addGestureRecognizer:longPressGR];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, ScreenWidth/4, ScreenHeight-160);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, ScreenWidth/4, ScreenHeight-160);
    borderLayer.lineWidth = 1.f;
    borderLayer.strokeColor = kBlackColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth/4, ScreenHeight-160) cornerRadius:kIphone6Width(15)];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
    [cell.layer setMask:maskLayer];
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.longPressIndexPath = indexPath;
    PBTableModel * model = self.tableDataSource[indexPath.row];
    if (model.inType && model.outType) {
        [self showInOrOutWithModel:model WithTitle:@""];
        return;
    }
    if (model.inType) {
        //回礼
        [self showInOrOutWithModel:model WithTitle:@"收禮"];
    }
    if (model.outType) {
        [self showInOrOutWithModel:model WithTitle:@"進禮"];
        //进礼
    }
    
    
}
-(void)showInOrOutWithModel:(PBTableModel *)model WithTitle:(NSString *)title{
    if ([title isEqualToString:@""]) {
        WS(weakSelf);
        [LEEAlert actionsheet].config
        .LeeTitle(@"账单编辑")
        .LeeContent([NSString stringWithFormat:@"编辑账单内容"])
        .LeeAction(@"编辑账单", ^{
            VIBRATION;
            InputViewController * input = [[InputViewController alloc] init];
            input.isEdit = YES;
            input.tableModel = model;
            input.bookModel = self.bookModel;
            WS(weakSelf);
            input.InputViewControllerPopBlock = ^{
                [weakSelf queryBookList];
            };
            [self.navigationController hh_presentTiltedVC:input completion:nil];
        })
        .LeeAction(@"删除账单", ^{
            [weakSelf showAlert];
        })
        .LeeCancelAction(@"取消", nil)
        .LeeBackgroundStyleBlur(UIBlurEffectStyleLight)
        .LeeShow();
    }else{
        WS(weakSelf);
        [LEEAlert actionsheet].config
        .LeeTitle(@"账单编辑")
        .LeeContent([NSString stringWithFormat:@"一键%@、编辑账单内容",title])
        .LeeAction(@"编辑账单", ^{
             VIBRATION;
            InputViewController * input = [[InputViewController alloc] init];
            input.isEdit = YES;
            input.tableModel = model;
            input.bookModel = self.bookModel;
            WS(weakSelf);
            input.InputViewControllerPopBlock = ^{
                [weakSelf queryBookList];
            };
            [self.navigationController hh_presentTiltedVC:input completion:nil];
        })
        .LeeAction(title, ^{
            [weakSelf showAlertWithType:title andModel:model];
        })
        .LeeAction(@"删除账单", ^{
            [weakSelf showAlert];
        })
        .LeeCancelAction(@"取消", nil)
        .LeeBackgroundStyleBlur(UIBlurEffectStyleLight)
        .LeeShow();
    }
}
-(void)showAlertWithType:(NSString *)type andModel:(PBTableModel *)model{
    [LEEAlert alert].config
    .LeeAddTitle(^(UILabel *label) {
        label.text = type;
        label.textColor = kWhiteColor;
    })
    .LeeAddContent(^(UILabel *label) {
        label.text = [NSString stringWithFormat:@"是否对%@%@，%@后将无法修改, 请慎重考虑",model.userName,type,type];
        label.textColor = [kWhiteColor colorWithAlphaComponent:0.75f];
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeCancel;
        action.title = @"取消";
        action.titleColor = TypeColor[self.bookModel.bookColor];
        action.backgroundColor = kWhiteColor;
        action.clickBlock = ^{
        };
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeDefault;
        action.title = type;
        action.titleColor = TypeColor[self.bookModel.bookColor];
        action.backgroundColor = kWhiteColor;
        WS(weakSelf);
        action.clickBlock = ^{
            BmobObject  *table = [BmobObject objectWithoutDataWithClassName:@"userTables" objectId:model.objectId];
            if (!model.inType) {
                [table setObject:[NSNumber numberWithInt:1] forKey:@"dUserInType"];
                weakSelf.bookModel.bookOutMoney = weakSelf.bookModel.bookOutMoney +[model.userMoney integerValue];
                [BmobBookExtension updataForModel:weakSelf.bookModel withType:0 success:^(id  _Nonnull responseObject) {
                    [table updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            [weakSelf queryBookList];
                        } else {
                        }
                    }];
                }];
            }
            if (!model.outType) {
                [table setObject:[NSNumber numberWithInt:1] forKey:@"dUserOutType"];
                weakSelf.bookModel.bookInMoney = weakSelf.bookModel.bookInMoney +[model.userMoney integerValue];
                [BmobBookExtension updataForModel:weakSelf.bookModel withType:1 success:^(id  _Nonnull responseObject) {
                    [table updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            [weakSelf queryBookList];
                        } else {
                        }
                    }];
                }];
            }
            
            
        };
    })
    .LeeHeaderColor(TypeColor[self.bookModel.bookColor])
    .LeeShow();
}
-(void)lpGR:(UILongPressGestureRecognizer *)lpGR
{
    if (lpGR.state == UIGestureRecognizerStateBegan) {//手势开始
        CGPoint point = [lpGR locationInView:self.collectionView];
        VIBRATION;
        self.longPressIndexPath = [self.collectionView indexPathForItemAtPoint:point];// 可以获取我们在哪个cell上长按
        [self showAlert];
        
    }
}
-(void)showAlert{
    UIColor *blueColor = TypeColor[self.bookModel.bookColor];
    WS(weakSelf);
    [LEEAlert alert].config
    .LeeAddTitle(^(UILabel *label) {
        label.text = @"确认删除?";
        label.textColor = kWhiteColor;
    })
    .LeeAddContent(^(UILabel *label) {
        label.text = @"删除后将无法恢复, 请慎重考虑";
        label.textColor = [kWhiteColor colorWithAlphaComponent:0.75f];
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeCancel;
        action.title = @"取消";
        action.titleColor = blueColor;
        action.backgroundColor = kWhiteColor;
        action.clickBlock = ^{
        };
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeDefault;
        action.title = @"删除";
        action.titleColor = blueColor;
        action.backgroundColor = kWhiteColor;
        action.clickBlock = ^{
            // 删除点击事件Block
            [weakSelf updateBookModel:weakSelf.bookModel andTableModel:weakSelf.tableDataSource[weakSelf.longPressIndexPath.row]];
            [PBTableExtension delegateDataForModel:weakSelf.tableDataSource[weakSelf.longPressIndexPath.row] success:^(id  _Nonnull responseObject) {
                [weakSelf.tableDataSource removeObjectAtIndex:weakSelf.longPressIndexPath.row];
                if (weakSelf.tableDataSource.count == 0) {
                    [weakSelf.collectionView reloadData];
                }else{
                    [weakSelf.collectionView deleteItemsAtIndexPaths:@[weakSelf.longPressIndexPath]];
                }
            }];
        };
    })
    .LeeHeaderColor(blueColor)
    .LeeShow();
}
-(void)updateBookModel:(PBBookModel *)model andTableModel:(PBTableModel *)tableModel{
    if (tableModel.inType && tableModel.outType) {
        model.bookOutMoney = model.bookOutMoney - [tableModel.userMoney integerValue];
        model.bookInMoney = model.bookInMoney - [tableModel.userMoney integerValue];
        [BmobBookExtension updataForModel:model withType:2 success:^(id  _Nonnull responseObject) {
        }];
        return;
    }
    if (tableModel.inType) {
        model.bookOutMoney = model.bookOutMoney - [tableModel.userMoney integerValue];
        [BmobBookExtension updataForModel:model withType:0 success:^(id  _Nonnull responseObject) {
        }];
    }
    if (tableModel.outType) {
        model.bookInMoney = model.bookInMoney - [tableModel.userMoney integerValue];
        [BmobBookExtension updataForModel:model withType:0 success:^(id  _Nonnull responseObject) {
        }];
    }
}
-(void)setIsLook:(BOOL)isLook{
    _isLook = isLook;
    
}

-(void)setBookModel:(PBBookModel *)bookModel{
    _bookModel = bookModel;
    self.naviModel = bookModel;
    self.naviView.title = [NSString stringWithFormat:@"%@往来明细",self.bookModel.bookName];
}

-(void)baseCollectionViewButtonClick{
    VIBRATION;
    InputViewController *circleVC = [InputViewController new];
    circleVC.bookModel = self.bookModel;
    WS(weakSelf);
    circleVC.InputViewControllerPopBlock = ^{
        [weakSelf queryBookList];
    };
    [self.navigationController hh_presentTiltedVC:circleVC completion:nil];
    VIBRATION;
}
-(void)queryBookList{
    [self showLoadingAnimation];
    WS(weakSelf);
    [PBTableExtension queryBookListWithModel:self.bookModel success:^(NSMutableArray<PBTableModel *> * _Nonnull tableList) {
        [weakSelf hiddenLoadingAnimation];
        weakSelf.tableDataSource = tableList;
        weakSelf.stroneTableDataSource = tableList;
        [weakSelf.collectionView reloadData];
    } fail:^(id _Nonnull error) {
    }];
}
-(void)relationTypeSwitchAction:(SPMultipleSwitch *)swit{
    self.tableRealtionType = swit.selectedSegmentIndex;
    if (swit.selectedSegmentIndex) {
        [self.realtionDataSource removeAllObjects];
        for (PBTableModel * model in self.stroneTableDataSource) {
            if ([model.userRelation isEqualToString:self.relationItems[swit.selectedSegmentIndex]]) {
                [self.realtionDataSource addObject:model];
            }
        }
        self.tableDataSource = self.realtionDataSource;
        [self.collectionView reloadData];
    }else{
        self.tableDataSource = self.stroneTableDataSource;
         [self.collectionView reloadData];
    }
}

@end
