//
//  WKWebViewController.m
//  Beauty
//
//  Created by 宋增宇 on 2018/5/21.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>

@property (nonatomic, strong) WKWebViewConfiguration *configuration;
@property(nonatomic,strong)NSDictionary * shareDic;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;
@property(nonatomic,strong)PBIndexNavigationBarView * naviView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationHeight);
    }];
    [self.view addSubview:self.webView];
    
    self.shareDic = [[NSDictionary alloc] init];
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 94, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = kHexRGB(0x3b3b4f);
    self.progressView.progressTintColor = kHexRGB(0x3b3b4f);
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                self.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setTitleStr:(NSString *)titleStr{
    
    _titleStr = titleStr;
    self.title = titleStr;
}

#pragma mark -- WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
}

-(void)leftBarItemAction:(UITapGestureRecognizer *)gesture{
    [self backAction];
}
#pragma mark - 动作 - 后退和退栈 -
- (void) backAction
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //如果可以后退
        if ([self.webView canGoBack]) {
            //执行后退
        [self.webView goBack];
        }else {
            //如果栈中控制器大于1个
            if (self.navigationController.viewControllers.count > 1) {
                //返回时退栈
                [self.navigationController popViewControllerAnimated:NO];
            }else {
                //如果控制器没有大于1 就是模态出的web,那么就dismiss
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                }];
            }
        }
    }else {
        //如果系统低于8.0 执行UIWebview的方法
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else {
            if (self.navigationController.viewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:NO];
            }else {
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                }];
            }
        }
    }
}
-(PBIndexNavigationBarView *)naviView{
    if (!_naviView) {
        _naviView = [[PBIndexNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kNavigationHeight)];
        _naviView.titleFont = kFont16;
        _naviView.title = @"用户协议及隐私政策";
        _naviView.leftImage = @"NavigationBack";
        _naviView.rightImage = @"BookChars";
        _naviView.rightHidden = YES;
        WS(weakSelf);
        _naviView.PBIndexNavigationBarViewLeftButtonBlock = ^{
            //左按钮点击
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _naviView;
}
- (WKWebViewConfiguration *)configuration{
    if (!_configuration) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        
        [userContentController addScriptMessageHandler:self name:@"shareH5"];
        _configuration.userContentController = userContentController;
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 40.0;
        _configuration.preferences = preferences;
    }
    return _configuration;
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, ScreenWidth, ScreenHeight - kNavigationHeight - kTabBarSpace) configuration:self.configuration];
        if (self.urlStr) {
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
        }
        [_webView setAllowsBackForwardNavigationGestures:true];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [_webView setMultipleTouchEnabled:YES];
        [_webView setAutoresizesSubviews:YES];
        [_webView.scrollView setAlwaysBounceVertical:YES];
    }
    return _webView;
}
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view bringSubviewToFront:self.progressView];
}
//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progressView.hidden = YES;
}
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
