//
//  ToolViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/28.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "ToolViewController.h"

@interface ToolViewController ()
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@end

@implementation ToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self addMasonry];
    // Do any additional setup after loading the view.
}
-(void)addMasonry{
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kIphone6Width(74));
    }];
    
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] init];
        _naviView.title = @"速记";
        _naviView.titleFont = kFont16;
    }
    return _naviView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
