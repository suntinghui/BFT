//
//  AccountTradeViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-18.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "AccountTradeViewController.h"
#import "CardTradeTableViewCell.h"

@interface AccountTradeViewController ()

@end

@implementation AccountTradeViewController

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
    self.navigationItem.title = @"账户交易查询";
    hasTitleView = YES;
    [StaticTools setExtraCellLineHidden:self.listTableView];
    self.listTableView.backgroundColor = [UIColor clearColor];
    [StaticTools setTableViewAddMoreFootView:self.listTableView withAction:@selector(accoutTradeQuery)];
    
    
    trades = [[NSMutableArray alloc]init];
    
    [self accoutTradeQuery];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
     //   NSDictionary *dict =trades[indexPath.section];
     //   [cell setCellDataWithDictonary:dict];
    
    return cell;
}


#pragma mark-http请求
/**
 *  账户交易查询
 */
- (void)accoutTradeQuery
{
    NSDictionary *requstDict = @{@"login":[UserDefaults objectForKey:PHONENUM],
                                 @"payPass":self.pswRsaValue,
                                 @"currPage":[NSString stringWithFormat:@"%d",currentPage+1]};
    
    [[Transfer sharedTransfer] startTransfer:@"089028"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requstDict
                                        mess:@"正在加载"
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             NSArray *list = result[@"pageList"];
                                             if (list.count==0&&currentPage==0)
                                             {
                                                 [SVProgressHUD showErrorWithStatus:@"暂无交易数据"];
                                             }
                                             else
                                             {
                                                currentPage++;
                                             }
                                             
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                         }
                                         
                                     } fail:nil];
}

@end
