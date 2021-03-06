//
//  LevelOneMenuViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "LevelOneMenuViewController.h"
#import "GetMoneyStepOneViewController.h"
#import "InputMoneyViewController.h"
#import "BankCardTradeQueryViewController.h"
#import "FeedBackViewController.h"
#import "SignInViewController.h"
#import "SettleViewController.h"
#import "AuthenticationUpImageViewController.h"
#import "ModifyBankCardViewController.h"
#import "ModifyPayPwdViewController.h"
#import "ResetPayPwdViewController.h"
#import "InputPswViewController.h"
#import "SwipeCardMessViewController.h"
#import "RevokeListViewController.h"
#import "AboutViewController.h"

#define Alert_Tag_SignOut   100

@interface LevelOneMenuViewController ()

@end

@implementation LevelOneMenuViewController

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
    
    [StaticTools setExtraCellLineHidden:self.listTabelView];
    self.listTabelView.backgroundColor = [UIColor clearColor];
    self.listTabelView.backgroundView = nil;
    
    if (self.pageType==0) //我的管理
   {
       self.navigationItem.title = @"我的管理";
//       titles = @[@"签到",@"结算",@"签退",@"实名认证",@"修改银行卡",@"修改支付密码",@"重置支付密码"];
        titles = @[@"签到",@"结算",@"实名认证",@"修改银行卡"];
    }
    else if(self.pageType==1)//我要查询
    {
        self.navigationItem.title = @"我要查询";
//        titles = @[@"银行卡余额查询",@"账户余额查询",@"账户交易查询",@"银行卡交易查询",@"公告查询"];
        titles = @[@"银行卡余额查询",@"银行卡交易查询",@"公告查询"];
    }
    else if(self.pageType==2) //我要收款
    {
        self.navigationItem.title = @"我要收款";
        titles = @[@"收款",@"收款撤销"];
    }
//    else if(self.pageType==3) //
//    {
//        self.navigationItem.title = @"我要提款";
//        titles = @[@"提现",@"手机充值"];
//    }
    else if(self.pageType==3) //系统相关
    {
        self.navigationItem.title = @"系统相关";
        titles = @[@"意见反馈",@"关于系统",@"检查更新"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back
{
    UINavigationController *rootNav = (UINavigationController*)ApplicationDelegate.window.rootViewController;
    [rootNav popViewControllerAnimated:YES];
}

#pragma mark -UIAletViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == Alert_Tag_SignOut) //是否签退
    {
        if (buttonIndex!=alertView.cancelButtonIndex)
        {
            [[Transfer sharedTransfer]startTransfer:@"082001" fskCmd:nil paramDic:nil mess:@"正在退出" success:^(id result) {
                
                UINavigationController *rootNav = (UINavigationController*)ApplicationDelegate.window.rootViewController;
                [rootNav popToRootViewControllerAnimated:YES];
                if ([result[@"rtCd"] isEqualToString:@"00"])
                {
                    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-1] animated:YES];
                    

                }
                else
                {
                    
                }
                
            } fail:nil];
            
        }
    }
}

#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    headView.backgroundColor = [UIColor clearColor];
    if (self.pageType==0) //我的管理
    {
        headView.image = [UIImage imageNamed:[NSString stringWithFormat:@"manager_right_%d_n",indexPath.section]];
    }
    else if (self.pageType==1)//我要查询
    {
         headView.image = [UIImage imageNamed:[NSString stringWithFormat:@"query_left_%d",indexPath.section]];
    }
    else if (self.pageType==2) //我要收款
    {
        headView.image = [UIImage imageNamed:[NSString stringWithFormat:@"gather_left_%d",indexPath.section]];
    }
