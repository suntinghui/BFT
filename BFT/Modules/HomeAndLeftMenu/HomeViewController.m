//
//  HomeViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-10.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftMenuViewController.h"
#import "IIViewDeckController.h"
#import "MyBankSavingsViewController.h"
#import "ManageViewController.h"
#import "QueryViewController.h"
#import "RecivePaymentViewController.h"
#import "SystemsViewController.h"

#define Button_Tag_MyManage  100
#define Button_Tag_Query     101
#define Button_Tag_MakeColection  102
#define Button_Tag_MyAccount  103
#define Button_Tag_Setting  104

@interface HomeViewController ()

@end

@implementation HomeViewController

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

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击
- (IBAction)buttonClickHandle:(id)sender
{
    LeftMenuViewController* leftController = [[LeftMenuViewController alloc] init];
    UIViewController *centerController;
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case Button_Tag_MyManage:
        {
            centerController = [[ManageViewController alloc]init];
        }
            break;
        case Button_Tag_Query:
        {
            centerController = [[QueryViewController alloc]init];
        }
            break;
        case Button_Tag_MakeColection:
        {
            centerController = [[RecivePaymentViewController alloc]init];
        }
            break;
        case Button_Tag_MyAccount:
        {
            centerController = [[MyBankSavingsViewController alloc]init];
        }
            break;
        case Button_Tag_Setting:
        {
            centerController = [[SystemsViewController alloc]init];
        }
            break;
            
        default:
            break;
    }
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:centerController];
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:nav leftViewController:leftController rightViewController:nil];
    deckController.leftSize =150;
    [self.navigationController pushViewController:deckController animated:YES];
}

@end
