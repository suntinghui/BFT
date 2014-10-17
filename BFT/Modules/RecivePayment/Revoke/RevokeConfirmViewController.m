//
//  RevokeConfirmViewController.m
//  BFT
//
//  Created by 文彬 on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "RevokeConfirmViewController.h"

@interface RevokeConfirmViewController ()

@end

@implementation RevokeConfirmViewController

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
    self.navigationItem.title = @"确认撤销";
    hasTitleView = YES;
    
    self.infoView.layer.borderColor = BordColor.CGColor;
    self.infoView.layer.borderWidth = 1;
    self.infoView.layer.cornerRadius = 5;
    
    self.readerView.layer.borderColor = BordColor.CGColor;
    self.readerView.layer.borderWidth = 1;
    self.readerView.layer.cornerRadius = 5;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.scrView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击
- (IBAction)buttonClickHandle:(id)sender
{
}
@end
