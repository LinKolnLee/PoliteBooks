//
//  AccentDetailTableViewCell.h
//  PoliteBooks
//
//  Created by llk on 2019/6/26.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccentDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)PBWatherModel * model;

@property(nonatomic,assign)BOOL screening;

@end

NS_ASSUME_NONNULL_END
