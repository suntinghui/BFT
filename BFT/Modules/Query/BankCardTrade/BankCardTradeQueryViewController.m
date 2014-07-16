//
//  QueryViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "BankCardTradeQueryViewController.h"

#define Button_Tag_CardType  100
#define Button_Tag_StartTime  101
#define Button_Tag_EndTime    102
#define Button_Tag_Quety      103

@interface BankCardTradeQueryViewController ()

@end

@implementation BankCardTradeQueryViewController

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
    self.navigationItem.title = @"银行卡交易查询";
    
    hasTitleView = YES;
    
    [self.cardTypeBtn setTitle:@"银行卡" forState:UIControlStateNormal];
    [self.startTimeBtn setTitle:[StaticTools getDateStrWithDate:[NSDate date] withCutStr:@"-" hasTime:NO] forState:UIControlStateNormal];
    [self.endTimeBtn setTitle:[StaticTools getDateStrWithDate:[NSDate date] withCutStr:@"-" hasTime:NO] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击
- (IBAction)buttonClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case Button_Tag_CardType:
        {
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"银行卡",@"预付卡", nil];
            [sheet showInView:self.view];
            
        }
            break;
        case Button_Tag_StartTime: //开始时间
        {
            [StaticTools showDateSelectWithIndexDate:self.startTimeBtn.titleLabel.text type:kDatePickerTypeFull clickOk:^(NSString *selectDateStr) {
                
                [self.startTimeBtn setTitle:selectDateStr forState:UIControlStateNormal];
            }];
        }
            break;
        case Button_Tag_EndTime: //结束时间
        {
            [StaticTools showDateSelectWithIndexDate:self.endTimeBtn.titleLabel.text type:kDatePickerTypeFull clickOk:^(NSString *selectDateStr) {
                
                   [self.endTimeBtn setTitle:selectDateStr forState:UIControlStateNormal];
            }];
        }
            break;
        case Button_Tag_Quety:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -UIActionDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1)
    {
        [self.cardTypeBtn setTitle:@"银行卡" forState:UIControlStateNormal];
    }
    else if(buttonIndex==2)
    {
         [self.cardTypeBtn setTitle:@"预付卡" forState:UIControlStateNormal];
    }
}
@end
