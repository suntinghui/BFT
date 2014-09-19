//
//  ResetPayPwdViewController.h
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：重置支付密码
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#import "YLTPasswordTextField.h"
@interface ResetPayPwdViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *currentTxtfield;
}

@property(strong, nonatomic)IBOutlet YLTPasswordTextField *tf_new_pwd;
@property(strong, nonatomic)IBOutlet UITextField *idCardTxtField;
@property(strong, nonatomic)IBOutlet UITextField *bankCardNumTxtField;
@property(strong, nonatomic)IBOutlet UITextField *vercodeTxtField;


- (IBAction)getVerCode:(id)sender;
- (IBAction)confirmAction:(id)sender;

@end
