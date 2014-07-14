//
//  AuthenticationUpImageViewController.m
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "AuthenticationUpImageViewController.h"

@interface AuthenticationUpImageViewController ()

@end

@implementation AuthenticationUpImageViewController

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
    
    self.navigationItem.title = @"实名认证";
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

-(IBAction)imageOneAction:(id)sender{
    
}

-(IBAction)imageTwoAction:(id)sender{
    
}

-(IBAction)imageThreeAction:(id)sender{
    
}

-(IBAction)confirmAction:(id)sender{
    
}

-(IBAction)bankAction:(id)sender{
    
}

-(IBAction)provinceAction:(id)sender{
    
}

-(IBAction)cityAction:(id)sender{
    
}

-(IBAction)msgAction:(id)sender{
    
}
@end
