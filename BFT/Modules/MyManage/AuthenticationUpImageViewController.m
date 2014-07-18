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
    [self.scrollView setContentSize:CGSizeMake(320, 931)];
    hasTitleView = true;
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
        
        [SVProgressHUD showWithStatus:@"正在处理图片" maskType:SVProgressHUDMaskTypeClear cancelBlock:nil];
        [NSThread detachNewThreadSelector:@selector(handleImage:) toTarget:self withObject:image];
        
        //        [self uploadImageWithType:operateType image:image];
    }
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -http请求
- (void)handleImage:(UIImage*)image
{
    NSString *imgBase = [Base64 encode:UIImageJPEGRepresentation(image, 1)];
    [SVProgressHUD dismiss];
    
}

-(IBAction)imageOneAction:(id)sender{
    
}

-(IBAction)imageTwoAction:(id)sender{
    
}

-(IBAction)imageThreeAction:(id)sender{
    
}

-(IBAction)confirmAction:(id)sender{
    
}

-(IBAction)bankAction:(id)sender{
    
}

-(IBAction)provinceAction:(id)sender{
    
}

-(IBAction)cityAction:(id)sender{
    
}

-(IBAction)msgAction:(id)sender{
    
}
@end
