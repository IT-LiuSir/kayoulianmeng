//
//  LoginWithPasswordViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/2/12.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "LoginWithPasswordViewController.h"

@interface LoginWithPasswordViewController ()

@end

@implementation LoginWithPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorWithRGB(241, 242, 243, 1);
    self.navigationItem.title = @"密码登录";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.frame = CGRectMake(-10, 0, 44, 44);
    [leftBarBtn setImage:[UIImage imageNamed:@"return@2x.png"] forState:UIControlStateNormal];
    [leftBarBtn setImage:[UIImage imageNamed:@"return@2x.png"] forState:UIControlStateSelected];
    [leftBarBtn addTarget:self action:@selector(leftBarButton) forControlEvents:UIControlEventTouchUpInside];

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftView addSubview:leftBarBtn];

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];

    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)leftBarButton{
    [self.navigationController popViewControllerAnimated:YES];
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
