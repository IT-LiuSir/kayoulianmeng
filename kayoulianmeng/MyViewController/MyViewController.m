//
//  MyViewController.m
//  kayoulianmeng
//
// ***************
//
//      个人板块
//
// ***************
//  Created by 刘岩-MAC on 2018/1/5.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "MyViewController.h"
#import "LoginAndRegisterViewController.h"
#import "LoginWithPasswordViewController.h"
#import "LY_WaveView.h"

@interface MyViewController ()<LY_WaveViewDelegate>
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) LY_WaveView *waveView;
@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic,strong) LoginAndRegisterViewController *loginViewCtr;
@property(nonatomic,strong) LoginWithPasswordViewController *loginWithPasswordCtr;
@property(nonatomic,strong) UINavigationController *loginNav;
@end

@implementation MyViewController
- (id)init{
    if([super init]){
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_my_icon@2x.png"];
        self.view.backgroundColor = UIColorWithRGB(241, 242, 243, 1);
    }
    return self;
}
//设置状态栏字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
//
//    return UIStatusBarAnimationFade;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width * 0.743)];
    self.imageView.image = [UIImage imageNamed:@"background.png"];
    
    self.loginViewCtr = [[LoginAndRegisterViewController alloc] init];

    
    self.loginNav = [[UINavigationController alloc] initWithRootViewController:_loginViewCtr];
    self.loginNav.view.frame = CGRectMake(0, Screen_Height, Screen_Width, Screen_Height);
    
    self.loginViewCtr.navigationController.navigationBar.barTintColor = UIColorWithRGB(3, 152, 255, 1);
    self.loginViewCtr.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.loginViewCtr.navigationItem.title = @"登录";
    
    //设置字体颜色及字体样式
    [self.loginViewCtr.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.frame = CGRectMake(-10, 0, 44, 44);
    [leftBarBtn setImage:[UIImage imageNamed:@"guanbi@2x.png"] forState:UIControlStateNormal];
    [leftBarBtn setImage:[UIImage imageNamed:@"guanbi@2x.png"] forState:UIControlStateSelected];
    [leftBarBtn addTarget:self action:@selector(leftBarButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftView addSubview:leftBarBtn];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    self.loginViewCtr.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.frame = CGRectMake(0, 0, 88, 44);
    [rightBarBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [rightBarBtn.titleLabel setTextColor:[UIColor whiteColor]];
    rightBarBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    rightBarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBarBtn addTarget:self action:@selector(rightBarButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    [rightView addSubview:rightBarBtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.loginViewCtr.navigationItem.rightBarButtonItem = rightItem;
    
    CGFloat loginBtnX = Screen_Width/3;
    CGFloat loginBtnY = (Screen_Width*0.743*0.66 - Screen_Width/9)/2;
    CGFloat loginBtnW = Screen_Width/3;
    CGFloat loginBtnH = Screen_Width/9;
    
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH)];
    self.loginBtn.backgroundColor = [UIColor clearColor];
    [self.loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.loginBtn setTintColor:[UIColor whiteColor]];
    self.loginBtn.titleLabel.font = kFont(15);
    [self.loginBtn.layer setCornerRadius:5];
    [self.loginBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.loginBtn.layer setBorderWidth:1.0];
    [self.loginBtn addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.tag = 1;
    


    
    
    [self.view addSubview:_imageView];
    [self setupUI];
    [self.view addSubview:self.waveView];
    [self.view addSubview:_loginBtn];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
//    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:_loginNav.view];
//    [[[UIApplication sharedApplication].delegate window] addSubview:_loginNav.view];

}

- (void)button:(UIButton *)button{
    switch (button.tag) {
        case 1:{
            [[[UIApplication sharedApplication].delegate window] addSubview:_loginNav.view];
            NSLog(@"这是登录按钮");
            [UIView animateWithDuration:0.5 animations:^{
                self.loginNav.view.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
            }];

            
            break;
            }
        default:
            break;
    }
}

- (void)leftBarButton{
    NSLog(@"zheshifanhui ");
    //收起键盘
    [self.loginNav.view endEditing:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.loginNav.view.frame = CGRectMake(0, Screen_Height, Screen_Width, Screen_Height);
    }];

}

- (void)rightBarButton{
    NSLog(@"zheshifanhui ");
    self.loginWithPasswordCtr = [[LoginWithPasswordViewController alloc] init];
    [self.loginNav pushViewController:_loginWithPasswordCtr animated:YES];
    
}

- (void)setupUI {
    
    NSArray *colors = @[(__bridge id)[UIColor colorWithRed:80/255.0 green:140/255.0 blue:239/255.0 alpha:0.8].CGColor, (__bridge id)[UIColor colorWithRed:80/255.0 green:140/255.0 blue:239/255.0 alpha:0.8].CGColor];  //里
    NSArray *sColors = @[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor whiteColor].CGColor];  //外
    
    //方形波浪
    self.waveView = [[LY_WaveView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width*0.743)];
    self.waveView.colors = colors;
    self.waveView.sColors = sColors;
    self.waveView.percent = 0.33;
    self.waveView.delegate = self;
    [self.waveView startWave];
}

- (void)ButtonWithTitle:(NSString*)title image:(NSString*)imageName row:(int)row column:(int)column{
    CGFloat buttonH = Screen_Width/5;
    CGFloat buttonW = Screen_Width/5;
    
    CGFloat imageH = buttonW/2;
    CGFloat imageW = buttonW/2;
    
    CGFloat labelH = buttonH/3;
    CGFloat labelW = Screen_Width/5;
    
    CGFloat buttonX = (column - 1) * buttonW;
    CGFloat buttonY = Screen_Width/16*9 + (row - 1) * buttonW;
    
    
    CGFloat imgaeX ;
    CGFloat imageY ;
    
    CGFloat labelX ;
    CGFloat labelY ;
    
    if (row == 1) {
        imgaeX = (buttonW - imageW)/2;
        imageY = buttonH - imageH - labelH;
        
        labelX = 0;
        labelY = buttonH - labelH;
    }else{
        imgaeX = (buttonW - imageW)/2;
        imageY = buttonH - imageH - labelH-(buttonH - imageH - labelH)/2;
        
        labelX = 0;
        labelY = buttonH - labelH-(buttonH - imageH - labelH)/2;
    }
    
    
    UIButton *button = [[UIButton alloc] init];
    UIImageView *buttonImageView = [[UIImageView alloc] init];
    UILabel *buttonLaber = [[UILabel alloc] init];
    //    buttonLaber.textColor = [UIColor blackColor];
    button.backgroundColor = [UIColor whiteColor];
    //    buttonLaber.backgroundColor = [UIColor redColor];
    
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    //        button.layer.cornerRadius = (buttonHight-50)/2;
    buttonImageView.frame = CGRectMake(imgaeX, imageY, imageW, imageH);
    [buttonImageView setImage:[UIImage imageNamed:imageName]];
    buttonImageView.layer.cornerRadius = buttonImageView.frame.size.width/4;
    buttonImageView.layer.masksToBounds = YES;
    buttonLaber.frame = CGRectMake(labelX, labelY, labelW, labelH);
    buttonLaber.text = title;
    buttonLaber.textAlignment=NSTextAlignmentCenter;
    buttonLaber.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(8)];
    
    [button addSubview:buttonImageView];
    [button addSubview:buttonLaber];
//    [_subView addSubview:button];
    
    button.tag = 10*row+column;
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
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
