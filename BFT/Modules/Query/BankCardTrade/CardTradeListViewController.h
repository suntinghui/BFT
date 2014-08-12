//
//  CardTradeListViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-17.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：银行卡交易流水
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface CardTradeListViewController : BaseViewController<UITableViewDataSource,
    UITableViewDelegate>
{
    NSMutableArray *trades;
    int currentPage;
}
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@property (assign, nonatomic) int cardType; //卡类型

@end
