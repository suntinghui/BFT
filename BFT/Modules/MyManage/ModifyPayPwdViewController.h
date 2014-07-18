//
//  ModifyPayPwdViewController.h
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：修改支付密码
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>
#import "YLTPasswordTextField.h"

@interface ModifyPayPwdViewController : BaseViewController
{
    NSMutableDictionary *resutDict;
}

@property(strong, nonatomic)IBOutlet YLTPasswordTextField *tf_old_pwd;
@property(strong, nonatomic)IBOutlet YLTPasswordTextField *tf_new_pwd;
@property(strong, nonatomic)IBOutlet YLTPasswordTextField *tf_confirm_pwd;
@property(strong, nonatomic)IBOutlet UITextField *tf_sms;

- (IBAction)getVerCode:(id)sender;
- (IBAction)confirmAction:(id)sender;
@end
