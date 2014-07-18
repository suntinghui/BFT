//
//  GetMoneyStepTwoViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：提现-第二步
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>
#import "YLTPasswordTextField.h"

@interface GetMoneyStepTwoViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *currentTxtField;
}
@property (weak, nonatomic) IBOutlet UIView *messView;
@property (weak, nonatomic) IBOutlet UILabel *tradeNameLabel; //交易名称
@property (weak, nonatomic) IBOutlet UILabel *accountLabel; //银行账号
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel; //交易金额
@property (weak, nonatomic) IBOutlet YLTPasswordTextField *pswTxtField; //交易密码
@property (weak, nonatomic) IBOutlet UITextField *verCodeTxtField; //验证码
@property (weak, nonatomic) NSString *money;

- (IBAction)buttonClickHandle:(id)sender;

@end
