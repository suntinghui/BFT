//
//  QueryViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "BankCardTradeQueryViewController.h"
#import "CardTradeListViewController.h"

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
    cardType = 1;
    NSDate *date = [StaticTools getDateFromDate:[NSDate date] withYear:0 month:0 day:-7];
    [self.startTimeBtn setTitle:[StaticTools getDateStrWithDate:date withCutStr:@"-" hasTime:NO] forState:UIControlStateNormal];
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

/**
 *  检查选择的时间的合法性
 *
 *  @return
 */
- (BOOL)checkDateValue
{
    NSDate *startDate  = [StaticTools getDateFromDateStr:self.startTimeBtn.titleLabel.text];
    NSDate *endDate = [StaticTools getDateFromDateStr:self.endTimeBtn.titleLabel.text];
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval time=[endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    
    NSString *err;
    if ([startDate earlierDate:currentDate]==currentDate)
    {
        err = @"开始日期不能晚于今天的日期";
    }
    else if ([endDate earlierDate:currentDate]==currentDate)
    {
        err = @"结束日期不能晚于今天的日期";
    }
    else if ([startDate earlierDate:endDate]==endDate)
    {
        err = @"开始日期不能晚于结束日期";
    }
    else if(days>7)
    {
        err = @"开始日期和结束日期之间的间隔不能超过7天";
    }
    
    if (err!=nil) {
        [SVProgressHUD showErrorWithStatus:err];
        return NO;
    }
    return YES;
    
    
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
            if (![self checkDateValue])
            {
                return;
            }
            CardTradeListViewController *cardTradeListController = [[CardTradeListViewController alloc]init];
            NSString *start = self.startTimeBtn.titleLabel.text;
            NSString *end = self.endTimeBtn.titleLabel.text;
            cardTradeListController.startTime = [start stringByReplacingOccurrencesOfString:@"-" withString:@""];
            cardTradeListController.endTime = [end stringByReplacingOccurrencesOfString:@"-" withString:@""];
            cardTradeListController.cardType = cardType;
            [self.navigationController pushViewController:cardTradeListController animated:YES];
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
        cardType = 1;
    }
    else if(buttonIndex==2)
    {
         [self.cardTypeBtn setTitle:@"预付卡" forState:UIControlStateNormal];
        cardType = 2;
    }
}
@end
