//
//  LeftMenuViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "GetMoneyStepOneViewController.h"
#import "ManageViewController.h"
#import "BankCardTradeQueryViewController.h"
#import "SystemsViewController.h"
#import "LevelOneMenuViewController.h"

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
    self.listTableView.separatorColor =[UIColor blackColor];
    [StaticTools setExtraCellLineHidden:self.listTableView];
    
    titles = @[@"我的管理",@"我要查询",@"我要收款",@"我要提款",@"系统相关"];

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
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 30, 30)];
    headView.backgroundColor = [UIColor clearColor];
    if (indexPath.row==self.selectRow)
    {
       headView.image = [UIImage imageNamed:[NSString stringWithFormat:@"left_icon_%d_s",indexPath.row+1]];
    }
    else
    {
        headView.image = [UIImage imageNamed:[NSString stringWithFormat:@"left_icon_%d_n",indexPath.row+1]];
    }
    
    [cell.contentView addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, 200, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = titles[indexPath.row];
    [cell.contentView addSubview:titleLabel];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==self.selectRow)
    {
        cell.backgroundColor = [UIColor blueColor];
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectRow = indexPath.row;
    [self.listTableView reloadData];
    
    LevelOneMenuViewController *levelOneMenuController = [[LevelOneMenuViewController alloc]init];
    levelOneMenuController.pageType = indexPath.row;
    
     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:levelOneMenuController];
     [StaticTools setNavigationBarBackgroundImage:nav.navigationBar withImg:@"nav_bg"];
    self.viewDeckController.centerController =nav;
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        
        
    }];
}

@end
