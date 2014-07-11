//
//  GetBackPwdViewController.m
//  BFT
//
//  Created by liao jia on 14-7-11.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "GetBackPwdViewController.h"

@interface GetBackPwdViewController ()

@end

@implementation GetBackPwdViewController

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

    self.navigationItem.title = @"取回密码";
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
