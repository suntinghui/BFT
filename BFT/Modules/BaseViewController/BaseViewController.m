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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000  //ios7适配
    if ( IOS7_OR_LATER )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
#endif
    
    if (!self.navigationItem.hidesBackButton)
    {
        [self initNavgationcontrollerLeftButton];
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], UITextAttributeTextColor,
                                                                     [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,
                                                                     nil]];
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
    
    
}

/**
 *  点击导航栏左侧返回按钮  如有必要  可在子类重写
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  增加顶部用户名和时间视图
 */
- (void)addTitleView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    imgView.image = [UIImage imageNamed:@"sawtooth_bg"];
    imgView.backgroundColor = [UIColor clearColor];
    [titleView addSubview:imgView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 230, 30)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"用户名：wenbin";
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor darkGrayColor];
    [titleView addSubview:nameLabel];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(230, 0, 90, 30)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.text = [StaticTools getDateStrWithDate:[NSDate date] withCutStr:@"-" hasTime:NO];
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.textColor = [UIColor darkGrayColor];
    [titleView addSubview:dateLabel];
    
    [self.view addSubview:titleView];
    
}


#pragma mark -keyboardDelegate
/**
 *  增加键盘显示、隐藏的通知
 */
- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWasShown:(NSNotification *)notification
{
    NSValue  *valu_=[notification.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGRect rectForkeyBoard=[valu_ CGRectValue];
    keyBoardLastHeight=rectForkeyBoard.size.height;
    
    [self keyBoardShowWithHeight:keyBoardLastHeight];
}

-(void)keyboardWasHidden:(NSNotification *)notification
{
    keyBoardLastHeight=0;
    [self keyBoardHidden];
}

/**
 *  键盘显示时调用 需要处理键盘弹出的可在子类重写该函数
 *
 *  @param height 键盘高度
 */
- (void)keyBoardShowWithHeight:(float)height
{
    
}

//键盘隐藏时调用 需要处理键盘隐藏的可在子类重写该函数
- (void)keyBoardHidden
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
