//
//  LoginViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-8.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "LoginViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击事件
- (IBAction)buttonClickHandle:(id)sender
{
    [self loginAction];
}

#pragma mark -http请求
/**
 *  登录请求
 */
- (void)loginAction
{
    NSDictionary *requstDict = @{@"login":@"test",
                                 @"lgnPass":@"123",
                                 @"verifyCode":@"1234",
                                 @"version":@"1"};
    
    [[Transfer sharedTransfer] startTransfer:@"089016"
                                      fskCmd:nil
                                    paramDic:requstDict
                                     success:^(id result) {
                                         
                                     } fail:nil];
}

@end
