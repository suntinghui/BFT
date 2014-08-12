//
//  SetLoginPasswordViewController.m
//  BFT
//
//  Created by 文彬 on 14-8-12.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "SetLoginPasswordViewController.h"

#define Button_Tag_Vercode  100
#define Button_Tag_Commit   101

@interface SetLoginPasswordViewController ()

@end

@implementation SetLoginPasswordViewController

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
    
    self.navigationItem.title = @"设置密码";
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
    if ([StaticTools isEmptyString:self.pswTxtField.text])
    {
        err = @"请输入新密码";
    }
    else if([StaticTools isEmptyString:self.pswConfirmTxtField.text])
    {
       err = @"请确认新密码";
    }
    else if(![self.pswConfirmTxtField.text isEqualToString:self.pswTxtField.text])
    {
        err = @"两次输入的密码不一致";
    }
    else if([StaticTools isEmptyString:self.verCodeTxtField.text])
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

#pragma mark -按钮点击
- (IBAction)buttonClickHandle:(id)sender
{
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case Button_Tag_Vercode: //获取验证码
        {
            [self getVerCode];
        }
            break;
        case Button_Tag_Commit: //设置密码
        {
            if ([self checkInputValue])
            {
                [self setLoginPassword];
            }
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark-http请求
/**
 *  获取短信验证码
 */
- (void)getVerCode
{
    
    NSDictionary *requstDict = @{@"mobNo":self.phoneNum,
                                 @"sendTime":[StaticTools getDateStrWithDate:[NSDate date] withCutStr:@"-" hasTime:YES],
                                 @"type":@"0",
                                 @"money":@""};
    
    [[Transfer sharedTransfer] startTransfer:@"089006"
                                      fskCmd:nil
                                    paramDic:requstDict
                                        mess:@"正在获取验证码"
                                     success:^(id result) {
                                         
                                         [SVProgressHUD showSuccessWithStatus:@"短信已发送，请注意查收。"];
                                     } fail:nil];
}


/**
 *  设置登录密码
 */
- (void)setLoginPassword
{
    NSDictionary *requstDict = @{@"lgnPass":self.pswTxtField.text,
                                 @"verifyCode":self.verCodeTxtField.text,
                                 @"version":[StaticTools getCurrentVersion]};
    
    [[Transfer sharedTransfer] startTransfer:@"089032"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requstDict
                                        mess:@"正在加载"
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             [SVProgressHUD showSuccessWithStatus:@"密码设置成功"];
                                             [self.navigationController popToRootViewControllerAnimated:YES];
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                         }
                                         
                                     } fail:nil];
}
@end
