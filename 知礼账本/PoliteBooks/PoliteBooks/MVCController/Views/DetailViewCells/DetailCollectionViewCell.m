//
//  DetailCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/1/11.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "DetailOrderCollectionViewCell.h"
#import "BaseCollectionView.h"

@interface DetailCollectionViewCell ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,BaseCollectionViewButtonClickDelegate
>
@property (nonatomic, strong) NSIndexPath *longPressIndexPath;
/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账簿列表
 */
@property (nonatomic, strong) BaseCollectionView *collectionView;

@end
@implementation DetailCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(14);
        flowLayout.minimumInteritemSpacing = kIphone6Width(15);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(self.frame.size.width/7, self.frame.size.height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat topHeight = kIphone6Width(100);
        if (IPHONEXR || IPHONEXSMAX || IPhoneX) {
            topHeight = kIphone6Width(120);
        }
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 0 , self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"记一笔~";
        //_collectionView.noDataTitle = @"你还没有记过该类型账";
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
    return self.detailDataSource.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailOrderCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DetailOrderCollectionViewCell alloc] init];
    }
    cell.model = self.detailDataSource[indexPath.row + 1];
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
    maskLayer.frame = CGRectMake(0, 0, self.frame.size.width/7, self.frame.size.height);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, self.frame.size.width/7, self.frame.size.height);
    borderLayer.lineWidth = 1.f;
    borderLayer.strokeColor = kBlackColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width/7, self.frame.size.height) cornerRadius:kIphone6Width(15)];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
    [cell.layer setMask:maskLayer];
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
    UIColor *blueColor = TypeColor[self.detailDataSource[0].tableType];
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
            [kDataBase jq_inDatabase:^{
                [kDataBase jq_deleteTable:self.currentTableName whereFormat:@"WHERE bookId = '%d'",self.detailDataSource[self.longPressIndexPath.row + 1].bookId];
                self.detailDataSource = [kDataBase jq_lookupTable:self.currentTableName dicOrModel:[BooksModel class] whereFormat:@"where bookName = '%@'",self.detailDataSource[0].bookName];
                [weakSelf.collectionView reloadData]; //刷新tableview
            }];
        };
    })
    .LeeHeaderColor(blueColor)
    .LeeShow();
}
-(void)baseCollectionViewButtonClick{
    if (self.detailCollectionViewCellCreateBookBlock) {
        self.detailCollectionViewCellCreateBookBlock();
    }
}
-(void)setDetailDataSource:(NSArray<BooksModel *> *)detailDataSource{
    _detailDataSource = detailDataSource;
    [self.collectionView reloadData];
}
-(void)setCurrentTableName:(NSString *)currentTableName{
    _currentTableName = currentTableName;
}
@end
