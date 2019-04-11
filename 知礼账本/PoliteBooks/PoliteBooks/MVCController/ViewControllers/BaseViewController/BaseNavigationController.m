//
//  BaseNavigationController.m
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController != nil) {
        if (self.viewControllers.count == 1) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
        [super pushViewController:viewController animated:animated];
    }
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}
-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    return [super popToRootViewControllerAnimated:animated];
}
-(void)dealloc{
    DLog(@"界面内存已释放!");
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
