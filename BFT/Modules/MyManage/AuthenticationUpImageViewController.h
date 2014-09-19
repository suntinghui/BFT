//
//  AuthenticationUpImageViewController.h
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：实名认证
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AuthenticationUpImageViewController : BaseViewController< UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextFieldDelegate>
{
    int operateType;
    UITextField *currentTxtField;
}

@property(strong, nonatomic)IBOutlet UITextField *tf_cardNo;
@property(strong, nonatomic)IBOutlet UITextField *tf_merchantName;
@property(strong, nonatomic)IBOutlet UITextField *tf_msg;
@property(strong, nonatomic)IBOutlet UIScrollView *scrollView;
- (IBAction)buttonClickHandle:(id)sender;

-(IBAction)confirmAction:(id)sender;
-(IBAction)bankAction:(id)sender;
-(IBAction)provinceAction:(id)sender;
-(IBAction)cityAction:(id)sender;

-(IBAction)msgAction:(id)sender;


@end
