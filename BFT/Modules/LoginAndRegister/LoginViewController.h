//
//  LoginViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-8.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：登录页面
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>
#import "LeftImageTextField.h"
#import "YLTPasswordTextField.h"
#import "GetBackPwdViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTxtField; //用户名
@property (weak, nonatomic) IBOutlet YLTPasswordTextField *tf_pwd; //密码
@property (weak, nonatomic) IBOutlet UIButton *remenberPswBtn; //记住密码
@property (weak, nonatomic) IBOutlet UIButton *getPwdBtn; //取回密码
@property (weak, nonatomic) IBOutlet UITextField *codeTxtField; //验证码输入框
@property (weak, nonatomic) IBOutlet UIButton *verCodeBtn; //验证码按钮
@property (weak, nonatomic) IBOutlet UIView *loginView;

- (IBAction)buttonClickHandle:(id)sender;

@end
