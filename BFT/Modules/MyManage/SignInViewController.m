//
//  SignInViewController.m
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "SignInViewController.h"
#import "TransferSuccessDBHelper.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

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

    self.navigationItem.title = @"签到";
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

-(IBAction)confirmAction:(id)sender
{    
    [[Transfer sharedTransfer]startTransfer:@"080000" fskCmd:@"Request_VT#Request_GetExtKsn" paramDic:nil mess:@"正在签到" success:^(id result) {
        
        NSLog(@"签到成功");
        
        //保存field41  终端代码
        if ([result objectForKey:@"field41"]) {
            [AppDataCenter sharedAppDataCenter].__TERID = [result objectForKey:@"field41"];
        }
        //保存field42  商户代码
        if ([result objectForKey:@"field42"]) {
            [AppDataCenter sharedAppDataCenter].__VENDOR = [result objectForKey:@"field42"];
        }
        // 保存商户名称 field43 有就存
        if ([result objectForKey:@"field43"]) {
            [UserDefaults setObject:[result objectForKey:@"field43"] forKey:MERCHERNAME];
            [UserDefaults synchronize];
        }
        
        // 更新批次号
        NSString *batchNum = [[result objectForKey:@"field60"] substringWithRange:NSMakeRange(2, 6)];
        [[AppDataCenter sharedAppDataCenter] setBatchNum:batchNum];
        
        // 清空上一个批次的交易成功的信息，即用于消费撤销和查询签购单的数据库表
        TransferSuccessDBHelper *helper = [[TransferSuccessDBHelper alloc] init];
        if ([helper deleteAllTransfer]) {
            NSLog(@"更换批次后 成功 清空需清除的成功交易！");
        } else {
            NSLog(@"更换批次后清空需清除的成功交易 失败 ！");
        }
        @try {
            // 根据62域字符串切割得到工作密钥
            NSString *newKey = [[result objectForKey:@"field62"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *pinKey = nil; //(0, 40)
            NSString *macKey = nil;//newKey.substring(40, 56) + newKey.substring(72);
            NSString *stackKey = nil;//pinKey
            
            newKey = [newKey substringFromIndex:2];
            pinKey = [newKey substringWithRange:NSMakeRange(0, 40)];
            macKey = [newKey substringWithRange:NSMakeRange(40, 40)];;
            
            stackKey = [newKey substringWithRange:NSMakeRange(80, 40)];;
            
            [AppDataCenter sharedAppDataCenter].pinKey = pinKey;
            [AppDataCenter sharedAppDataCenter].macKey = macKey;
            
          
            NSLog(@"pin:%@ mackey:%@ stackkey:%@",pinKey,macKey,stackKey);
             // 更新工作密钥
            [[Transfer sharedTransfer]startTransfer:nil fskCmd:[NSString stringWithFormat:@"Request_ReNewKey|string:%@,string:%@,string:%@", pinKey, macKey, stackKey]   paramDic:nil mess:@"正在更新工作密钥" success:^(id result) {
                
                [StaticTools showMessagePageWithType:kMessageTypeSeccuss mess:@"签到成功\n\n[设备已成功更新工作密钥]" clicked:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
            } fail:nil];
            
        }
        @catch (NSException *exception) {
            NSLog(@"--%@", [exception callStackSymbols]);

            [StaticTools showMessagePageWithType:kMessageTypeFail mess:@"签到失败" clicked:nil];
        }
        
    } fail:nil];
    
}
@end
