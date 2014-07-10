//
//  StaticTools+UIOperation.h
//  LivingService
//
//  Created by wenbin on 13-10-24.
//  Copyright (c) 2013年 wenbin. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (
 // 版权所有。
 //
 // 文件功能描述：具体业务相关的工具函数
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import "StaticTools.h"
#import "MessageViewController.h"
#import "DateSelectViewController.h"

@interface StaticTools (UIOperation)

//显示信息提示页面
+(void)showMessagePageWithType:(kMessageType)type
                          mess:(NSString*)mess
                       clicked:(ButtonClickBlock)block;


//显示日期选择页面  可包含年、月、日  也可只包含年、月
+ (void)showDateSelectWithIndexDate:(NSString*)dateStr
                               type:(kDatePickerType)pickerType
                            clickOk:(DateSelectAction)block;
@end
