//
//  GetMoneyStepTwoViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "GetMoneyStepTwoViewController.h"

#define Button_Tag_VerCode  100
#define Button_Tag_Commit   101

@interface GetMoneyStepTwoViewController ()

@end

@implementation GetMoneyStepTwoViewController

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
    self.navigationItem.title = @"提现";
    
    addKeyBoardNotification = YES;
    hasTitleView = YES;
    
    self.pswTxtField.delegate = self;
    
    self.messView.layer.borderColor = RGBACOLOR(230, 115, 27, 0.7).CGColor;
    self.messView.layer.borderWidth = 1;
    self.messView.layer.cornerRadius = 8;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击事件
- (IBAction)buttonClickHandle:(id)sender
{
    UIButton *button = (UIButton*)sender;
    switch (button.tag)
    {
        case Button_Tag_VerCode:
        {
         
            [self getVerCode];
        }
            break;
        case Button_Tag_Commit:
        {
            if ([StaticTools isEmptyString:self.pswTxtField.pwdTF.text])
            {
                [SVProgressHUD showErrorWithStatus:@"请输入交易密码"];
                return;
            }
            else if ([StaticTools isEmptyString:self.verCodeTxtField.text])
            {
                [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
                return;
            }
            
            [self getMoney];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -UITextfieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTxtField = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    currentTxtField=nil;
}

#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    CGRect rectForRow=currentTxtField.frame;
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
- (void)getVerCode
{
    
    NSDictionary *requstDict = @{@"mobNo":@"15101532374", //[UserDefaults objectForKey:PHONENUM]
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
 *  提现
 */
- (void)getMoney
{
    NSDictionary *requstDict = @{@"payPass":self.pswTxtField.rsaValue,
                                 @"verifyCode":self.verCodeTxtField.text,
                                 @"money":self.money};
    
    [[Transfer sharedTransfer] startTransfer:@"089025"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requstDict
                                        mess:@"正在加载"
                                     success:^(id result) {
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             [SVProgressHUD showSuccessWithStatus:@"提现成功"];
                                             [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                         }
                                        
                                     } fail:nil];
}
@end
