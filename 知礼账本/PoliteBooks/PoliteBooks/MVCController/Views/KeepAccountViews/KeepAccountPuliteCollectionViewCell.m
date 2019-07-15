//
//  KeepAccountPuliteCollectionViewCell.m
//  PoliteBooks
//
//  Created by llk on 2019/6/28.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "KeepAccountPuliteCollectionViewCell.h"
#import "BooksCollectionViewCell.h"
@interface KeepAccountPuliteCollectionViewCell()<UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,BaseCollectionViewButtonClickDelegate>

@property (nonatomic, strong) BaseCollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray<PBBookModel *> * dataSource;

@end
@implementation KeepAccountPuliteCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dataSource = [[NSMutableArray alloc] init];
        [self queryBookList];
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = kIphone6Width(15);
        flowLayout.minimumInteritemSpacing = kIphone6Width(5);
        flowLayout.sectionInset = UIEdgeInsetsMake(kIphone6Width(20), 3, kIphone6Width(20), 3);
        flowLayout.itemSize = CGSizeMake(kIphone6Width(150), kIphone6Width(200));
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(kIphone6Width(20),0,ScreenWidth - kIphone6Width(40) ,ScreenHeight - kNavigationHeight - kIphone6Width(30) - kTabBarSpace) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.baseDelegate = self;
        _collectionView.btnTitle = @"点击添加账本";
        [_collectionView registerClass:[BooksCollectionViewCell class] forCellWithReuseIdentifier:@"BooksCollectionViewCell"];
    }
    return _collectionView;
}
-(void)queryBookList{
    WS(weakSelf);
    [BmobBookExtension queryBookListsuccess:^(NSMutableArray<PBBookModel *> * _Nonnull bookList) {
        weakSelf.dataSource = bookList;
        [weakSelf.collectionView reloadData];
    } fail:^(id _Nonnull error) {
        
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BooksCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BooksCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BooksCollectionViewCell alloc] init];
    }
    cell.bookModel = self.dataSource[indexPath.row];
    return cell;
}
//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PBBookModel * bookModel = self.dataSource[indexPath.row];
    if (self.KeepAccountPuliteCollectionViewCellClickBlock) {
        self.KeepAccountPuliteCollectionViewCellClickBlock(bookModel);
    }
    
}
-(void)baseCollectionViewButtonClick{
    if (self.KeepAccountPuliteCollectionViewCellChertBlock) {
        self.KeepAccountPuliteCollectionViewCellChertBlock();
    }
}
-(void)setRequest:(BOOL)request{
    if (request) {
        [self queryBookList];
    }
}
@end

