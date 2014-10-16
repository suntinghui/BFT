//
//  LevelOneMenuViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：公用的一级菜单页面  都是图片加title  所以用一个页面复用了
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface LevelOneMenuViewController : BaseViewController<UITableViewDataSource,
    UITableViewDelegate,
    UIAlertViewDelegate>
{
    NSArray *titles;
}
@property (weak, nonatomic) IBOutlet UITableView *listTabelView;
@property (assign, nonatomic) int pageType; /*0：我的管理 1：我要查询 2：我要收款 3：系统相关*/

@end
