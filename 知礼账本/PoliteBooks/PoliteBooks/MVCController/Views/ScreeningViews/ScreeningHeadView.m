//
//  ScreeningHeadView.m
//  PoliteBooks
//
//  Created by llk on 2019/7/3.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ScreeningHeadView.h"
#import "SereenHeadCollectionViewCell.h"
@interface ScreeningHeadView()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView * collectionview;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic, strong) NSIndexPath *selectIndex;

@end
@implementation ScreeningHeadView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionview];
        //self.backgroundColor = kBlackColor;
    }
    return self;
}
- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewFlowLayout.minimumLineSpacing = 20;
        // 2.设置 最小列间距
        _collectionViewFlowLayout. minimumInteritemSpacing  = 10;
        // 3.设置item块的大小 (可以用于自适应)
        _collectionViewFlowLayout.estimatedItemSize = CGSizeMake(20, 60);
        [_collectionViewFlowLayout setSectionInset:UIEdgeInsetsMake(10, 10,10,10)];
    }
    return _collectionViewFlowLayout;
}
- (UICollectionView *)collectionview {
    if (!_collectionview) {
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , ScreenWidth, kIphone6Width(200)) collectionViewLayout:self.collectionViewFlowLayout];
        [_collectionview setBackgroundColor:[UIColor whiteColor]];
        [_collectionview setDelegate:self];
        [_collectionview setDataSource:self];
        [_collectionview registerClass:[SereenHeadCollectionViewCell class] forCellWithReuseIdentifier:@"SereenHeadCollectionViewCell"];
    }
    return _collectionview;
}
#pragma mark delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SereenHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SereenHeadCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[SereenHeadCollectionViewCell alloc] init];
    }
    cell.layer.cornerRadius = kIphone6Width(5);
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = kBlackColor.CGColor;
    cell.layer.borderWidth = 1;
    cell.title = self.titles[indexPath.row];
    cell.select = NO;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VIBRATION;
    if (self.selectIndex) {
        SereenHeadCollectionViewCell * cell = (SereenHeadCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.selectIndex]; //即为要得到的cell
        //cell.backgroundColor = kHexRGB(0xe9f1f6);
        cell.select = !cell.select;
    }
    SereenHeadCollectionViewCell * cell = (SereenHeadCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath]; //即为要得到的cell
    //cell.backgroundColor = kHexRGB(0xe9f1f6);
    cell.select = !cell.select;
    self.selectIndex = indexPath;
    if (self.screeningHeadViewCollectionViewCellBtnSelectBlock) {
        self.screeningHeadViewCollectionViewCellBtnSelectBlock(indexPath.row);
    }
}
-(void)setTitles:(NSArray *)titles{
    _titles = titles;
}
@end
