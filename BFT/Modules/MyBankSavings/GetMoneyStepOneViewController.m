//
//  MyBankSavingsViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "GetMoneyStepOneViewController.h"

@interface GetMoneyStepOneViewController ()

@end

@implementation GetMoneyStepOneViewController

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
    
    [self addTitleView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
