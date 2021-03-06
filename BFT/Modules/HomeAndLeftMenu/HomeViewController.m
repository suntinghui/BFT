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
#import "GetMoneyStepOneViewController.h"
#import "ManageViewController.h"
#import "BankCardTradeQueryViewController.h"
#import "FeedBackViewController.h"
#import "LevelOneMenuViewController.h"
#import "YRSideViewController.h"

#define Button_Tag_MyManage      100
#define Button_Tag_Query         101
#define Button_Tag_MakeColection 102
#define Button_Tag_MyAccount     103
#define Button_Tag_Setting       104

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
    self.navigationItem.hidesBackButton = YES;
    [super viewDidLoad];
    self.navigationItem.title = @"主界面";
    isGoBack = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UINavigationController *rootNav = (UINavigationController*)ApplicationDelegate.window.rootViewController;
    [rootNav setNavigationBarHidden:NO animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!isGoBack)
    {
        UINavigationController *rootNav = (UINavigationController*)ApplicationDelegate.window.rootViewController;
        [rootNav setNavigationBarHidden:YES animated:animated];
    }
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击
- (IBAction)buttonClickHandle:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    LeftMenuViewController* leftController = [[LeftMenuViewController alloc] init];
    
    leftController.selectRow =button.tag-100;
    
    LevelOneMenuViewController *levelOneMenuController = [[LevelOneMenuViewController alloc]init];
    levelOneMenuController.pageType = button.tag-100;
    isGoBack = NO;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:levelOneMenuController];
    [StaticTools setNavigationBarBackgroundImage:nav.navigationBar withImg:@"nav_bg"];
    
 
    YRSideViewController *sideViewController=[[YRSideViewController alloc]initWithNibName:nil bundle:nil];
    sideViewController.rootViewController=nav;
    sideViewController.leftViewController=leftController;
    APPDataCenter.yrSideViewController = sideViewController;

    sideViewController.leftViewShowWidth=200;
    sideViewController.needSwipeShowMenu=true;//默认开启的可滑动展示
//    [sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
//        //使用简单的平移动画 自定义滑动动画
//        rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
//    }];

//    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:nav leftViewController:leftController rightViewController:nil];
//    deckController.leftSize =150;
    
    //IIViewDeckController在iphone5上显示有问题 所以改用YRSideViewController

    
    [self.navigationController pushViewController:sideViewController animated:YES];
}

@end
