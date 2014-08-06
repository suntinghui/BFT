//
//  ResetPayPwdViewController.m
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "ResetPayPwdViewController.h"

@interface ResetPayPwdViewController ()

@end

@implementation ResetPayPwdViewController

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
    
    self.navigationItem.title = @"重置支付密码";
    hasTitleView = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = false;
    
    [super viewWillAppear:animated];
    
}

-(BOOL) checkValue{
    if(self.tf_new_pwd.pwdTF.text.length  == 0){
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空"];
        return false;
    }else if(self.tf_idCard.text.length  == 0){
        [SVProgressHUD showErrorWithStatus:@"身份证号不能为空"];
        return false;
    }else if(self.tf_bankCardNum.text.length  == 0){
        [SVProgressHUD showErrorWithStatus:@"银行卡号不能为空"];
        return false;
    }else if(self.tf_sms.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"短信验证码不能为空"];
        return false;
    }
    return true;
}
#pragma mark -http请求
/**
 *  获取短信验证码
 */
- (IBAction)getVerCode:(id)sender
{
    
    NSDictionary *requstDict = @{@"mobNo":[UserDefaults stringForKey:PHONENUM],
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
 * 重置支付密码
 */

- (IBAction)confirmAction:(id)sender{
    if(![self checkValue]){
        return;
    }
    
    NSDictionary *requstDict =  @{@"payPass":@"3dc8afdc432bf3be2370fde5707ccbf248a1853d5a85e3782088f7d4a8767e12dfe687096a6364876dd62f7148191608f118bc65a85002cf74f4a5afb65be312b612ce8358da9dcdfbcf84adab8a4c50613cd225617314e882a41a52037ca648ca13bed5829e99b86cd59a26d56536f0a1e3e2cb5e99703b63872e726c1321e0",
                                  @"pIdNo":self.tf_idCard.text,
                                  @"verifyCode":self.tf_sms.text,
                                  @"bkCardNo":self.tf_bankCardNum.text};
    
    [[Transfer sharedTransfer] startTransfer:@"089023"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requstDict
                                        mess:@"正在请求数据..."
                                     success:^(id result) {
                                         [SVProgressHUD showErrorWithStatus:@"密码重置成功"];
                                         [self.navigationController popViewControllerAnimated:YES];
                                     } fail:nil];
}

@end
