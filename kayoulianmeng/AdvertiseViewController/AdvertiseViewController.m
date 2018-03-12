//
//  AdvertiseViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/3/4.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "AdvertiseViewController.h"

@interface AdvertiseViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"广告详情";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
    self.webView.backgroundColor = [UIColor whiteColor];
    if (!self.adUrl) {
        self.adUrl = @"https://topic.360che.com/m/2018020701/?mz_ca=2073086&mz_sp=7DD4i";
    }
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;//设置导航栏是否半透明，解决界面跳转出现黑色阴影问题
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)setAdUrl:(NSString *)adUrl
{
    _adUrl = adUrl;
}



@end
