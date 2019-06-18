//
//  BaseCollectionView.m
//  Beauty
//
//  Created by llk on 2018/6/27.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import "BaseCollectionView.h"
#import "UIScrollView+EmptyDataSet.h"
@interface BaseCollectionView()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@end
@implementation BaseCollectionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isShowEmptyData = YES;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.isShowEmptyData = YES;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    return self;
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.noDataImgName) {
        return [UIImage imageNamed:self.noDataImgName];
    }
    return [UIImage imageNamed:@"ChinesebrushHold"];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView;{
    return YES;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = self.noDataTitle?self.noDataTitle:@"你还没有创建账簿";
    NSDictionary *attributes = @{NSFontAttributeName: kFont14,
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = self.noDataDetailTitle;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    return self.noDataDetailTitle?[[NSAttributedString alloc] initWithString:text attributes:attributes]:nil;
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return self.isShowEmptyData;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 0;
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f]};
    return self.btnTitle?[[NSAttributedString alloc] initWithString:self.btnTitle attributes:attributes]:nil;
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return self.btnImgName?[UIImage imageNamed:self.btnImgName]:nil;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [self buttonEvent];
}

#pragma mark 按钮事件
-(void)buttonEvent
{
    if ([self.baseDelegate respondsToSelector:@selector(baseCollectionViewButtonClick)]) {
        [self.baseDelegate baseCollectionViewButtonClick];
    }
}


@end
