//
//  CardTradeTableViewCell.h
//  BFT
//
//  Created by 文彬 on 14-7-17.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardTradeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *tradeTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeStateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@end
