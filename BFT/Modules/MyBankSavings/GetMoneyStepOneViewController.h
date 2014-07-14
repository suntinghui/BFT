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

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *canGetMoneyCount;
@property (weak, nonatomic) IBOutlet UILabel *cannotGetMoneyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityOfBankLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNumLabel;
@end
