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

@end
