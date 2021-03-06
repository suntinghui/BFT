//
//  LeftMenuViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：左侧菜单列表页面
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController<UITableViewDataSource,
    UITableViewDelegate>
{
    NSArray *titles;
}
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (assign, nonatomic) int selectRow; //当前选中的行号

@end
