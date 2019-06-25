//
//  KeepAccountInCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//
#import "KeepAccountCollectionViewCell.h"
#import "KeepAccountInOutCollectionViewCell.h"
@interface KeepAccountInOutCollectionViewCell()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property(nonatomic,strong)UICollectionView * baseCollectionview;

@property(nonatomic,assign)NSInteger  selectRow;
@end
@implementation KeepAccountInOutCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.baseCollectionview];
        self.selectRow = 0;
    }
    return self;
}
- (UICollectionView *)baseCollectionview {
    if (!_baseCollectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(20);
        flowLayout.minimumInteritemSpacing = kIphone6Width(20);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(kIphone6Width(70), kIphone6Width(50));
        _baseCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,ScreenWidth,ScreenHeight - kNavigationHeight - kIphone6Width(30) - kTabBarSpace) collectionViewLayout:flowLayout];
        _baseCollectionview.showsVerticalScrollIndicator = NO;
        _baseCollectionview.showsHorizontalScrollIndicator = NO;
        _baseCollectionview.delegate = self;
        _baseCollectionview.dataSource = self;
        _baseCollectionview.pagingEnabled = YES;
        _baseCollectionview.bounces = NO;
        _baseCollectionview.backgroundColor = [UIColor whiteColor];
        [_baseCollectionview registerClass:[KeepAccountCollectionViewCell class] forCellWithReuseIdentifier:@"KeepAccountCollectionViewCell"];
    }
    return _baseCollectionview;
}
#pragma mark delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.row == 0) {
        return 30;
    }else{
        return 5;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KeepAccountCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeepAccountCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[KeepAccountCollectionViewCell alloc] init];
    }
    cell.layer.cornerRadius = kIphone6Width(25);
    cell.layer.masksToBounds = YES;
    cell.row = indexPath.row;
    if (self.selectRow != 0) {
        if (indexPath.row == self.selectRow - 1) {
            cell.backgroundColor = kHexRGB(0xe9f1f6);
        }else{
            cell.backgroundColor = kWhiteColor;
        }
    }
    WS(weakSelf);
    cell.keepAccountCollectionViewCellBtnSelectBlock = ^(NSInteger row) {
        weakSelf.selectRow = row + 1;
        [weakSelf.baseCollectionview reloadData];
        //弹起键盘
        if (weakSelf.keepAccountInOutCollectionViewCellBtnSelectBlock) {
            weakSelf.keepAccountInOutCollectionViewCellBtnSelectBlock(row);
        }
    };
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)setRow:(NSInteger)row{
    _row = row;
    
    //[self.contentView addSubview:self.baseCollectionview];
}
@end
