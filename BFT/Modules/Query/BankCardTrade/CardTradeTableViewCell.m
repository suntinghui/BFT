//
//  CardTradeTableViewCell.m
//  BFT
//
//  Created by 文彬 on 14-7-17.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "CardTradeTableViewCell.h"

@implementation CardTradeTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataWithDictonary:(NSDictionary*)dict
{
    self.tradeTypeLabel.text = dict[@"transType"];
    self.cardTypeLabel.text = dict[@"type"];
    self.cardNumLabel.text = dict[@"pan"];
//    self.cardPlaceLabel.text = dict[@""];
//    self.tradeMoneyLabel.text = dict[@""];
    self.tradeDateLabel.text = dict[@"date"];
    self.tradeStateLabel.text = dict[@"state"];
}
@end
