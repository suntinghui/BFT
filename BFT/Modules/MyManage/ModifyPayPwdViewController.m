//
//  ModifyPayPwdViewController.m
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "ModifyPayPwdViewController.h"

@interface ModifyPayPwdViewController ()

@end

@implementation ModifyPayPwdViewController

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
    
    self.navigationItem.title = @"修改支付密码";
    hasTitleView = true;
    addKeyBoardNotification = YES;
    
    self.tf_old_pwd.pwdTF.placeholder = @"请输入原密码";
    self.tf_old_pwd.delegate = self;
    self.tf_new_pwd.pwdTF.placeholder = @"请输入新密码";
    self.tf_new_pwd.delegate = self;
    self.tf_confirm_pwd.pwdTF.placeholder = @"请确认新密码";
    self.tf_confirm_pwd.delegate = self;
    
    resutDict = [[NSMutableDictionary alloc]init];
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

#pragma mark -功能函数

/**
 *  检查页面输入
 *
 *  @return
 */
-(BOOL) checkValue{
    if(self.tf_old_pwd.pwdTF.text.length  == 0){
        [SVProgressHUD showErrorWithStatus:@"原密码不能为空"];
        return false;
    }else if(self.tf_new_pwd.pwdTF.text.length  == 0){
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空"];
        return false;
    }else if(self.tf_old_pwd.pwdTF.text.length  == 0){
        [SVProgressHUD showErrorWithStatus:@"确认密码不能为空"];
        return false;
    }else if(self.vercodeTxtField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"短信验证码不能为空"];
        return false;
    }else if(![self.tf_new_pwd.pwdTF.text isEqualToString:self.tf_confirm_pwd.pwdTF.text]){
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
        return false;
    }
    return true;
}

#pragma mark -UItextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTxtField = textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    CGRect rectForRow;
    if (currentTxtField==self.vercodeTxtField)
    {
        rectForRow = currentTxtField.frame;
    }
    else
    {
        rectForRow = currentTxtField.superview.frame;
    }
    
    float touchSetY = [[UIScreen mainScreen] bounds].size.height-height-64;
    if (rectForRow.origin.y+rectForRow.size.height>touchSetY)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(0, -(rectForRow.origin.y+rectForRow.size.height-touchSetY)+(IOS7_OR_LATER?64:0), self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
- (void)keyBoardHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, IOS7_OR_LATER?64:0, self.view.frame.size.width, self.view.frame.size.height);
    }];
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
 * 修改支付密码
 */

- (IBAction)confirmAction:(id)sender{
    if(![self checkValue]){
        return;
    }
    NSDictionary *requstDict =  @{@"oldPass":@"3dc8afdc432bf3be2370fde5707ccbf248a1853d5a85e3782088f7d4a8767e12dfe687096a6364876dd62f7148191608f118bc65a85002cf74f4a5afb65be312b612ce8358da9dcdfbcf84adab8a4c50613cd225617314e882a41a52037ca648ca13bed5829e99b86cd59a26d56536f0a1e3e2cb5e99703b63872e726c1321e0",
                                  @"newPass":@"3dc8afdc432bf3be2370fde5707ccbf248a1853d5a85e3782088f7d4a8767e12dfe687096a6364876dd62f7148191608f118bc65a85002cf74f4a5afb65be312b612ce8358da9dcdfbcf84adab8a4c50613cd225617314e882a41a52037ca648ca13bed5829e99b86cd59a26d56536f0a1e3e2cb5e99703b63872e726c1321e0",
                                  @"verifyCode":self.vercodeTxtField.text,
                                  @"type":@"2"};
    
    [[Transfer sharedTransfer] startTransfer:@"089024"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requstDict
                                        mess:@"正在请求数据..."
                                     success:^(id result) {
                                         [SVProgressHUD showErrorWithStatus:@"密码修改成功"];
                                         [self.navigationController popViewControllerAnimated:YES];
                                     } fail:nil];
}
@end
