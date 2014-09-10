//
//  AboutViewController.h
//  BFT
//
//  Created by 文彬 on 14-8-20.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：关于系统
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface AboutViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

- (IBAction)buttonClickHandle:(id)sender;

@end
