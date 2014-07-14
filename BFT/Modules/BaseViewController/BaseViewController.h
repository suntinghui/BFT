//
//  BaseViewController.h
//  POS4iPhone_PeoplePay
//
//  Created by 文彬 on 14-5-11.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：页面基类  ios7适配、定制导航栏返回按钮 原则上所有页面都得继承自此类
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    float keyBoardLastHeight;
}
//返回按钮点击
- (void)back;

//增加顶部用户名和时间视图
- (void)addTitleView;

//增加键盘显示、隐藏的通知
- (void)addKeyboardNotification;

//键盘显示时调用
- (void)keyBoardShowWithHeight:(float)height;

//键盘隐藏时调用
- (void)keyBoardHidden;
@end
