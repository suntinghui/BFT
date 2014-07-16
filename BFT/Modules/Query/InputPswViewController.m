//
//  inputPswViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-16.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "InputPswViewController.h"

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
    
}
@end
