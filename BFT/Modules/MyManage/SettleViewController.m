//
//  SettleViewController.m
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "SettleViewController.h"

@interface SettleViewController ()

@end

@implementation SettleViewController

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
    self.navigationItem.title = @"结算";
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

-(IBAction)confirmAction:(id)sender{
    
    [[Transfer sharedTransfer]startTransfer:@"050000" fskCmd:@"Request_VT#Request_GetExtKsn" paramDic:nil mess:@"正在结算" success:^(id result) {
        
    } fail:nil];
}

@end
