//
//  SwipeCardMessViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-16.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：刷卡提示页面
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface SwipeCardMessViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *messView;

- (IBAction)buttonClickHandle:(id)sender;

@end
