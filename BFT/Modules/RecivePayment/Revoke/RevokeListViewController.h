//
//  RevokeListViewController.h
//  BFT
//
//  Created by 文彬 on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：收款撤销列表页面
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/

#import <UIKit/UIKit.h>

@interface RevokeListViewController : BaseViewController<UITableViewDataSource,
    UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) NSArray *revokeListArr;

@end
