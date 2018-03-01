//
//  DetailsViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/2/27.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "DetailsViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface DetailsViewController ()
@property (nonatomic,strong) AVPlayer *myPlayer;//播放器
@property (nonatomic,strong) AVAsset *asset;
@property (nonatomic,strong) AVPlayerItem *item;//播放单元
@property (nonatomic,strong) AVPlayerLayer *playerLayer;//播放界面（layer）
@end

@implementation DetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    

//    [self simpleUIWebViewTest];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
   [self simpleUIWebViewTest];
}

- (void)simpleUIWebViewTest {

    
    
    if ([self.type isEqualToString:@"article"]) {
        
    }else if([self.type isEqualToString:@"video"]){
        NSLog(@"videoURL = %@",self.videoURL);
        NSURL *mediaURL = [NSURL URLWithString:self.videoURL];
        self.asset = [AVAsset assetWithURL:mediaURL];
        self.item = [AVPlayerItem playerItemWithAsset:self.asset];
        
        [self.item addObserver:self forKeyPath:@"status" options:0 context:nil];
        self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
        self.playerLayer.frame = CGRectMake(0, 64, Screen_Width, Screen_Width/16*9);
        self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.view.layer addSublayer:self.playerLayer];
        [self.myPlayer play];
    }else{
        // 1.创建webview，并设置大小，"20"为状态栏高度
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
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
