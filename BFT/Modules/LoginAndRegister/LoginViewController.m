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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.codeView.delete = self;
    [self.codeView setCodeString:@"点击获取验证码"];
    

    
    [self getAppVersion];
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
    
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark -按钮点击事件
- (IBAction)buttonClickHandle:(id)sender
{
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case Button_Tag_Register:
        {
            RegisterViewController *registerController = [[RegisterViewController alloc]init];
            [self.navigationController pushViewController:registerController animated:YES];
        }
            break;
        case Button_Tag_Login:
        {
            //    [self loginAction];
            [self gotoHome];
        }
            
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
                                             [self.codeView setCodeString:result[@"verifyCode"]];
                                         }
                                         
                                     } fail:nil];
}

/**
 *  登录请求
 */
- (void)loginAction
{
    NSString *pubKey = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"publicKey" ofType:@"xml"]  encoding:NSUTF8StringEncoding error:nil];

    NSDictionary *requstDict = @{@"login":@"1352007251",
                                 @"lgnPass":@"3dc8afdc432bf3be2370fde5707ccbf248a1853d5a85e3782088f7d4a8767e12dfe687096a6364876dd62f7148191608f118bc65a85002cf74f4a5afb65be312b612ce8358da9dcdfbcf84adab8a4c50613cd225617314e882a41a52037ca648ca13bed5829e99b86cd59a26d56536f0a1e3e2cb5e99703b63872e726c1321e0",
                                 @"verifyCode":@"1234",
                                 @"version":@"1.0"};

    [[Transfer sharedTransfer] startTransfer:@"089016"
                                      fskCmd:nil
                                    paramDic:requstDict
                                        mess:@"正在登陆" 
                                     success:^(id result) {
                                         
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
