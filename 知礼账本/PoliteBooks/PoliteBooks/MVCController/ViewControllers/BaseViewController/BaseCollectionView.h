//
//  BaseCollectionView.h
//  Beauty
//
//  Created by llk on 2018/6/27.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseCollectionViewButtonClickDelegate <NSObject>

// 获取webView高度后改变tableViewHeaderView高度
- (void)baseCollectionViewButtonClick;

@end
@interface BaseCollectionView : UICollectionView

@property (nonatomic, weak) id<BaseCollectionViewButtonClickDelegate> baseDelegate;

/**
 是否显示空数据页面  默认为显示
 */
@property(nonatomic,assign) BOOL isShowEmptyData;

/**
 空数据页面的title
 可不传，默认为：暂无任何数据
 */
@property(nonatomic,strong) NSString *noDataTitle;

/**
 空数据页面的图片
 可不传，默认图片为：NoData
 */
@property(nonatomic,strong) NSString *noDataImgName;

/**
 显示副标题的时候，需要赋值副标题，否则不显示
 */
@property(nonatomic,strong) NSString *noDataDetailTitle;

/**
 按钮标题、图片
 不常用
 */
@property(nonatomic,strong) NSString *btnTitle;

@property(nonatomic,strong) NSString *btnImgName;

-(void)buttonEvent;

@end
