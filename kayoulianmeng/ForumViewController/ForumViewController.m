//
//  ForumViewController.m
//  kayoulianmeng
// ***************
//
//      论坛板块
//
// ***************
//  Created by 刘岩-MAC on 2018/1/7.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "ForumViewController.h"
#import "UIImageView+WebCache.h"

@interface ForumViewController ()

@end

@implementation ForumViewController
{
    
}
- (id)init{
    if([super init]){
        self.tabBarItem.title =@"论坛";
        self.tabBarItem.image =[UIImage imageNamed:@"tab_forunm_icon@2x.png"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"论坛";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, Screen_Width, Screen_Width/16*9)];
    
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view.
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
