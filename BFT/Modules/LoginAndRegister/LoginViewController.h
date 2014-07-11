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
#import "PooCodeView.h"
#import "LeftImageTextField.h"
#import "YLTPasswordTextField.h"
#import "GetBackPwdViewController.h"

@interface LoginViewController : BaseViewController<CodeViewDelegate>

@property (weak, nonatomic) IBOutlet PooCodeView *codeView;
@property (strong, nonatomic) LeftImageTextField *tf_username;
@property (weak, nonatomic) IBOutlet YLTPasswordTextField *tf_pwd;
@property (strong, nonatomic) IBOutlet UIButton *btn_select;
@property (strong, nonatomic) IBOutlet UIButton *btn_getpwd;
@property (nonatomic) BOOL isSelect;


- (IBAction)buttonClickHandle:(id)sender;
- (IBAction)selectAction:(id)sender;
- (IBAction)getPwdAction:(id)sender;

@end
