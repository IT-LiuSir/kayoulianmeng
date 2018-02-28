//
//  LoginAndRegisterViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/2/12.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "BasicTextField.h"

@interface LoginAndRegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UIView *subView;
@property(nonatomic,strong) UITextField *phoneNumber;
@property(nonatomic,strong) UITextField *identifyingCode;
@property(nonatomic,strong) UIButton *identifyingCodeButton;
@property(nonatomic,strong) UIButton *loginButton;
@property (nonatomic, assign) BOOL isPhoneNumberEmpty;
@end

@implementation LoginAndRegisterViewController

NSInteger phoneNumLength;

- (void)viewDidLoad {
    [super viewDidLoad];
    phoneNumLength = 0;
    self.view.backgroundColor = UIColorWithRGB(241, 242, 243, 1);
    
    self.subView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, Screen_Width, 90)];
    self.subView.backgroundColor = [UIColor whiteColor];
    
    CAShapeLayer *middleLine = [CAShapeLayer layer];
    [middleLine setFillColor:[[UIColor clearColor] CGColor]];
    [middleLine setStrokeColor:[UIColorWithRGB(193, 193, 199, 1) CGColor]];
    middleLine.lineWidth = 0.1f;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(20, 45)];
    [path addLineToPoint:CGPointMake(Screen_Width, 45)];
    
    middleLine.path = path.CGPath;
    [self.subView.layer addSublayer:middleLine];
    
    
    [self customPhoneNumberTextField];
    [self customIdentifyingCodeButton];
    [self customIdentifyingCodeTextField];
    [self customLoginButton];
    [self.view addSubview:_subView];
}

- (void)customPhoneNumberTextField{
    self.phoneNumber = [[BasicTextField
 alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/3*2, 45)];
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumber.delegate = self;
    self.phoneNumber.tag = 7;
    self.phoneNumber.placeholder = @"手机号";
    [self.phoneNumber setFont:[UIFont systemFontOfSize:16]];
    self.phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumber.clearButtonMode = UITextFieldViewModeAlways;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNumberTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.phoneNumber];
//    [self.phoneNumber addTarget:self action:@selector(phoneNumberTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    self.isPhoneNumberEmpty = YES;
    [self.subView addSubview:self.phoneNumber];
}

- (void)customIdentifyingCodeTextField{
    self.identifyingCode = [[BasicTextField alloc] initWithFrame:CGRectMake(0, 45, Screen_Width-20, 45)];
    self.identifyingCode.keyboardType = UIKeyboardTypeNumberPad;
    self.identifyingCode.delegate = self;
    self.identifyingCode.tag = 11;
    self.identifyingCode.placeholder = @"验证码";
    [self.identifyingCode setFont:[UIFont systemFontOfSize:16]];
    self.identifyingCode.leftViewMode = UITextFieldViewModeAlways;
    self.identifyingCode.clearButtonMode = UITextFieldViewModeAlways;
    //设置监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(identifyingCodeTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.identifyingCode];
    self.isPhoneNumberEmpty = YES;
    [self.subView addSubview:self.identifyingCode];
}

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
    [self.identifyingCodeButton setTintColor:[UIColor whiteColor]];
    [self.identifyingCodeButton setEnabled:NO];
    [self.identifyingCodeButton addTarget:self action:@selector(identifyingCodeButtonDidChange) forControlEvents:UIControlEventTouchUpInside];
    
    [self.subView addSubview:_identifyingCodeButton];
}

- (void)customLoginButton{
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 210, Screen_Width-40, 50)];
    self.loginButton.backgroundColor = UIColorWithRGB(3, 209, 87, 1);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton.titleLabel setFont:[UIFont fontWithName:@"HeiTi-Blod" size:18]];
    [self.loginButton .layer setCornerRadius:5];
    [self.loginButton setTintColor:[UIColor whiteColor]];
    [self.loginButton addTarget:self action:@selector(loginButtonDidChange) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginButton];
}

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
        }
        phoneNumLength = self.phoneNumber.text.length;
        
    }else if (self.phoneNumber.text.length < phoneNumLength){//删除
        NSLog(@"删除第%ld个数字",self.phoneNumber.text.length);
        if (self.phoneNumber.text.length == 4 || self.phoneNumber.text.length == 9) {
            self.phoneNumber.text = [NSString stringWithFormat:@"%@",self.phoneNumber.text];
            self.phoneNumber.text = [self.phoneNumber.text substringToIndex:(self.phoneNumber.text.length-1)];
        }
        phoneNumLength = self.phoneNumber.text.length;
    }
    
    NSString *phone = [self.phoneNumber.text stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    BOOL isCrrectWithNumber = [self validateCellPhoneNumber:phone];
    if (isCrrectWithNumber) {
        [self.identifyingCodeButton setEnabled:YES];
        self.identifyingCodeButton.backgroundColor = UIColorWithRGB(30, 138, 255, 1);
    }else{
        [self.identifyingCodeButton setEnabled:NO];
        self.identifyingCodeButton.backgroundColor = UIColorWithRGB(197, 197, 197, 1);
    }
    
}

- (void)identifyingCodeTextFieldDidChange{
    if (self.identifyingCode.text.length >= 6) {
        self.identifyingCode.text = [self.identifyingCode.text substringToIndex:6];
        [self.identifyingCode resignFirstResponder];
    }
}

- (void)identifyingCodeButtonDidChange{
    NSString *phoneNum= [self.phoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];//去除手机号码中间的空格
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNum andTemplate:@"手机号码验证" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
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

- (void)loginButtonDidChange{
    NSString *phoneNum= [self.phoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];//去除手机号码中间的空格
    if (_identifyingCodeButton.isEnabled) {
        NSLog(@"输入验证码");
        if (self.identifyingCode.text.length == 6) {
            [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:phoneNum andSMSCode:self.identifyingCode.text resultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    NSLog(@"手机号验证成功");
                }else{
                    NSLog(@"手机号验证失败");
                }
            }];
        }
    }else{
        NSLog(@"输入手机号");
    }
}

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

#pragma mark -收起键盘
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
