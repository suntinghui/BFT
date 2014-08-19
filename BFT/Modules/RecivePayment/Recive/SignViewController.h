//
//  SignViewController.h
//  BFT
//
//  Created by Sappfire on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "BaseViewController.h"
#import "PaintMaskView.h"
#import "CheckListViewController.h"
@interface SignViewController : BaseViewController<UITextFieldDelegate>
{
    PaintMaskView *paintCanVasView;

}
@property (weak, nonatomic) IBOutlet UILabel *tradeNum;  //交易金额
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;  //手机号

- (IBAction)buttonClickHandle:(id)sender;

@end
