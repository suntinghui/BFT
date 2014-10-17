//
//  RevokeListViewController.m
//  BFT
//
//  Created by 文彬 on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "RevokeListViewController.h"
#import "RevokeListTableViewCell.h"
#import "RevokeConfirmViewController.h"
#import "TransferSuccessDBHelper.h"

@interface RevokeListViewController ()

@end

@implementation RevokeListViewController

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
    self.navigationItem.title = @"撤销列表";
    hasTitleView = YES;
    
    [StaticTools setExtraCellLineHidden:self.listTableView];
    self.listTableView.separatorColor = [UIColor clearColor];
    self.listTableView.backgroundColor = [UIColor clearColor];
    self.listTableView.backgroundView = nil;
    
    TransferSuccessDBHelper *helper = [[TransferSuccessDBHelper alloc] init];
    
    [helper deleteAllTransfer];
    
    SuccessTransferModel *model = [[SuccessTransferModel alloc] init];
    
    [model setAmount:@"123"];
    [model setTraceNum:@"000001"];
    model.transCode = @"020022";
    [model setDate:@"1017"];
    [model setContent:@{@"da":@"te"}];
    
    BOOL flag = [helper insertASuccessTrans:model];
    if (flag) {
        NSLog(@"交易成功并写入数据库。。。");
    } else {
        NSLog(@"交易成功但写入数据库时操作失败。。。");
    }
    
    self.revokeListArr = [NSArray arrayWithArray:[helper queryNeedRevokeTransfer]];
    [self.listTableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -功能函数



#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.revokeListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    RevokeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"RevokeListTableViewCell" owner:nil options:nil]objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SuccessTransferModel *model = self.revokeListArr[indexPath.section];
    cell.timeLabel.text = model.date;
//    cell.accountLabel.text = model.accou
    cell.monyeLabel.text = model.amount;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuccessTransferModel *model = self.revokeListArr[indexPath.section];
    
    RevokeConfirmViewController *revokeConfirmController = [[RevokeConfirmViewController alloc]init];
    revokeConfirmController.infoMoel = model;
    [self.navigationController pushViewController:revokeConfirmController animated:YES];
    
}



@end
