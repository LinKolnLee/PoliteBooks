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
@interface DetailViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
BaseCollectionViewButtonClickDelegate
>
/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账本列表
 */
@property (nonatomic, strong) BaseCollectionView *collectionView;

/**
 navi
 */
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@property(nonatomic,strong)PBBookModel * naviModel;

@property(nonatomic,strong)TranslationMicTipView * micTipView;

@property (nonatomic, strong) NSIndexPath *longPressIndexPath;

@property(nonatomic,strong)NSMutableArray<PBTableModel *> * tableDataSource;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.collectionView];
    self.tableDataSource = [[NSMutableArray alloc] init];
    [self addMasonry];
    if (self.tableDataSource.count != 1) {
        [self setupTipViewWithCell];
    }
    [self queryBookList];
}
-(void)setupTipViewWithCell{
    CGFloat popHeight =kIphone6Width(35.0);
    CGRect popRect = CGRectMake(0, kIphone6Width(0), kIphone6Width(140), popHeight);
    self.micTipView = [[TranslationMicTipView alloc] initWithFrame:popRect Title:@"选中长按删除条目"];
    self.micTipView.centerX = ScreenWidth/2;
    self.micTipView.centerY = ScreenHeight - kIphone6Width(50);
    [self.view addSubview:self.micTipView];
    [self performSelector:@selector(hideTipView) withObject:nil afterDelay:3.0];
}
- (void)hideTipView {
    WS(weakSelf);
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.micTipView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.micTipView.hidden = YES;
    }];
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
        make.height.mas_equalTo(74);
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
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(25);
        flowLayout.minimumInteritemSpacing = kIphone6Width(25);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(ScreenWidth/4, ScreenHeight - 160);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat topHeight = kIphone6Width(100);
        if (IPHONEXR || IPHONEXSMAX || IPhoneX) {
            topHeight = kIphone6Width(120);
        }
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(10, 84 , ScreenWidth - 20, ScreenHeight - 100) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"点击开始记账";
        _collectionView.noDataTitle = @"你还没有记过该类型账";
        _collectionView.backgroundColor = [UIColor whiteColor];
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
       // WS(weakSelf);
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
        [weakSelf.collectionView reloadData];
    } fail:^(id _Nonnull error) {
    }];
}


@end
