//
//  GetMoneyStepTwoViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

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

- (IBAction)buttonClickHandle:(id)sender;

@end
