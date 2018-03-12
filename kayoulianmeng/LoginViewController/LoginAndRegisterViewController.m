//
//  LoginAndRegisterViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/2/12.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "LoginWithPasswordViewController.h"
#import "BasicTextField.h"

@interface LoginAndRegisterViewController ()<UITextFieldDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong) LoginWithPasswordViewController *loginWithPasswordCtr;
@property(nonatomic,strong) UIView *subView;
@property(nonatomic,strong) NSString *phoneNum; //手机号
@property(nonatomic,strong) UITextField *phoneNumber;   //手机号TF
@property(nonatomic,strong) UITextField *identifyingCode;   //验证码TF
@property(nonatomic,strong) UILabel *kindlyReminderLabel;   //温馨提示
@property(nonatomic,strong) UIButton *identifyingCodeButton;    //验证码按钮
@property(nonatomic,strong) UIButton *loginButton;  //登录按钮
//@property(nonatomic, assign) BOOL isPhoneNumberEmpty; //手机号是否无效
@property(nonatomic,strong) MBProgressHUD *MB_HUD;
@end

@implementation LoginAndRegisterViewController

NSInteger phoneNumLength;   //全局变量

- (void)viewDidLoad {
    [super viewDidLoad];
    phoneNumLength = 0;
    self.view.backgroundColor = UIColorWithRGB(241, 242, 243, 1);
    self.loginWithPasswordCtr = [[LoginWithPasswordViewController alloc] init];
    [self initNavigation];
    
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
    
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:@"温馨提示：未注册卡友联盟的手机号，登录时将自动注册，且代表您已经同意《用户服务协议》"];
    [mutableString addAttribute:NSForegroundColorAttributeName value:UIColorWithRGB(160, 160, 160, 1) range:NSMakeRange(0, 34)];
    [mutableString addAttribute:NSForegroundColorAttributeName value:UIColorWithRGB(25, 143, 255, 1) range:NSMakeRange(34, 8)];
    [mutableString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, mutableString.length)];
    
    self.kindlyReminderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, Screen_Width-40, 40)];
    self.kindlyReminderLabel.backgroundColor = [UIColor clearColor];
    self.kindlyReminderLabel.numberOfLines = 0;
    [self.kindlyReminderLabel setAttributedText:mutableString];

    [self customPhoneNumberTextField];
    [self customIdentifyingCodeButton];
    [self customIdentifyingCodeTextField];
    [self customLoginButton];
    [self.view addSubview:_subView];
    [self.view addSubview:_kindlyReminderLabel];
    
    //初始化MB_HUD
    self.MB_HUD = [[MBProgressHUD alloc] init];
    self.MB_HUD.delegate = self;
    [self.navigationController.view addSubview:_MB_HUD];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
