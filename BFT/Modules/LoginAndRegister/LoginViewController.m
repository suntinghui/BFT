//
//  LoginViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-8.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "LoginViewController.h"
#import "LeftMenuViewController.h"
#import "HomeViewController.h"
#import "RegisterViewController.h"

#define Button_Tag_Register        100 //注册
#define Button_Tag_Login           101 //登录
#define Button_Tag_VerCode         102 //获取验证码
#define Button_Tag_RemenerPassword 103 //记住密码
#define Button_Tag_GetBackPassword 104 //取回密码

#define kRemenbPassword   @"RemenberPassword"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationItem.title = @"登录";
    self.navigationItem.hidesBackButton = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    addKeyBoardNotification = YES;

    [self.verCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    self.remenberPswBtn.selected = [UserDefaults boolForKey:kRemenbPassword];
    
//    [self getAppVersion]; TODO
    
    //直接请求时 超时  原因未知
    [self performSelector:@selector(getPicVerCode) withObject:nil afterDelay:0.5];
    
    self.userNameTxtField.text = @"18734825880"; //TODO
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -功能函数
- (BOOL)checkInputValue
{
    NSString *err;
    if ([StaticTools isEmptyString:self.userNameTxtField.text])
    {
        err = @"请输入用户名";
    }
    else if([StaticTools isEmptyString:self.tf_pwd.pwdTF.text])
    {
        err = @"请输入密码";
    }
    else if([StaticTools isEmptyString:self.codeTxtField.text])
    {
        err = @"请输入验证码";
    }
    if (err!=nil)
    {
    [SVProgressHUD showErrorWithStatus:err];
    return NO;
    }
    return YES;
}
- (void)gotoHome
{
    HomeViewController *homeController = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:homeController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark -按钮点击事件
- (IBAction)buttonClickHandle:(id)sender
{
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case Button_Tag_Register: //注册
        {
            RegisterViewController *registerController = [[RegisterViewController alloc]init];
            [self.navigationController pushViewController:registerController animated:YES];
        }
            break;
        case Button_Tag_Login: //登录
        {
            [self loginAction];
//            [self gotoHome];
        }
            break;
        case Button_Tag_VerCode: //获取验证码
        {
            [self getPicVerCode];
        }
            break;
        case Button_Tag_RemenerPassword: //记住密码
        {
            [self.remenberPswBtn setSelected:!self.remenberPswBtn.selected];
            [UserDefaults setBool:self.remenberPswBtn.selected forKey:kRemenbPassword];
            [UserDefaults synchronize];
        }
            break;
        case Button_Tag_GetBackPassword: //取回密码
        {
            GetBackPwdViewController *vc = [[GetBackPwdViewController alloc] initWithNibName:@"GetBackPwdViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }

}

#pragma mark -UItextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.loginView.frame = CGRectMake(10, -15, 300, 330);
    }];
    
}
- (void)keyBoardHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.loginView.frame = CGRectMake(10, 35, 300, 330);
    }];
}

#pragma mark -http请求
/**
 *  获取图片验证码
 */
- (void)getPicVerCode
{
    NSDictionary *requestDict = @{@"sendTime":[StaticTools getDateStrWithDate:[NSDate date] withCutStr:@"" hasTime:YES]};
    
    [[Transfer sharedTransfer] startTransfer:@"089021"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requestDict
                                        mess:@"正在获取验证码"
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                              [self.verCodeBtn setTitle:result[@"verifyCode"] forState:UIControlStateNormal];
                                         }
                                         
                                     } fail:nil];
}

/**
 *  登录请求
 */
- (void)loginAction
{
    if (![self checkInputValue])
    {
        return;
    }
  
    NSString *pwd = [self.tf_pwd rsaValue];
    NSDictionary *requstDict = @{@"login":self.userNameTxtField.text,
                                 @"lgnPass":pwd,
                                 @"verifyCode":self.codeTxtField.text,
                                 @"version":[StaticTools getCurrentVersion]};

    [[Transfer sharedTransfer] startTransfer:@"089016"
                                      fskCmd:nil
                                    paramDic:requstDict
                                        mess:@"正在登陆" 
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             APPDataCenter.CertificationStatus = result[@"CertificationStatus"];
                                             [UserDefaults setObject:self.userNameTxtField.text forKey:PHONENUM];
                                             [UserDefaults synchronize];
                                             
                                             [self gotoHome];
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                         }
                                         
                                     } fail:nil];
}

/**
 *  获取版本
 */
- (void)getAppVersion
{
    [[Transfer sharedTransfer] startTransfer:@"089018"
                                      fskCmd:nil
                                    paramDic:nil
                                        mess:nil
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             [SVProgressHUD showSuccessWithStatus:result[@"ver"]];
                                         }
                                         
                                     } fail:nil];
}


@end
