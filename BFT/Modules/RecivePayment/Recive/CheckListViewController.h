//
//  CheckListViewController.h
//  BFT
//
//  Created by Sappfire on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "BaseViewController.h"

@interface CheckListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)buttonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminalNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardBankLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardWorkDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeType;
@property (weak, nonatomic) IBOutlet UILabel *tradeSerialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorizeNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *advisoryNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *batchNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;











@end
