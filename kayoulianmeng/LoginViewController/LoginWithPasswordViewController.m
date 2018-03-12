//
//  LoginWithPasswordViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/2/12.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "LoginWithPasswordViewController.h"
#import "BasicTextField.h"

@interface LoginWithPasswordViewController ()<UITextFieldDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong) UIView *subView;
@property(nonatomic,strong) NSString *userName; //用户名
@property(nonatomic,strong) NSString *password; //密码
@property(nonatomic,strong) UITextField *userNameTF;   //用户名TF
@property(nonatomic,strong) UITextField *passwordTF;   //密码TF
@property(nonatomic,strong) UIButton *passwordBtn;      //密码显示开启和关闭
@property(nonatomic,strong) UIButton *forgetPasswordBtn;    //忘记密码按钮
@property(nonatomic,strong) UIButton *loginButton;  //登录按钮
@property(nonatomic,strong) MBProgressHUD *MB_HUD;
@end

@implementation LoginWithPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorWithRGB(241, 242, 243, 1);
    self.navigationItem.title = @"密码登录";
    //设置字体颜色及字体样式
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19 weight:UIFontWeightBold],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
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
    
    [self customSubView];
    [self customUserNameTextField];
    [self customPasswordTextField];
    [self customPasswordButton];
    [self customLoginButton];
    [self customForgetPasswordButton];
    
    //初始化MB_HUD
    self.MB_HUD = [[MBProgressHUD alloc] init];
    self.MB_HUD.delegate = self;
    [self.navigationController.view addSubview:_MB_HUD];
}
#pragma mark - 返回按钮
- (void)leftBarButton{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 创建SubView
- (void)customSubView{
    self.subView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, Screen_Width, 90)];
    self.subView.backgroundColor = [UIColor whiteColor];
    
    //手机号和验证码中间的分割线
    CAShapeLayer *middleLine = [CAShapeLayer layer];
    [middleLine setFillColor:[[UIColor clearColor] CGColor]];
    [middleLine setStrokeColor:[UIColorWithRGB(193, 193, 199, 1) CGColor]];
    middleLine.lineWidth = 0.1f;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(20, 45)];
    [path addLineToPoint:CGPointMake(Screen_Width, 45)];
    
    middleLine.path = path.CGPath;
    [self.subView.layer addSublayer:middleLine];
    [self.view addSubview:_subView];
}

#pragma mark - 创建用户名TextField
- (void)customUserNameTextField{
    self.userNameTF = [[BasicTextField
                         alloc] initWithFrame:CGRectMake(0, 0, Screen_Width-20, 45)];
    self.userNameTF.keyboardType = UIKeyboardTypeDefault;
    self.userNameTF.returnKeyType = UIReturnKeyNext;
    self.userNameTF.autocorrectionType = YES;    //关闭键盘联想功能
    self.userNameTF.delegate = self;
    self.userNameTF.placeholder = @"手机/邮箱/用户名";
    [self.userNameTF setFont:[UIFont systemFontOfSize:16]];
    self.userNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTF.clearButtonMode = UITextFieldViewModeAlways;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userNameTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.userNameTF];
    [self.subView addSubview:self.userNameTF];
}

#pragma mark - 创建密码TextField
- (void)customPasswordTextField{
    self.passwordTF = [[BasicTextField alloc] initWithFrame:CGRectMake(0, 45, Screen_Width-50, 45)];
    self.passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTF.returnKeyType = UIReturnKeyDone;
    self.passwordTF.delegate = self;
    self.passwordTF.placeholder = @"密码";
    [self.passwordTF setFont:[UIFont systemFontOfSize:16]];
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.clearButtonMode = UITextFieldViewModeAlways;
    //设置监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.passwordTF];
    //    self.isPhoneNumberEmpty = YES;
    [self.subView addSubview:self.passwordTF];
}

#pragma mark - 创建密码显示按钮
- (void)customPasswordButton{
    self.passwordBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 50 , 47.5, 40, 40)];
    self.passwordBtn.backgroundColor = [UIColor whiteColor];
    [self.passwordBtn setAdjustsImageWhenHighlighted:NO];
    [self.passwordBtn setImage:[UIImage imageNamed:@"password1@2x.png"] forState:UIControlStateNormal];
    [self.passwordBtn addTarget:self action:@selector(passwordButtonDidChange) forControlEvents:UIControlEventTouchUpInside];
    [self.subView addSubview:_passwordBtn];
}

- (void)passwordButtonDidChange{
    //密码是否显示，并且改变Button的图片
    if (self.passwordTF.isSecureTextEntry) {
        //解决显示密码光标偏移，需要重新赋值
        NSString *passwordStr = self.passwordTF.text;
        self.passwordTF.text = @"";
        self.passwordTF.secureTextEntry = NO;
        self.passwordTF.text = passwordStr;
        [self.passwordBtn setImage:[UIImage imageNamed:@"password2@2x.png"] forState:UIControlStateNormal];
    }else{
        self.passwordTF.secureTextEntry = YES;
        [self.passwordBtn setImage:[UIImage imageNamed:@"password1@2x.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - 创建登录按钮
- (void)customLoginButton{
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 210, Screen_Width-40, 50)];
    self.loginButton.backgroundColor = UIColorWithRGB(3, 209, 87, 1);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightBold]];
    [self.loginButton.layer setCornerRadius:5];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonDidChange) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginButton];
}

#pragma mark - 创建忘记密码按钮
- (void)customForgetPasswordButton{
    self.forgetPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width-80, 260, 70, 40)];
    self.forgetPasswordBtn.backgroundColor = [UIColor clearColor];
    [self.forgetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetPasswordBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.forgetPasswordBtn setTitleColor:UIColorWithRGB(25, 143, 255, 1) forState:UIControlStateNormal];
    [self.forgetPasswordBtn addTarget:self action:@selector(passwordTextFieldDidChange) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_forgetPasswordBtn];
}
#pragma mark - 用户名TextField是否被改变
- (void)userNameTextFieldDidChange{
    self.userName = self.userNameTF.text;
}

#pragma mark - 密码TextField是否被改变
- (void)passwordTextFieldDidChange{
    self.password = self.passwordTF.text;
}

#pragma mark - 登录按钮是否被改变
- (void)loginButtonDidChange{
    NSLog(@"密码登录按钮");
    [BmobUser loginInbackgroundWithAccount:self.userName andPassword:self.password block:^(BmobUser *user, NSError *error) {
        
    }];
}

#pragma mark - 键盘Next建响应方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //该方法需要TextField实现delegate后使用
    if (textField ==self.userNameTF) {
        NSLog(@"键盘NEXT键");
        [self.userNameTF resignFirstResponder];
        [self.passwordTF becomeFirstResponder];
    }else{
        [self loginButtonDidChange];
    }
    return YES;
}

#pragma mark - 收起键盘
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    //实现该方法是需要注意view需要是继承UIControl而来的
    [self.view endEditing:YES];
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
