//
//  inputPswViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-16.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "InputPswViewController.h"
#import "AccountTradeViewController.h"

@interface InputPswViewController ()

@end

@implementation InputPswViewController

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
    self.navigationItem.title = @"密码输入";
    
    hasTitleView = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClickHandle:(id)sender
{
    if (self.pageType==0) //账户余额查询
    {
        [self accoutnMoneyQuery];
    }
    else if(self.pageType==1) //账户交易查询
    {
        AccountTradeViewController *accountTradeController = [[AccountTradeViewController alloc]init];
        accountTradeController.pswRsaValue = self.pswTxtField.rsaValue;
        [self.navigationController pushViewController:accountTradeController animated:YES];
    }
}

#pragma mark-http请求
/**
 *  账户余额查询
 */
- (void)accoutnMoneyQuery
{
    NSDictionary *requstDict = @{@"login":[UserDefaults objectForKey:PHONENUM],
                                 @"payPass":self.pswTxtField.rsaValue};
    
    [[Transfer sharedTransfer] startTransfer:@"089027"
                                      fskCmd:nil
                                    paramDic:requstDict
                                        mess:@"正在加载"
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             [StaticTools showMessagePageWithType:kMessageTypeSeccuss mess:[NSString stringWithFormat:@"账户余额：%@",result[@"accBlc"]] clicked:nil];
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                         }
                                         
                                     } fail:nil];
}
@end
