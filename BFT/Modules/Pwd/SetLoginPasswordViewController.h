//
//  SetLoginPasswordViewController.h
//  BFT
//
//  Created by 文彬 on 14-8-12.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：设置登录密码
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface SetLoginPasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *pswTxtField;
@property (weak, nonatomic) IBOutlet UITextField *pswConfirmTxtField;
@property (weak, nonatomic) IBOutlet UITextField *verCodeTxtField;

@property (strong, nonatomic) NSString *phoneNum;  //前一个页面传过来的安全手机号

- (IBAction)buttonClickHandle:(id)sender;

@end
