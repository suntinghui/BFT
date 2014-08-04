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

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTxtField;
@property (weak, nonatomic) IBOutlet YLTPasswordTextField *tf_pwd;
@property (strong, nonatomic) IBOutlet UIButton *btn_select;
@property (strong, nonatomic) IBOutlet UIButton *btn_getpwd;
@property (weak, nonatomic) IBOutlet UITextField *codeTxtField;
@property (weak, nonatomic) IBOutlet UIButton *verCodeBtn;
@property (nonatomic) BOOL isSelect;


- (IBAction)buttonClickHandle:(id)sender;
- (IBAction)selectAction:(id)sender;
- (IBAction)getPwdAction:(id)sender;

@end
