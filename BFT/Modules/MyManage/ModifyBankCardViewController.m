//
//  ModifyBankCardViewController.m
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "ModifyBankCardViewController.h"

#define Button_Tag_VerCode  100
#define Button_Tag_Commit   101

@interface ModifyBankCardViewController ()

@end

@implementation ModifyBankCardViewController

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
    
    self.navigationItem.title = @"修改银行卡";
    hasTitleView = true;
    addKeyBoardNotification = YES;
    
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
 *  检查页面输入合法性
 *
 *  @return
 */
- (BOOL)checkInputValue
{
    NSString *err;
    if ([StaticTools isEmptyString:self.nameTxtField.text])
    {
        err = @"请输入您的真实姓名";
    }
    else  if ([StaticTools isEmptyString:self.idCardTxtField.text])
    {
        err = @"请输入您的身份证号码";
    }
    else  if ([StaticTools isEmptyString:self.oldBankCardTxtField.text])
    {
        err = @"请输入原银行卡号";
    }
    else  if ([StaticTools isEmptyString:self.nowBankCardTxtField.text])
    {
        err = @"请输入新银行卡号";
    }
    
    if (err!=nil)
    {
        [SVProgressHUD showErrorWithStatus:err];
        return NO;
    }
    
    return YES;
}
#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTxtfield = textField;
}

#pragma mark -按钮点击时间
- (IBAction)buttonClickHandle:(id)sender
{
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case Button_Tag_VerCode: //获取验证码
        {
            [self getVerCode];
        }
            break;
        case Button_Tag_Commit: //确认修改
        {
            if ([self checkInputValue])
            {
                [self changeBankCard];
            }
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -http请求
/**
 *  获取短信验证码
 */
- (void)getVerCode
{
    
    NSDictionary *requstDict = @{@"mobNo":[UserDefaults objectForKey:PHONENUM],
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
 *  修改银行卡
 */
- (void)changeBankCard
{
    NSDictionary *requstDict = @{@"name":self.nameTxtField.text,
                                 @"pldNo":self.idCardTxtField.text,
                                 @"oldBkCardNo":self.oldBankCardTxtField.text,
                                 @"bkCardNo":self.nowBankCardTxtField.text,
                                 @"verifyCode":self.verCodeTxtField.text,
                                 @"bankNo":@"111111"}; //银行卡开户卡 随便写的
    
    [[Transfer sharedTransfer] startTransfer:@"089029"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requstDict
                                        mess:@"正在加载"
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                                             [self.navigationController popViewControllerAnimated:YES];
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                         }
                                         
                                         
                                     } fail:nil];
}
#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    CGRect rectForRow=currentTxtfield.frame;
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

@end
