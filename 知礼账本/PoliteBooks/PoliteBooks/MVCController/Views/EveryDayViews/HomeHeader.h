/**
 * 头视图
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BaseView.h"
#import "PBWatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeader : BaseView

@property (nonatomic, strong) NSDate *date;

@property(nonatomic,strong)NSMutableArray<NSMutableArray<PBWatherModel *> *> * dataSource;
@property(nonatomic,assign)CGFloat paySum;

@property(nonatomic,assign)CGFloat incolm;

@property (copy , nonatomic) void(^everyDayHeadViewCellBtnSelectBlock)(NSDate * date);
@end

NS_ASSUME_NONNULL_END
