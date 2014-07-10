//
//  StaticTools+UIOperation.m
//  LivingService
//
//  Created by wenbin on 13-10-24.
//  Copyright (c) 2013年 wenbin. All rights reserved.
//

#import "StaticTools+UIOperation.h"

@implementation StaticTools (UIOperation)

/**
 *  显示信息提示页面
 *
 *  @param type  页面类型
 *  @param mess  提示文字
 *  @param block 点击确定后的回调操作
 */
+(void)showMessagePageWithType:(kMessageType)type
                          mess:(NSString*)mess
                       clicked:(ButtonClickBlock)block
{
    
    MessageViewController *messController = [[MessageViewController alloc]init];
    messController.messType = type;
    messController.messStr = mess;
    messController.clickBlock = block;
    UINavigationController *rootNav = (UINavigationController*)ApplicationDelegate.window.rootViewController;
    [rootNav pushViewController:messController animated:YES];
}

/**
 *	@brief	显示日期选择页面
 *
 *	@param 	dateStr 	显示页面是默认的被选择的日期 格式为“2013-12-12” 或“2013-12” 或 @“2013”
 *	@param 	pickerType  picker类型
 *  @param  block  点击确定按钮时的回调 返回选择的日期字符串 格式为“2013-12-12” 或“2013-12” 或 @“2013”
 *	@return
 */
+ (void)showDateSelectWithIndexDate:(NSString*)dateStr
                                type:(kDatePickerType)pickerType
                            clickOk:(DateSelectAction)block
{
    DateSelectViewController *dateSelectController = [[DateSelectViewController alloc]initWithNibName:@"DateSelectViewController" bundle:[NSBundle mainBundle]];
    dateSelectController.pageType = pickerType;
    dateSelectController.indexDate = dateStr;
    dateSelectController.clickOkAction = block;
    
    UINavigationController *rootNav = (UINavigationController*)ApplicationDelegate.window.rootViewController;
    //若不设置此属性 推上去后背景会变黑色  必须是rootviewcontroller
    rootNav.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [rootNav presentModalViewController:dateSelectController animated:YES];
}
@end
