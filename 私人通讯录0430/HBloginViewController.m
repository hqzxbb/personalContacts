//
//  HBloginViewController.m
//  私人通讯录0430
//
//  Created by 黄宾宾 on 4/30/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBloginViewController.h"
#import "MBProgressHUD+MJ.h"

#define HBAccountKey @"account"
#define HBPwdKey @"pwd"
#define HBRmbPwdKey @"rmb_pwd"
#define HBAutoLoginKey @"auto_login"

@interface HBloginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *rememberpwd;
@property (weak, nonatomic) IBOutlet UISwitch *autologin;
- (IBAction)rememberpwdchange;
- (IBAction)autologinchange;
- (IBAction)backgroundTap;
- (IBAction)login;


@end

@implementation HBloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //代理
    //addTarget
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    //读取上一次的配置
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    self.accountField.text=[defaults objectForKey:HBAccountKey];
    //密码不能直接读到界面，要判断是否勾选记住密码
    self.rememberpwd.on=[defaults boolForKey:HBRmbPwdKey];
    self.autologin.on=[defaults boolForKey:HBAutoLoginKey];
    //处理密码
    if (self.rememberpwd.isOn) {
        self.pwdField.text=[defaults objectForKey:HBPwdKey];
    }
    //根据是否记住密码改变登录按钮的可点击状态
    self.loginBtn.enabled=(self.accountField.text.length&&self.pwdField.text.length);
    //处理自动登录
//    if (self.autologin.isOn) {
//        [self login];
//    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChange{
    //控制按钮的状态
    self.loginBtn.enabled=(self.accountField.text.length&&self.pwdField.text.length);
}


- (IBAction)rememberpwdchange {
    if (self.rememberpwd.isOn==NO) {
       // self.autologin.on=NO;
        [self.autologin setOn:NO animated:YES];
    }
}

- (IBAction)autologinchange {
    if (self.autologin.isOn) {
//        self.rememberpwd.on=YES;
        [self.rememberpwd setOn:YES animated:YES];
    }
}

- (IBAction)backgroundTap {
    [self.view endEditing:YES];
}

- (IBAction)login {
    [self.view endEditing:YES];
    if (![self.accountField.text isEqualToString:@"hb"]){
        [MBProgressHUD showError:@"账号错误"];
        return;
    }
    if(![self.pwdField.text isEqualToString:@"123"]){
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    [MBProgressHUD showMessage:@"登录成功，正在加载数据"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //移除遮盖
            [MBProgressHUD hideHUD]; 
            //执行login2contacts这个segue
            [self performSegueWithIdentifier:@"login2contacts" sender:nil];
            //存储数据
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:self.accountField.text forKey:HBAccountKey];
            [defaults setObject:self.pwdField.text forKey:HBPwdKey];
            [defaults setBool:self.rememberpwd.isOn forKey:HBRmbPwdKey];
            [defaults setBool:self.autologin.isOn forKey:HBAutoLoginKey];
            [defaults synchronize];
        
        });
    
}

/**
 *  执行segue后，跳转之前会调用这个方法
 *  一般在这里给下一个控制器传递数据
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [MBProgressHUD hideHUD];
    //取得目标控制器（联系人列表控制器）
    UIViewController *contactsViewController=segue.destinationViewController;
    //设置标题
    contactsViewController.title=[NSString stringWithFormat:@"%@的联系人列表",self.accountField.text];
    
    //上边这句代码跟下边的代码实现的同样的功能，title会调用navigationItem.title
    //contactsViewController.navigationItem.title=[NSString stringWithFormat:@"%@的联系人列表",self.accountField.text];
}






@end