#pragma mark - 初始化导航栏
- (void)initNavigation{

    self.navigationController.navigationBar.barTintColor = UIColorWithRGB(3, 152, 255, 1);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";

    //设置字体颜色及字体样式
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19 weight:UIFontWeightBold],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.frame = CGRectMake(-10, 0, 44, 44);
    [leftBarBtn setImage:[UIImage imageNamed:@"guanbi@2x.png"] forState:UIControlStateNormal];
    [leftBarBtn setImage:[UIImage imageNamed:@"guanbi@2x.png"] forState:UIControlStateSelected];
    [leftBarBtn addTarget:self action:@selector(leftBarButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftView addSubview:leftBarBtn];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
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
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 登录页面返回按钮
- (void)leftBarButton{
    NSLog(@"登录返回按钮");
    //收起键盘
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 密码登录按钮
- (void)rightBarButton{
    NSLog(@"密码登录");
    [self.navigationController pushViewController:_loginWithPasswordCtr animated:YES];
    
}

#pragma mark - 创建手机号TextField
- (void)customPhoneNumberTextField{
    self.phoneNumber = [[BasicTextField
 alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/3*2, 45)];
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumber.delegate = self;

    self.phoneNumber.placeholder = @"手机号";
    [self.phoneNumber setFont:[UIFont systemFontOfSize:16]];
    self.phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumber.clearButtonMode = UITextFieldViewModeAlways;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNumberTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.phoneNumber];
//    [self.phoneNumber addTarget:self action:@selector(phoneNumberTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.subView addSubview:self.phoneNumber];
}
#pragma mark - 创建验证码TextField
- (void)customIdentifyingCodeTextField{
    self.identifyingCode = [[BasicTextField alloc] initWithFrame:CGRectMake(0, 45, Screen_Width-20, 45)];
    self.identifyingCode.keyboardType = UIKeyboardTypeNumberPad;
    self.identifyingCode.delegate = self;
    self.identifyingCode.placeholder = @"验证码";
    [self.identifyingCode setFont:[UIFont systemFontOfSize:16]];
    self.identifyingCode.leftViewMode = UITextFieldViewModeAlways;
    self.identifyingCode.clearButtonMode = UITextFieldViewModeAlways;
    //设置监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(identifyingCodeTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.identifyingCode];
    [self.subView addSubview:self.identifyingCode];
}
#pragma mark - 创建验证码获取按钮
- (void)customIdentifyingCodeButton{
    self.identifyingCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width/3*2 + 10, 5, Screen_Width/3 - 30, 35)];
    self.identifyingCodeButton.backgroundColor = UIColorWithRGB(197, 197, 197, 1);
    [self.identifyingCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    if (Screen_Width >= 375) {
        [self.identifyingCodeButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }else{
        [self.identifyingCodeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    [self.identifyingCodeButton.layer setCornerRadius:5];
    [self.identifyingCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.identifyingCodeButton setEnabled:NO];
    [self.identifyingCodeButton addTarget:self action:@selector(identifyingCodeButtonDidChange) forControlEvents:UIControlEventTouchUpInside];
    
    [self.subView addSubview:_identifyingCodeButton];
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
#pragma mark - 手机号TextField是否改变
- (void)phoneNumberTextFieldDidChange{
//
//    UITextRange *textRang = [self.phoneNumber selectedTextRange];
//    UITextPosition *selectionStart = textRang.start;
//    UITextPosition *selectionEnd = textRang.end;
//    NSInteger location = [self.phoneNumber offsetFromPosition:selectionStart
//                                                   toPosition:selectionEnd];
//
//    NSLog(@"光标位置%ld",location);
    
    if (self.phoneNumber.text.length > phoneNumLength) {
        if (self.phoneNumber.text.length == 4 || self.phoneNumber.text.length == 9 ) {//输入
            NSMutableString * str = [[NSMutableString alloc ] initWithString:self.phoneNumber.text];
            [str insertString:@" " atIndex:(self.phoneNumber.text.length-1)];
            self.phoneNumber.text = str;
        }if (self.phoneNumber.text.length >= 13 ) {//输入完成
            self.phoneNumber.text = [self.phoneNumber.text substringToIndex:13];
            [self.phoneNumber resignFirstResponder];
            //判断手机号是否合法，不合法则弹出对话框提示用户输入正确的号码
            NSString *phone = [self.phoneNumber.text stringByReplacingOccurrencesOfString:@" "withString:@""];
            BOOL isCrrectWithNumber = [self validateCellPhoneNumber:phone];     //检测手机号码是否合法
            if (isCrrectWithNumber) {
                [self.identifyingCodeButton setEnabled:YES];
                self.identifyingCodeButton.backgroundColor = UIColorWithRGB(30, 138, 255, 1);
            }else{
                [self.identifyingCodeButton setEnabled:NO];
                self.identifyingCodeButton.backgroundColor = UIColorWithRGB(197, 197, 197, 1);
                
                [self showMB_HUD:@"请输入正确的手机号" andWithType:2];
            }
        }
        phoneNumLength = self.phoneNumber.text.length;
        
    }else if (self.phoneNumber.text.length < phoneNumLength){//删除
        [self.identifyingCodeButton setEnabled:NO];
        self.identifyingCodeButton.backgroundColor = UIColorWithRGB(197, 197, 197, 1);
        NSLog(@"删除第%ld个数字",self.phoneNumber.text.length);
        if (self.phoneNumber.text.length == 4 || self.phoneNumber.text.length == 9) {
            self.phoneNumber.text = [NSString stringWithFormat:@"%@",self.phoneNumber.text];
            self.phoneNumber.text = [self.phoneNumber.text substringToIndex:(self.phoneNumber.text.length-1)];
        }
        phoneNumLength = self.phoneNumber.text.length;
    }
    
    
    
}
#pragma mark - 验证码TextField是否改变
- (void)identifyingCodeTextFieldDidChange{
    if (self.identifyingCode.text.length >= 6) {
        self.identifyingCode.text = [self.identifyingCode.text substringToIndex:6];
        [self.identifyingCode resignFirstResponder];
    }
}
#pragma mark - 获取手机验证码
- (void)identifyingCodeButtonDidChange{
    NSString *phoneNum= [self.phoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];//去除手机号码中间的空格
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNum andTemplate:@"手机号码验证" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
//            self.SMS_Number = [NSString stringWithFormat:@"%d",number];
            NSLog(@"SMS ID:%d",number);
        }
    }];
    
    __block int timeout=30; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [self.identifyingCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
                
                self.identifyingCodeButton.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
//                NSLog(@"____%@",strTime);
                
                [self.identifyingCodeButton setTitle:[NSString stringWithFormat:@"已发送(%@)",strTime] forState:UIControlStateNormal];
                
                self.identifyingCodeButton.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}

#pragma mark - 登录
- (void)loginButtonDidChange{
    self.phoneNum= [self.phoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];//去除手机号码中间的空格
    if (_identifyingCodeButton.isEnabled) {
        NSLog(@"输入验证码");
        [self showMB_HUD:@"请输入验证码" andWithType:2];
        if (self.identifyingCode.text.length == 6) {
            [self showMB_HUD:@"" andWithType:1];
            [BmobUser signOrLoginInbackgroundWithMobilePhoneNumber:self.phoneNum andSMSCode:self.identifyingCode.text block:^(BmobUser *user, NSError *error) {
                if(user){
                    NSLog(@"%@",user);
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:[user valueForKey:@"username"] forKey:@"username"];
                    [userDefaults setObject:[user valueForKey:@"mobilePhoneNumber"] forKey:@"mobilePhoneNumber"];
                    [userDefaults setObject:[user valueForKey:@"email"] forKey:@"email"];
                    [userDefaults setObject:[user valueForKey:@"createdAt"] forKey:@"createdAt"];
                    [userDefaults setObject:[user valueForKey:@"updatedAt"] forKey:@"updatedAt"];
                    [userDefaults setObject:[[user objectForKey:@"data"][2] valueForKey:@"sessionToken"] forKey:@"sessionToken"];
                    /*
                     *  className = _User;
                     
                     username = 13028269988;
                     
                     mobilePhoneNumber = 13028269988;
                     
                     email = (null);
                     objectId = 47ef0c62b1;
                     createdAt = 2018-03-11 13:31:12 +0000;
                     updatedAt = 2018-03-11 13:31:12 +0000;
                     data = {
                     createdAt = "2018-03-11 21:31:12";
                     mobilePhoneNumber = 13028269988;
                     sessionToken = 074f4f264003d120804dc73f2dd5aef4;
                     username = 13028269988;
                     };
                     */
                    [self showMB_HUD:@"登录成功" andWithType:2];
                    int64_t delayInSeconds = 1.5; // 延迟的时间
                    /*
                     *@parameter 1,时间参照，从此刻开始计时
                     *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
                     */
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [self.navigationController.view endEditing:YES];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                    
                }else{
                    NSLog(@"%@",error);
                    [self showMB_HUD:@"验证码错误" andWithType:2];
                }
            }];
        }else if(self.identifyingCode.text.length > 0 ){
            [self showMB_HUD:@"请输入正确的验证码" andWithType:2];
        }
    }else{
        NSLog(@"输入手机号");
        [self showMB_HUD:@"请输入正确的手机号" andWithType:2];
    }
}


#pragma mark - 显示MB_HUD提示框
- (void)showMB_HUD:(NSString *)string andWithType:(NSInteger)integer{
//    MBProgressHUDModeIndeterminate,//菊花，默认值
//    MBProgressHUDModeDeterminate,//圆饼，饼状图
//    MBProgressHUDModeDeterminateHorizontalBar,///水平进度条
//    MBProgressHUDModeAnnularDeterminate,//圆环作为进度条
//    MBProgressHUDModeCustomView,//需要设置自定义视图时候设置成这个
//    MBProgressHUDModeText,//只显示文本
    
//    MBProgressHUDAnimationFade,//默认类型
//    MBProgressHUDAnimationZoom,//出现和消失时渐变
//    MBProgressHUDAnimationZoomOut,////消失时透明效果变化
//    MBProgressHUDAnimationZoomIn,////出现时透明效果变化
    
//    MBProgressHUD进度条的背景样式
//    MBProgressHUDBackgroundStyleSolidColor,
//    MBProgressHUDBackgroundStyleBlur
    
    switch (integer) {
        case 1:
            self.MB_HUD.mode = MBProgressHUDModeIndeterminate;
            self.MB_HUD.minShowTime = 100;
            break;
        case 2:
            self.MB_HUD.mode = MBProgressHUDModeText;
            self.MB_HUD.minShowTime = 2;
            break;
            
        default:
            break;
    }

    self.MB_HUD.label.text = string;
    self.MB_HUD.label.textColor = [UIColor whiteColor];
    self.MB_HUD.bezelView.backgroundColor = UIColorWithRGB(0, 0, 0, 0.7);
    //                self.MB_HUD.square = YES; //是否强制背景框宽高相等
    self.MB_HUD.minShowTime = 2;
    [self.MB_HUD showAnimated:YES];
    [self.MB_HUD hideAnimated:YES];
}

#pragma mark - 手机号校验
- (BOOL)validateCellPhoneNumber:(NSString *)cellNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,166,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|66|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if(([regextestmobile evaluateWithObject:cellNum] == YES)
       || ([regextestcm evaluateWithObject:cellNum] == YES)
       || ([regextestct evaluateWithObject:cellNum] == YES)
       || ([regextestcu evaluateWithObject:cellNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 收起键盘
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    //实现该方法是需要注意view需要是继承UIControl而来的
    [self.view endEditing:YES];
    
    //第二种关闭键盘的方法
//    [self.phoneNumber resignFirstResponder];
//    [self.identifyingCode resignFirstResponder];
    
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
