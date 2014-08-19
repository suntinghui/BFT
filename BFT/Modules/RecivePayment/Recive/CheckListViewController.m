//
//  CheckListViewController.m
//  BFT
//
//  Created by Sappfire on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "CheckListViewController.h"
#import "SignViewController.h"

#define Button_Tag_Sign            100 //持卡人签名
@interface CheckListViewController ()

@end

@implementation CheckListViewController

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
    self.navigationItem.title = @"签购单";
    hasTitleView = YES;
    //addKeyBoardNotification = YES;

    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark   - 按钮点击事件
- (IBAction)buttonClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case Button_Tag_Sign:              //请持卡人签名
        {
            SignViewController  *signViewController = [[SignViewController alloc]init];
            [self.navigationController pushViewController:signViewController animated:YES];
        
        }
            break;
            
        default:
            break;
    }
    
}
@end
