//
//  SystemsViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

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
    self.navigationItem.title = @"意见反馈";
    addKeyBoardNotification  = YES;
    
    self.inputTxtView.layer.borderColor = BordColor.CGColor;
    self.inputTxtView.layer.borderWidth = 1;
    self.inputTxtView.layer.cornerRadius = 8;
    
    self.emailTxtField.layer.borderColor = BordColor.CGColor;
    self.emailTxtField.layer.borderWidth = 1;
    self.emailTxtField.layer.cornerRadius = 3;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击
- (IBAction)buttonClickHandle:(id)sender
{
    if ([StaticTools isEmptyString:self.inputTxtView.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入意见内容"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"正在发送..." maskType:SVProgressHUDMaskTypeClear];
    
    SKPSMTPMessage *sendMsg = [[SKPSMTPMessage alloc] init];
    sendMsg.fromEmail = @"jia_people@163.com";
    sendMsg.toEmail =@"wenbin168.hi@163.com";
    sendMsg.relayHost = @"smtp.163.com";
    sendMsg.requiresAuth = YES;
    sendMsg.login = @"jia_people@163.com";
    sendMsg.pass = @"jia_people_test";
    sendMsg.subject = @"BaiFuTong IOS feedback"; // 中文会乱码  意见反馈
    //testMsg.bccEmail = @"tinghuisun@163.com"; // 抄送
    sendMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!

    sendMsg.validateSSLChain = NO;
    sendMsg.delegate = self;
    
    NSString *content =   [NSString stringWithFormat:@"%@ %@", self.inputTxtView.text, [UserDefaults objectForKey:PHONENUM]];
 
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               [NSString stringWithCString:[content UTF8String] encoding:NSUTF8StringEncoding],kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    
    sendMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    [sendMsg send];

}

#pragma mark SKPSMTPMessage Delegate Methods
- (void)messageState:(SKPSMTPState)messageState;
{
    //    NSLog(@"HighestState:%d", HighestState);
    //    if (messageState > HighestState)
    //        HighestState = messageState;
    //
    //    ProgressBar.progress = (float)HighestState/(float)kSKPSMTPWaitingSendSuccess;
}
- (void)messageSent:(SKPSMTPMessage *)SMTPmessage
{
    [SVProgressHUD dismiss];
    
    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)messageFailed:(SKPSMTPMessage *)SMTPmessage error:(NSError *)error
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:@"提交失败，请稍后再试"];
    NSLog(@"email faild: %@",[error localizedDescription]);
    
}

#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    if ([self.emailTxtField isFirstResponder])
    {
        CGRect rectForRow=self.emailTxtField.frame;
        float touchSetY = [[UIScreen mainScreen] bounds].size.height-height-64;
        if (rectForRow.origin.y+rectForRow.size.height>touchSetY)
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                self.view.frame = CGRectMake(0, -(rectForRow.origin.y+rectForRow.size.height-touchSetY)+(IOS7_OR_LATER?64:0), self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
    }
  
}
- (void)keyBoardHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, IOS7_OR_LATER?64:0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

@end
