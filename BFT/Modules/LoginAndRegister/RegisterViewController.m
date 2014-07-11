//
//  RegisterViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-11.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "RegisterViewController.h"
#import "YLTPasswordTextField.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    self.navigationItem.title = @"注册";
    [StaticTools setExtraCellLineHidden:self.listTableView];
    self.listTableView.tableFooterView = self.footView;
    images = @[@"",@"",@"",@"",@"",@""];
    placeHolds = @[@"真实姓名",@"登录名",@"身份证号码",@"手机号码",@"登录密码",@"再次输入登录密码"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return images.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    headView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:headView];
    
    
    if (indexPath.row==4||indexPath.row==5)
    {
        YLTPasswordTextField *inputTxtField = [[YLTPasswordTextField alloc] initWithFrame:CGRectMake(50, 5, 260, 30)];
        [cell.contentView addSubview:inputTxtField];
        inputTxtField.pwdTF.placeholder = placeHolds[indexPath.row];
    }
    else
    {
        UITextField *inputTxtField = [[UITextField alloc] initWithFrame:CGRectMake(50, 5, 260, 30)];
        [cell.contentView addSubview:inputTxtField];
        inputTxtField.placeholder = placeHolds[indexPath.row];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