//    else if (self.pageType==3) //我要提款
//    {
//        headView.image = [UIImage imageNamed:[NSString stringWithFormat:@"gather_left_%d",indexPath.section]];
//    }
    else if (self.pageType==3) //系统相关
    {
        headView.image = [UIImage imageNamed:[NSString stringWithFormat:@"system_left_%d",indexPath.section]];
    }
    
    [cell.contentView addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 7, 200, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = titles[indexPath.section];
    [cell.contentView addSubview:titleLabel];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.pageType==0) //我的管理
    {
        if (indexPath.section==0) //签到
        {
            SignInViewController *signinController = [[SignInViewController alloc]init];
            [self.navigationController pushViewController:signinController animated:YES];
        }
        else if(indexPath.section==1) //结算
        {
            SettleViewController *settleController = [[SettleViewController alloc]init];
            [self.navigationController pushViewController:settleController animated:YES];
        }
//        else if(indexPath.section==2) //签退
//        {
//            [StaticTools showAlertWithTag:Alert_Tag_SignOut title:nil message:@"您确定要签退吗" AlertType:CAlertTypeCacel SuperView:self];
//        }
        else if(indexPath.section==2) //实名认证
        {
            AuthenticationUpImageViewController *authController = [[AuthenticationUpImageViewController alloc]init];
            [self.navigationController pushViewController:authController animated:YES];
        }
        else if(indexPath.section==3) //修改银行卡
        {
            ModifyBankCardViewController *modifyBankCardController = [[ModifyBankCardViewController alloc]init];
            [self.navigationController pushViewController:modifyBankCardController animated:YES];
        }
//        else if(indexPath.section==5) //修改支付密码
//        {
//            ModifyPayPwdViewController *modifyPayController = [[ModifyPayPwdViewController alloc]init];
//            [self.navigationController pushViewController:modifyPayController animated:YES];
//        }
//        else if(indexPath.section==6) //重置支付密码
//        {
//            ResetPayPwdViewController *resetController = [[ResetPayPwdViewController alloc]init];
//            [self.navigationController pushViewController:resetController animated:YES];
//        }
    }
    else if (self.pageType==1)//我要查询
    {
        if (indexPath.section==0) //银行卡余额查询
        {
            SwipeCardMessViewController *swipeCardMessController  = [[SwipeCardMessViewController alloc]init];
            [self.navigationController pushViewController:swipeCardMessController animated:YES];
        }
//        else if (indexPath.section==1) //账户余额查询
//        {
//            InputPswViewController *inputPswController = [[InputPswViewController alloc]init];
//            [self.navigationController pushViewController:inputPswController animated:YES];
//        }
//        else if (indexPath.section==2) //账户交易查询
//        {
//            InputPswViewController *inputPswController = [[InputPswViewController alloc]init];
//            inputPswController.pageType=1;
//            [self.navigationController pushViewController:inputPswController animated:YES];
//        }
        else if (indexPath.section==1) //银行卡交易查询
        {
            BankCardTradeQueryViewController *bankCardTradeQueryController = [[BankCardTradeQueryViewController alloc]init];
            [self.navigationController pushViewController:bankCardTradeQueryController animated:YES];
        }
        else if(indexPath.section==2) //公告查询
        {
            [StaticTools showMessagePageWithType:kMessageTypeFail mess:@"功能暂未开通" clicked:nil];
        }
        
    }
    if (self.pageType==2) //我要收款
    {
        if (indexPath.section==0) //收款
        {
            InputMoneyViewController *inputMoneyController =[[InputMoneyViewController alloc] init];
            [self.navigationController pushViewController:inputMoneyController animated:YES];
        }
        else if(indexPath.section==1) //收款撤销
        {
            RevokeListViewController *revokeListController = [[RevokeListViewController alloc]init];
            [self.navigationController pushViewController:revokeListController animated:YES];
        }
    }
//    if (self.pageType==3) //我要提款
//    {
//        if (indexPath.section==0) //提现
//        {
//            GetMoneyStepOneViewController *getMoneyStepOneController = [[GetMoneyStepOneViewController alloc]init];
//            [self.navigationController pushViewController:getMoneyStepOneController animated:YES];
//        }
//        else if(indexPath.section==1) //手机充值
//        {
//            [StaticTools showMessagePageWithType:kMessageTypeFail mess:@"功能暂未开通" clicked:nil];
//        }
//    }
    if (self.pageType==3) //系统相关
    {
        if (indexPath.section==0) //意见反馈
        {
            FeedBackViewController *feedBackController = [[FeedBackViewController alloc]init];
            [self.navigationController pushViewController:feedBackController animated:YES];
        }
        else if (indexPath.section==1) //关于系统
        {
            AboutViewController *aboutViewController = [[AboutViewController alloc]init];
            [self.navigationController pushViewController:aboutViewController animated:YES];
            
        }
        else if(indexPath.section==2) //检查更新
        {
            [SVProgressHUD showSuccessWithStatus:@"已经是最新版本"];
        }
    }
}

@end
