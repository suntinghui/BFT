//
//  MyBankSavingsViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：提现-第一步
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface GetMoneyStepOneViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *messView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; //姓名
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel; //手机号
@property (weak, nonatomic) IBOutlet UILabel *canGetMoneyCount; //可提现余额
@property (weak, nonatomic) IBOutlet UILabel *cannotGetMoneyCountLabel; //不可提现余额
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel; //收款银行
@property (weak, nonatomic) IBOutlet UILabel *cityOfBankLabel; //开户行所在地
@property (weak, nonatomic) IBOutlet UILabel *bankAccountLabel; //银行账户
@property (weak, nonatomic) IBOutlet UILabel *bankNumLabel; //联行号
@property (weak, nonatomic) IBOutlet UITextField *moneyTxtField; //提款金额

- (IBAction)buttonClickHandle:(id)sender;

@end
