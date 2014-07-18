//
//  MyBankSavingsViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "GetMoneyStepOneViewController.h"
#import "GetMoneyStepTwoViewController.h"

@interface GetMoneyStepOneViewController ()

@end

@implementation GetMoneyStepOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"提现";
    
    addKeyBoardNotification = YES;
    hasTitleView = YES;
    
    self.messView.layer.borderColor = RGBACOLOR(230, 115, 27, 0.7).CGColor;
    self.messView.layer.borderWidth = 1;
    self.messView.layer.cornerRadius = 8;
    
    self.moneyTxtField.layer.borderColor = RGBACOLOR(230, 115, 27, 0.7).CGColor;
    self.moneyTxtField.layer.borderWidth = 1;
    self.moneyTxtField.layer.cornerRadius = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击事件
- (IBAction)buttonClickHandle:(id)sender
{
    [self.view endEditing:YES];
    if ([StaticTools isEmptyString:self.moneyTxtField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
        return;
    }
    
    GetMoneyStepTwoViewController *getMoneyStepTwoController = [[GetMoneyStepTwoViewController alloc]init];
    getMoneyStepTwoController.money = self.moneyTxtField.text;
    [self.navigationController pushViewController:getMoneyStepTwoController animated:YES];
}

#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    CGRect rectForRow=self.moneyTxtField.frame;
    float touchSetY = [[UIScreen mainScreen] bounds].size.height-height-64;
    if (rectForRow.origin.y+rectForRow.size.height>touchSetY)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(0, -(rectForRow.origin.y+rectForRow.size.height-touchSetY)+(IOS7_OR_LATER?64:0), self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
- (void)keyBoardHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, IOS7_OR_LATER?64:0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

@end
