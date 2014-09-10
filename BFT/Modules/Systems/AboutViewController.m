//
//  AboutViewController.m
//  BFT
//
//  Created by 文彬 on 14-8-20.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    self.navigationItem.title = @"关系系统";
    
    self.infoLabel.text = [NSString stringWithFormat:@"佰付通 For Iphone V%@",[StaticTools getCurrentVersion]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击
- (IBAction)buttonClickHandle:(id)sender
{
       [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.payfortune.com"]];
}

@end
