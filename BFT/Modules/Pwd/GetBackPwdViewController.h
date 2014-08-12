//
//  GetBackPwdViewController.h
//  BFT
//
//  Created by liao jia on 14-7-11.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：取回登录密码--身份证信息验证页面
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface GetBackPwdViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneTxtField;
@property (weak, nonatomic) IBOutlet UITextField *IdCardTxtField;

- (IBAction)buttonClickHandle:(id)sender;

@end
