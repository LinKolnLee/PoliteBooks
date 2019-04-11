//
//  InputClassTagsView.m
//  PoliteBooks
//
//  Created by llk on 2019/1/14.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "InputClassTagsView.h"
#import "InputClassTagCollectionViewCell.h"
@interface InputClassTagsView()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate
>
/// collectionViewCollectionViewLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/**
 账本列表
 */
@property (nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic,strong)NSArray * titles;

@property(nonatomic,strong)NSArray * colors;

@end
@implementation InputClassTagsView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        //self.colors = @[kHexRGB(0xA73946),kHexRGB(0xf15b6c),kHexRGB(0xf69c9f),kHexRGB(0x817090),kHexRGB(0x224E81),kHexRGB(0xC9AF99),kHexRGB(0xD4CF96),kHexRGB(0xF5F5F5)];
        self.titles = @[@"结婚",@"定亲",@"满月",@"节日",@"高升",@"高中",@"人情",@"丧事"];
    }
    return self;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(35);
        flowLayout.minimumInteritemSpacing = kIphone6Width(15);
        flowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        flowLayout.itemSize = CGSizeMake(kIphone6Width(40), kIphone6Width(60));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kIphone6Width(50), kIphone6Width(10) , ScreenWidth-kIphone6Width(100), kIphone6Width(150)) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = kWhiteColor;
        [_collectionView registerClass:[InputClassTagCollectionViewCell class] forCellWithReuseIdentifier:@"InputClassTagCollectionViewCell"];
    }
    return _collectionView;
}

#pragma mark - # Delegate
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InputClassTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InputClassTagCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[InputClassTagCollectionViewCell alloc] init];
    }
    cell.color = TypeColor[indexPath.row];
    cell.title = self.titles[indexPath.row];
    return cell;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.InputClassTagsViewCellTypeClickBlock) {
        self.InputClassTagsViewCellTypeClickBlock(indexPath.row);
    }
    
}
@end
