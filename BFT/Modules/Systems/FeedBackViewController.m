//
//  SystemsViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

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
    self.navigationItem.title = @"意见反馈";
    addKeyBoardNotification  = YES;
    
    self.inputTxtView.layer.borderColor = RGBACOLOR(230, 115, 27, 1).CGColor;
    self.inputTxtView.layer.borderWidth = 1;
    self.inputTxtView.layer.cornerRadius = 8;
    
    self.emailTxtField.layer.borderColor = RGBACOLOR(230, 115, 27, 1).CGColor;
    self.emailTxtField.layer.borderWidth = 1;
    self.emailTxtField.layer.cornerRadius = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击
- (IBAction)buttonClickHandle:(id)sender
{
    if ([StaticTools isEmptyString:self.inputTxtView.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入意见内容"];
        return;
    }
}

#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    if ([self.emailTxtField isFirstResponder])
    {
        CGRect rectForRow=self.emailTxtField.frame;
        float touchSetY = [[UIScreen mainScreen] bounds].size.height-height-64;
        if (rectForRow.origin.y+rectForRow.size.height>touchSetY)
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                self.view.frame = CGRectMake(0, -(rectForRow.origin.y+rectForRow.size.height-touchSetY)+(IOS7_OR_LATER?64:0), self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
    }
  
}
- (void)keyBoardHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, IOS7_OR_LATER?64:0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

@end
