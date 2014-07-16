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
    addKeyBoardNotification = YES;
    
    [StaticTools setExtraCellLineHidden:self.listTableView];
    self.listTableView.tableFooterView = self.footView;
    self.listTableView.backgroundColor = [UIColor clearColor];
    self.listTableView.backgroundView = nil;
    self.listTableView.separatorColor = [UIColor clearColor];
    images = @[@"icon_user",@"icon_user",@"icon_idcard",@"icon_phone",@"icon_pwd-1",@"icon_pwd-1"];
    placeHolds = @[@"真实姓名",@"登录名",@"身份证号码",@"手机号码",@"登录密码",@"密码确认"];
    resutDict = [[NSMutableDictionary alloc]init];
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
            self.selectBtn.selected = !self.selectBtn.selected;
        }
            break;
        case Button_Tag_GetCode: //获取验证码
        {
            [self resetTableView];
            
            if ([StaticTools isEmptyString:resutDict[placeHolds[3]]])
            {
                [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
                return;
            }
            
            [self getVerCode];
        }
            break;
        case Button_Tag_Reader: //阅读协议
        {
            
        }
            break;
        case Button_Tag_Commit: //下一步
        {
            [self resetTableView];
            
            for (NSString *key in placeHolds)
            {
                if ([StaticTools isEmptyString:resutDict[key]])
                {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@",key]];
                    return;
                }
            }
            if ([StaticTools isEmptyString:self.messCodeTxtField.text])
            {
                [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
                return;
            }
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
    //    if (textField.tag==104||textField.tag==105||textField==self.messCodeTxtField)
    //    {
    //        [UIView animateWithDuration:0.3 animations:^{
    //            self.listTableView.contentOffset = CGPointMake(0, 150);
    //        }];
    //    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    currentTxtField=nil;
    
    if (textField!=self.messCodeTxtField)
    {
        [resutDict setObject:textField.text==nil?@"":textField.text forKey:placeHolds[textField.tag-100]];
    }
    
}
#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    CGRect rectForRow;
    if (currentTxtField==self.messCodeTxtField)
    {
        
        NSIndexPath * indexPath=[NSIndexPath indexPathForRow:0 inSection:5];
        rectForRow=[self.listTableView rectForRowAtIndexPath:indexPath];
        rectForRow = CGRectMake(rectForRow.origin.x, rectForRow.origin.y+50, rectForRow.size.width, rectForRow.size.height);
    }
    else
    {
        NSIndexPath * indexPath=[NSIndexPath indexPathForRow:0 inSection:currentTxtField.tag-100];
        rectForRow=[self.listTableView rectForRowAtIndexPath:indexPath];
    }
    
    float touchSetY=(iPhone5?548:460)-height-rectForRow.size.height-self.listTableView.frame.origin.y-49;
    if (rectForRow.origin.y>touchSetY) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        self.listTableView.contentOffset=CGPointMake(0,rectForRow.origin.y-touchSetY);
        [UIView commitAnimations];
    }
}

- (void)keyBoardHidden
{
    [self resetTableView];
    
}
#pragma mark -http请求
/**
 *  获取短信验证码
 */
- (void)getVerCode
{
    
    NSDictionary *requstDict = @{@"mobNo":@"1352007251",
                                 @"sendTime":[StaticTools getDateStrWithDate:[NSDate date] withCutStr:@"" hasTime:YES],
                                 @"type":@"0"};
    
    [[Transfer sharedTransfer] startTransfer:@"089006"
                                      fskCmd:@"Request_GetExtKsn"
                                    paramDic:requstDict
                                        mess:@"正在获取验证码"
                                     success:^(id result) {
                                         
                                     } fail:nil];
}

#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return images.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectZero];
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
    
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.listTableView.frame.size.width, 45)];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.image = [UIImage imageNamed:@"input_bg"];
    [cell.contentView addSubview:bgView];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    headView.backgroundColor = [UIColor clearColor];
    headView.image = [UIImage imageNamed:images[indexPath.section]];
    [cell.contentView addSubview:headView];
    
    if (indexPath.section==4||indexPath.section==5)
    {
        YLTPasswordTextField *inputTxtField = [[YLTPasswordTextField alloc] initWithFrame:CGRectMake(35, 5, 270, 30)];
        inputTxtField.pwdTF.tag = indexPath.section+100;
        inputTxtField.delegate = self;
        [cell.contentView addSubview:inputTxtField];
        inputTxtField.pwdTF.placeholder = placeHolds[indexPath.section];
        inputTxtField.pwdTF.text = resutDict[placeHolds[indexPath.section]];
    }
    else
    {
        UITextField *inputTxtField = [[UITextField alloc] initWithFrame:CGRectMake(35, 10, 270, 30)];
        [cell.contentView addSubview:inputTxtField];
        inputTxtField.font = [UIFont systemFontOfSize:15];
        inputTxtField.delegate = self;
        inputTxtField.placeholder = placeHolds[indexPath.section];
        inputTxtField.text = resutDict[placeHolds[indexPath.section]];
        inputTxtField.tag = indexPath.section+100;
        if (indexPath.section==2||indexPath.section==3)
        {
            inputTxtField.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
