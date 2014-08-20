//
//  tradeSucViewController.m
//  BFT
//
//  Created by Sappfire on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "tradeSucViewController.h"

@interface tradeSucViewController ()

@end

@implementation tradeSucViewController

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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"结算成功";
    hasTitleView = YES;
    
    [self createUI];
    
    
    
}

- (void)createUI
{
    UIImageView  *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    bgImageView.frame = CGRectMake(0, 104, 320, 464);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
