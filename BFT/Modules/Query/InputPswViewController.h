//
//  inputPswViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-16.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：交易密码输入页面
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>
#import "YLTPasswordTextField.h"

@interface InputPswViewController : BaseViewController

@property (weak, nonatomic) IBOutlet YLTPasswordTextField *pswTxtField;
@property (assign, nonatomic) int pageType;  //0:账户余额查询的密码输入

- (IBAction)buttonClickHandle:(id)sender;

@end
