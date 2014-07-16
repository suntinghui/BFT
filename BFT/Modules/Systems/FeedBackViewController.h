//
//  SystemsViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：意见反馈
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface FeedBackViewController : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTxtView;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;

- (IBAction)buttonClickHandle:(id)sender;

@end
