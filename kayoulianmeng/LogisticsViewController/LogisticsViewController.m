//
//  TalkViewController.m
//  kayoulianmeng
//
// ***************
//
//      talk板块
//
// ***************
//  Created by 刘岩-MAC on 2018/1/7.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "LogisticsViewController.h"

@interface LogisticsViewController ()

@end

@implementation LogisticsViewController
- (id)init{
    if([super init]){
        self.tabBarItem.title =@"货运";
        self.tabBarItem.image =[UIImage imageNamed:@"ic_show_msg@2x.png"];
        

        
    }

    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EMError *error = [[EMClient sharedClient] registerWithUsername:@"kayouliammeng001" password:@"111111"];
    if (error==nil) {
        NSLog(@"注册成功");
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
