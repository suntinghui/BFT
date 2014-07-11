//
//  LeftMenuViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MyBankSavingsViewController.h"
#import "ManageViewController.h"
#import "QueryViewController.h"
#import "RecivePaymentViewController.h"
#import "SystemsViewController.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

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
    self.listTableView.backgroundColor = [UIColor clearColor];
    self.listTableView.backgroundView = nil;
    [StaticTools setExtraCellLineHidden:self.listTableView];
    
    titles = @[@"我的管理",@"我要查询",@"我要收款",@"我的存款",@"系统相关"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *centerController;
    switch (indexPath.row) {
        case 0:
        {
            centerController = [[ManageViewController alloc]init];
        }
            break;
        case 1:
        {
            centerController = [[QueryViewController alloc]init];
        }
            break;
        case 2:
        {
            centerController = [[RecivePaymentViewController alloc]init];
        }
            break;
        case 3:
        {
            centerController = [[MyBankSavingsViewController alloc]init];
        }
            break;
        case 4:
        {
            centerController = [[SystemsViewController alloc]init];
        }
            break;
    }
    
     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:centerController];
      self.viewDeckController.centerController =nav;
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        
        
    }];
}

@end
