//
//  CardTradeListViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-17.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "CardTradeListViewController.h"
#import "CardTradeTableViewCell.h"

@interface CardTradeListViewController ()

@end

@implementation CardTradeListViewController

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
    self.navigationItem.title = @"交易列表";
    [StaticTools setExtraCellLineHidden:self.listTableView];
    self.listTableView.separatorColor = [UIColor clearColor];
    
    [StaticTools setTableViewAddMoreFootView:self.listTableView withAction:@selector(getTradeList)];
    
    trades = [[NSMutableArray alloc]init];
    
    [self getTradeList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -HTTP请求
/**
 *  获取卡交易列表
 */
- (void)getTradeList
{
    NSDictionary *requstDict = @{@"login":[UserDefaults objectForKey:PHONENUM],
                                 @"pageNum":kOnePageSize,
                                 @"startDt":self.startTime,
                                 @"currPage":[NSString stringWithFormat:@"%d",currentPage+1],
                                 @"endDt":self.endTime,
                                 @"type":[NSString stringWithFormat:@"%d",self.cardType]};
    
 
    [[Transfer sharedTransfer] startTransfer:@"089026"
                                      fskCmd:nil
                                    paramDic:requstDict
                                        mess:@"正在加载"
                                     success:^(id result) {
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             currentPage++;
                                             NSArray *list = result[@"pageList"];
                                             [trades addObjectsFromArray:list];
                                             
                                             if (trades.count<[result[@"totalNum"] intValue])
                                             {
                                                 self.listTableView.tableFooterView.hidden = NO;
                                             }
                                             else
                                             {
                                                 self.listTableView.tableFooterView.hidden = YES;
                                             }
                                             
                                             [self.listTableView reloadData];
                                             
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                             
                                         }
                                         
                                     } fail:nil];
}

#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
    return trades.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 190;
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
    CardTradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"CardTradeTableViewCell" owner:nil options:nil]objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    NSDictionary *dict =trades[indexPath.section];
//    [cell setCellDataWithDictonary:dict];
 
    return cell;
}

@end
