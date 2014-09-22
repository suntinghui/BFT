//
//  SetPayPwdViewController.h
//  BFT
//
//  Created by Sappfire on 14-9-16.
//  Copyright (c) 2014年 文彬. All rights reserved.
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：设置支付密码
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "YLTPasswordTextField.h"

@interface SetPayPwdViewController : BaseViewController<UITextFieldDelegate>

{
    UITextField *currentTxtField;

}
@property (weak, nonatomic) IBOutlet UITextField *idCardTxtField;//身份证号

@property (weak, nonatomic) IBOutlet YLTPasswordTextField *tf_pwd;//支付密码

@property (weak, nonatomic) IBOutlet YLTPasswordTextField *tf_confirm_pwd;//确认支付密码

@property (weak, nonatomic) IBOutlet UITextField *vercodeTxtField;//短信验证码

- (IBAction)getVercode:(id)sender;

- (IBAction)confirmAction:(id)sender;





@end
