//
//  RevokeListTableViewCell.h
//  BFT
//
//  Created by 文彬 on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevokeListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *monyeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImg;

@end
