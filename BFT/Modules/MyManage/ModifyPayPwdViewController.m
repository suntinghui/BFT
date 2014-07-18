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

/**
 *  修改支付密码
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

@end
