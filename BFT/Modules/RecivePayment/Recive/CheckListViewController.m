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
#define Button_Tag_SignFinish      102 //签名确定
#define Label_Tag_Message          101 //签购单提示信息

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

- (void)viewDidAppear:(BOOL)animated
{
    self.scrollView.frame = CGRectMake(0, 0, 320, 568);
    [self.scrollView setContentSize:CGSizeMake(320, 940)];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"签购单";
    hasTitleView = NO;
    //addKeyBoardNotification = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signFinish:) name:@"signFinish" object:nil];
    
    
}


- (void)signFinish:(NSNotification *)signImage
{
    UILabel *label = (UILabel *)[self.view viewWithTag:Label_Tag_Message];
    label.text = @"持卡人签名";
    UIButton *button = (UIButton *)[self.view viewWithTag:Button_Tag_Sign];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.tag = Button_Tag_SignFinish;
    button.frame = CGRectMake(40, 730, 230, 46);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = signImage.object;
    imageView.frame = CGRectMake(135, 800-150, 60, 60);
    imageView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:imageView];
    
    
    
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
        case Button_Tag_SignFinish:
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        
        }
        default:
            break;
    }
    
}
@end
