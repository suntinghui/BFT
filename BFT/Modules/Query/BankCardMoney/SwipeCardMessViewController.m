//
//  SwipeCardMessViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-16.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "SwipeCardMessViewController.h"

@interface SwipeCardMessViewController ()

@end

@implementation SwipeCardMessViewController

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
    self.navigationItem.title = @"银行卡余额查询";
    hasTitleView = YES;
    
    self.messView.layer.borderColor = RGBACOLOR(230, 115, 27, 0.7).CGColor;
    self.messView.layer.borderWidth = 1;
    self.messView.layer.cornerRadius = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClickHandle:(id)sender
{
    
}

@end
