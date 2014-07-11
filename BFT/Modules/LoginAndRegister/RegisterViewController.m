//
//  RegisterViewController.m
//  BFT
//
//  Created by 文彬 on 14-7-11.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "RegisterViewController.h"
#import "YLTPasswordTextField.h"

#define Button_Tag_Select 100
#define Button_Tag_Reader 101
#define Button_Tag_Commit 102
#define Button_Tag_GetCode 103

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
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
#pragma mark -功能函数
- (void)resetTableView
{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.listTableView.contentOffset=CGPointMake(0,0);
        self.listTableView.contentSize = CGSizeMake(self.listTableView.frame.size.width,560);
    }];
}
#pragma mark -按钮点击
- (IBAction)buttonClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case Button_Tag_Select:
        {
        }
            break;
        case Button_Tag_GetCode: //获取验证码
        {
            
        }
            break;
        case Button_Tag_Reader: //阅读协议
        {
            
        }
            break;
        case Button_Tag_Commit: //下一步
        {
            [self resetTableView];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTxtField = textField;
    self.listTableView.contentSize = CGSizeMake(self.listTableView.frame.size.width,iPhone5?700: 620);
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    currentTxtField=nil;
     self.listTableView.contentSize = CGSizeMake(self.listTableView.frame.size.width,560);
}

#pragma mark -keyboardDelegate
-(void)keyboardWasShown:(NSNotification *)notification
{
    
    NSValue  *valu_=[notification.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGRect rectForkeyBoard=[valu_ CGRectValue];
    keyBoardLastHeight=rectForkeyBoard.size.height;
    
//    NSIndexPath * indexPath=[NSIndexPath indexPathForRow:currentEditIndex inSection:0];
//    CGRect rectForRow=[self.listTableView rectForRowAtIndexPath:indexPath];
    if (currentTxtField==self.messCodeTxtField)
    {
        
    }
    CGRect  rect = [self.view convertRect:currentTxtField.frame fromView:self.listTableView];
    
    float touchSetY=(iPhone5?548:460)-rectForkeyBoard.size.height-rect.size.height-self.listTableView.frame.origin.y-49;
    if (rect.origin.y>touchSetY) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        self.listTableView.contentOffset=CGPointMake(0,rect.origin.y-touchSetY);
        [UIView commitAnimations];
    }
}

-(void)keyboardWasHidden:(NSNotification *)notification
{
    keyBoardLastHeight=0;
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
    
    return 45;
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
        inputTxtField.delegate = self;
        inputTxtField.placeholder = placeHolds[indexPath.row];
        
        if (indexPath.row==2||indexPath.row==3)
        {
            inputTxtField.keyboardAppearance = UIKeyboardTypeNumberPad;
        }
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
