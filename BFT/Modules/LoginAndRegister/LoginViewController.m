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

#define Button_Tag_Register  100
#define Button_Tag_Login     101
#define Button_Tag_VerCode   102

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
    

    [self.verCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    self.isSelect = [UserDefaults boolForKey:@"isSelect"];
    self.btn_select.selected = self.isSelect;
    
//    [self getAppVersion]; TODO
    
    //直接请求时 超时  原因未知
    [self performSelector:@selector(getPicVerCode) withObject:nil afterDelay:0.5];
    
    self.userNameTxtField.text = @"13520072513"; //TODO
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -功能函数
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
//            [self loginAction];
            [self gotoHome];
        }
        case Button_Tag_VerCode: //获取验证码
        {
            [self getPicVerCode];
        }
            break;
            
        default:
            break;
    }

}

#pragma mark -CodeViewDelegate
- (void)CodeViewClicked
{
    [self getPicVerCode];
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


- (IBAction)selectAction:(id)sender
{
    
    [self.btn_select setSelected:!self.btn_select.selected];
    [UserDefaults setBool:self.btn_select.selected forKey:@"isSelect"];
    [UserDefaults synchronize];
}

- (IBAction)getPwdAction:(id)sender
{
    GetBackPwdViewController *vc = [[GetBackPwdViewController alloc] initWithNibName:@"GetBackPwdViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
