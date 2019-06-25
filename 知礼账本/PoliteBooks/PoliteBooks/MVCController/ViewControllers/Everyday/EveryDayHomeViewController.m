//
//  EveryDayHomeViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "EveryDayHomeViewController.h"
@interface EveryDayHomeViewController()

@property(nonatomic,strong)PBIndexNavigationBarView * naviView;


@end
@implementation EveryDayHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self addMasonry];
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(84);
    }];
    
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        //_naviView.backgroundColor = kWhiteColor;
        _naviView.title = @"流水账";
//        _naviView.leftImage = @"Bookcase";
//        _naviView.rightImage = @"chart";
//        _naviView.rightHidden = NO;
        _naviView.backgroundColor = [UIColor clearColor];
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
//            BooksViewController * books = [[BooksViewController alloc] init];
//            [weakSelf.navigationController pushViewController:books animated:YES];
        };
        _naviView.PBIndexNavigationBarViewRightButtonBlock = ^{
//            MineViewController * mine = [[MineViewController alloc] init];
//            [weakSelf.navigationController hh_pushErectViewController:mine];
        };
    }
    return _naviView;
}
@end
