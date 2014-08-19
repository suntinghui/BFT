//
//  RevokeConfirmViewController.h
//  BFT
//
//  Created by 文彬 on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：收款撤销确认页面
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>
@class SuccessTransferModel;

@interface RevokeConfirmViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *tradeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *batchNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *consultNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeCardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *readerView;

@property (strong, nonatomic)SuccessTransferModel *infoMoel;

- (IBAction)buttonClickHandle:(id)sender;

@end
