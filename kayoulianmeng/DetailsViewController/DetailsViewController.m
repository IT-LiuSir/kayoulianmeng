//
//  DetailsViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/2/27.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "DetailsViewController.h"
#import "CLPlayerView.h"


@interface DetailsViewController ()
@property(nonatomic,weak) CLPlayerView *playerView;

@end

@implementation DetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hidesBottomBarWhenPushed = YES;

}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;//设置导航栏是否半透明，解决界面跳转出现黑色阴影问题
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self simpleUIWebViewTest];
}

- (void)simpleUIWebViewTest {

    
    
    if ([self.type isEqualToString:@"article"]) {
        
    }else if([self.type isEqualToString:@"video"]){
        NSLog(@"videoURL = %@",self.videoURL);
        NSURL *mediaURL = [NSURL URLWithString:self.videoURL];
        
        CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width/16*9)];
        
        self.playerView = playerView;
        [self.view addSubview:self.playerView];
        //全屏是否隐藏状态栏，默认一直不隐藏
        self.playerView.fullStatusBarHiddenType = FullStatusBarHiddenFollowToolBar;
        //转子颜色
        self.playerView.strokeColor = [UIColor greenColor];
        //工具条消失时间，默认10s
        self.playerView.toolBarDisappearTime = 5;
        //顶部工具条隐藏样式，默认不隐藏
        self.playerView.topToolBarHiddenType = TopToolBarHiddenSmall;
        //视频地址
        self.playerView.url = mediaURL;
        [self.playerView playVideo];
        [self.playerView backButton:^(UIButton *button){
            NSLog(@"返回按钮被点击");
        }];
        [self.playerView endPlay:^{
            NSLog(@"播放完成");
        }];

    }else{
        // 1.创建webview，并设置大小，"20"为状态栏高度
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
        // 2.创建URL
        NSURL *url = [NSURL URLWithString:_webURL];
        // 3.创建Request
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        // 4.加载网页
        [webView loadRequest:request];
        // 5.最后将webView添加到界面
        [self.view addSubview:webView];
    }

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
