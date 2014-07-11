//
//  BaseViewController.m
//  POS4iPhone_PeoplePay
//
//  Created by 文彬 on 14-5-11.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "BaseViewController.h"
//#import "BaiduMobStat.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated{
    
//    NSString *cName = [NSString stringWithFormat:@"%@", self.class, nil];
//    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
}

-(void) viewDidDisappear:(BOOL)animated{
    
//    NSString *cName = [NSString stringWithFormat:@"%@", self.class, nil];
//    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000  //ios7适配
    if ( IOS7_OR_LATER )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
#endif
    
    if (!self.navigationItem.hidesBackButton)
    {
        [self initNavgationcontrollerLeftButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleBlackTranslucent;
}


- (BOOL)prefersStatusBarHidden
{
    
    return NO;
    
}

#pragma mark--定制导航栏左侧返回按钮
/**
 *  定制返回按钮  在基类的viewdidload里调用 不需要返回按钮或需定制和基类不一样的按钮时 可在子类里自行处理
 */
- (void)initNavgationcontrollerLeftButton
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_btn_n"] forState:UIControlStateNormal];
     [backBtn setBackgroundImage:[UIImage imageNamed:@"back_btn_s"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 7, 50, 30);
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftView addSubview:backBtn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], UITextAttributeTextColor,
                                                                     [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,
                                                                     nil]];
}

/**
 *  点击导航栏左侧返回按钮  如有必要  可在子类重写
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
