//
//  ModifyBankCardViewController.h
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：修改银行卡
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface ModifyBankCardViewController : BaseViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int operateType;
    UITextField *currentTxtfield;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *idCardTxtField;
@property (weak, nonatomic) IBOutlet UITextField *oldBankCardTxtField;
@property (weak, nonatomic) IBOutlet UITextField *nowBankCardTxtField;
@property (weak, nonatomic) IBOutlet UITextField *verCodeTxtField;

- (IBAction)buttonClickHandle:(id)sender;

@end
