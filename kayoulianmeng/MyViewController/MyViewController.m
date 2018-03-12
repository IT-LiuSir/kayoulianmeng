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
#import "UserInformationViewController.h"
#import "LY_WaveView.h"

@interface MyViewController ()<LY_WaveViewDelegate>
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) UIButton *userIconBtn;
@property(nonatomic,strong) UILabel *usernameLabel;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) LY_WaveView *waveView;
@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic,strong) LoginAndRegisterViewController *loginViewCtr;
@property(nonatomic,strong) UserInformationViewController *userInfomationCtr;
@property(nonatomic,strong) UINavigationController *loginNav;
@end

@implementation MyViewController
- (id)init{
    if([super init]){
        self.tabBarItem.title = @"我的";
        self.navigationItem.title = @"";
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

    [self.view addSubview:_imageView];
    [self setupUI];
    [self customLoginButton];
    [self customUserIconButton];
    [self customUsernameLabel];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //两种在tabbarController上加载视图方法
//    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:_loginNav.view];
//    [[[UIApplication sharedApplication].delegate window] addSubview:_loginNav.view];
    [self setUserInformation];
}

#pragma mark - 创建登录按钮
- (void)customLoginButton{
    CGFloat loginBtnX = Screen_Width/3;
    CGFloat loginBtnY = (Screen_Width*0.743*0.66 - Screen_Width/9)/2;
    CGFloat loginBtnW = Screen_Width/3;
    CGFloat loginBtnH = Screen_Width/9;
    
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH)];
    self.loginBtn.backgroundColor = [UIColor clearColor];
    [self.loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = kFont(15);
    [self.loginBtn.layer setCornerRadius:5];
    [self.loginBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.loginBtn.layer setBorderWidth:1.0];
    [self.loginBtn addTarget:self action:@selector(buttonDidChange:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.tag = 1;
    
    [self.view addSubview:_loginBtn];
}

#pragma mark - 按钮响应方法
- (void)buttonDidChange:(UIButton *)button{
    switch (button.tag) {
        case 1:{
            //在tabbarController上加载视图，也可以写在viewWillAppear里
            [[[UIApplication sharedApplication].delegate window] addSubview:_loginNav.view];
            NSLog(@"这是登录按钮");
            [self presentViewController:self.loginNav animated:YES completion:nil];
            
            break;
            }
        default:
            break;
    }
}

#pragma mark - 创建波浪线UI动画效果
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
    [self.view addSubview:self.waveView];
}

#pragma mark - 添加用户信息
- (void)setUserInformation{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.username = [userDefaults objectForKey:@"username"];
    if (self.username) {
        self.loginBtn.hidden = YES;
        self.userIconBtn.hidden = NO;
        self.usernameLabel.hidden = NO;
        self.usernameLabel.text = _username;
    }
}

#pragma mark - 创建用户头像Button
- (void)customUserIconButton{
    self.userIconBtn = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width-Screen_Width/5)/2, 64, Screen_Width/5, Screen_Width/5)];
    self.userIconBtn.hidden = YES;
    self.userIconBtn.backgroundColor = [UIColor lightGrayColor];
    self.userIconBtn.layer.cornerRadius = _userIconBtn.frame.size.width/2;
    [self.userIconBtn setImage:[UIImage imageNamed:@"userIcon@2x.png"] forState:UIControlStateNormal];
    [self.userIconBtn addTarget:self action:@selector(userIconDidChange) forControlEvents:UIControlEventTouchUpInside];
//    self.userIconBtn.layer.masksToBounds = YES;
    [self.view addSubview:_userIconBtn];
}

- (void)userIconDidChange{
    self.userInfomationCtr = [[UserInformationViewController alloc] init];
    self.userInfomationCtr.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:_userInfomationCtr animated:YES];
}

#pragma mark - 创建用户名Label
- (void)customUsernameLabel{
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/4, Screen_Width*0.743/2, Screen_Width/2, 30)];
//    self.usernameLabel.backgroundColor = [UIColor orangeColor];
    self.usernameLabel.hidden = YES;
    self.usernameLabel.textAlignment = NSTextAlignmentCenter;
    self.usernameLabel.textColor = [UIColor whiteColor];
    self.usernameLabel.font = kFont(20);
    [self.view addSubview:_usernameLabel];
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
    
    button.tag = 10*row+column; //需修改，不能和首页的button的tag相同
    [button addTarget:self action:@selector(buttonDidChange:) forControlEvents:UIControlEventTouchUpInside];
    
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
