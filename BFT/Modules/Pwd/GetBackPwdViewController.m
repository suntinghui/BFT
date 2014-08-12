//
//  GetBackPwdViewController.m
//  BFT
//
//  Created by liao jia on 14-7-11.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "GetBackPwdViewController.h"
#import "SetLoginPasswordViewController.h"

@interface GetBackPwdViewController ()

@end

@implementation GetBackPwdViewController

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

    self.navigationItem.title = @"取回密码";
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -功能函数
- (BOOL)checkInputValue
{
    if ([StaticTools isEmptyString:self.phoneTxtField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return NO;
    }
    else if([StaticTools isEmptyString:self.IdCardTxtField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号码"];
        return NO;
    }
    return YES;
}



#pragma mark -按钮点击
- (IBAction)buttonClickHandle:(id)sender
{
    if ([self checkInputValue])
    {
        [self infoCheck];
    }
}

#pragma mark- http请求
/**
 *  信息验证
 */
- (void)infoCheck
{
    NSDictionary *requstDict = @{@"pIdNo":self.IdCardTxtField.text,
                                 @"sctMobNo":self.phoneTxtField.text};
    
    [[Transfer sharedTransfer] startTransfer:@"089031"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requstDict
                                        mess:@"正在验证信息"
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             SetLoginPasswordViewController *setLoginPswController = [[SetLoginPasswordViewController alloc]init];
                                             setLoginPswController.phoneNum = self.phoneTxtField.text;
                                             [self.navigationController pushViewController:setLoginPswController animated:YES];
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                             
                                             //TODO
                                             SetLoginPasswordViewController *setLoginPswController = [[SetLoginPasswordViewController alloc]init];
                                             setLoginPswController.phoneNum = self.phoneTxtField.text;
                                             [self.navigationController pushViewController:setLoginPswController animated:YES];
                                         }
                                         
                                     } fail:nil];
}

@end
