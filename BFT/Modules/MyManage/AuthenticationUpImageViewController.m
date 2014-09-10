//
//  AuthenticationUpImageViewController.m
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "AuthenticationUpImageViewController.h"
#import "Base64.h"

#define Button_Tag_ImageOne    100        //正面照图片按钮
#define Button_Tag_ImageTwo    101        //反面照图片按钮
#define Button_Tag_ImageThree  102        //银行卡图片按钮


@interface AuthenticationUpImageViewController ()

@end

@implementation AuthenticationUpImageViewController

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
    
    self.navigationItem.title = @"实名认证";
    [self.scrollView setContentSize:CGSizeMake(320, 780)];
    hasTitleView = true;
    addKeyBoardNotification = YES;
    
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyborad)];
    [self.scrollView addGestureRecognizer:tapGuesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = false;
    
    [super viewWillAppear:animated];
    
}
#pragma mark -功能函数
- (void)hideKeyborad
{
    [self.view endEditing:YES];
}

#pragma mark -keyboard
- (void)keyBoardShowWithHeight:(float)height
{
    CGRect rectForRow=currentTxtField.frame;
    float touchSetY = [[UIScreen mainScreen] bounds].size.height-height-100;
    if (rectForRow.origin.y+rectForRow.size.height>touchSetY)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, (rectForRow.origin.y+rectForRow.size.height-touchSetY)+(IOS7_OR_LATER?64:0));
        }];
    }
}
- (void)keyBoardHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        
         self.scrollView.contentOffset = CGPointMake(0, 10);
        self.scrollView.contentSize = CGSizeMake(320, 780);

    }];
}

#pragma mark -按钮点击事件
- (IBAction)buttonClickHandle:(id)sender
{
    
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case Button_Tag_ImageOne:
        case Button_Tag_ImageTwo:
        case Button_Tag_ImageThree:
        {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            operateType = button.tag;
            [self presentViewController:imagePickerController animated:YES completion:nil];
            
        }
            
            break;
       
            
        default:
            break;
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    @autoreleasepool
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        image = [StaticTools imageWithImage:image scaledToSize:CGSizeMake(620, 960)]; //TODO
        UIButton *button = (UIButton*)[self.view viewWithTag:operateType];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:^{}];
        
        
        //        [self uploadImageWithType:operateType image:image];
    }
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark-UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTxtField = textField;
    self.scrollView.contentSize = CGSizeMake(320, 1000);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

#pragma mark -http请求
/**
 *  获取短信验证码
 */
- (void)getVerCode
{
    
    NSDictionary *requstDict = @{@"mobNo":@"18734825880", //TODO
                                 @"sendTime":[StaticTools getDateStrWithDate:[NSDate date] withCutStr:@"-" hasTime:YES],
                                 @"type":@"0",
                                 @"money":@""};
    
    [[Transfer sharedTransfer] startTransfer:@"089006"
                                      fskCmd:nil
                                    paramDic:requstDict
                                        mess:@"正在获取验证码"
                                     success:^(id result) {
                                         
                                         [SVProgressHUD showSuccessWithStatus:@"短信已发送，请注意查收。"];
                                     } fail:nil];
}

/**
 *  实名认证
 */
- (void)realNameAuth
{
    NSDictionary *requstDict = @{@"verifyCode":self.tf_msg.text,
                                 @"bankNo":@"1234",
                                 @"bkCardNo":self.tf_cardNo.text,
                                 @"pIdImg0":@"attach0",
                                 @"pIdImg1":@"attach1",
                                 @"bkCardImg":@"attach2"};
    
    NSMutableArray *attach = [[NSMutableArray alloc]init];
    for (int i=100; i<103; i++)
    {
       UIButton *button = (UIButton*)[self.view viewWithTag:i];
       [attach addObject:UIImageJPEGRepresentation([button backgroundImageForState:UIControlStateNormal], 1)];
    }
    
    [[Transfer sharedTransfer] startTransfer:@"089020"
                                      fskCmd:nil
                                    paramDic:requstDict
                                      attach:attach
                                        mess:@"正在上传信息"
                                     success:^(id result) {
                                         
                                         if ([result[@"rtCd"] isEqualToString:@"00"])
                                         {
                                             [SVProgressHUD showSuccessWithStatus:@"信息已上传，等待后台人员审核。"];
                                             [self.navigationController popViewControllerAnimated:YES];
                                         }
                                         else
                                         {
                                             [SVProgressHUD showErrorWithStatus:result[@"rtCmnt"]];
                                         }
                                         
                                          
                                      } fail:nil];;
}

-(IBAction)confirmAction:(id)sender{
    
    [self realNameAuth];
}

-(IBAction)bankAction:(id)sender{
    
}

-(IBAction)provinceAction:(id)sender{
    
}

-(IBAction)cityAction:(id)sender{
    
}

-(IBAction)msgAction:(id)sender{
    
    [self getVerCode];
}
@end
