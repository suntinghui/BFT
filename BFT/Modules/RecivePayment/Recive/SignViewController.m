//
//  SignViewController.m
//  BFT
//
//  Created by Sappfire on 14-8-19.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import "SignViewController.h"

#define Button_Tag_Clear    101  //清除
#define Button_Tag_Ok       102  //确定

@interface SignViewController ()

@end

@implementation SignViewController

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
    self.navigationItem.title = @"请签名";
    hasTitleView = YES;
    
    //初始化画板视图
    paintCanVasView = [[PaintMaskView alloc]initWithFrame:CGRectMake(0, 114, 320, 390)];
    [paintCanVasView makePaintMaskViewEnable:YES];
    [paintCanVasView setColorWithRed:0 Green:0 Blue:0];
    [paintCanVasView setPaintLineWidth:3];
    [self.view addSubview:paintCanVasView];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮点击事件
- (IBAction)buttonClickHandle:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    switch (button.tag) {
        case Button_Tag_Clear:
        {
            [paintCanVasView clearPaintMask];

        }
            break;
        case Button_Tag_Ok:
        {
            if (paintCanVasView.drawImage.image == nil)
            {
                [SVProgressHUD showErrorWithStatus:@"请输入签名"];
                return;
            }
            
            [SVProgressHUD showWithStatus:@"正在处理图片" maskType:SVProgressHUDMaskTypeClear cancelBlock:nil];
            
            [NSThread detachNewThreadSelector:@selector(converImageToHex) toTarget:self withObject:nil];

        
        }
            
        default:
            break;
    }
    
}

#pragma mark -功能函数
- (void)converImageToHex
{
    @autoreleasepool
    {
        UIImage *image = [StaticTools imageWithImage:paintCanVasView.drawImage.image scaledToSize:CGSizeMake(240, 160)]; //TODO 此处图片size稍微大一点时  崩溃频率较高
        NSData *imageData = UIImagePNGRepresentation(image);
        
        NSLog(@"开始处理图片 长度：%d",[imageData length]);
        //图片转成16进制字符串后上传
        Byte *bytes = (Byte *)[imageData bytes];
        NSString *hexStr=@"";
        for(int i=0;i<[imageData length];i++)
        {
            @autoreleasepool
            {
                NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
                if([newHexStr length]==1)
                    hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
                else
                    hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
        }
        
        NSLog(@"图片处理完成");
        
       // [self performSelectorOnMainThread:@selector(uploadSignWithImage:) withObject:hexStr waitUntilDone:NO];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

#pragma mark -http请求
/**
 *  上传签名图片 转成png格式上传
 */
//- (void)uploadSignWithImage:(NSString*)imgStr
//{
//    [SVProgressHUD dismiss];
//    
//    NSDictionary *dict = @{kTranceCode:@"199010",
//                           kParamName:@{@"LOGNO":self.logNum,
//                                        @"ELESIGNA":imgStr}};
//    
//    AFHTTPRequestOperation *operation = [[Transfer sharedTransfer] TransferWithRequestDic:dict
//                                                                                   prompt:nil
//                                                                                  success:^(id obj)
//                                         {
//                                             if ([obj isKindOfClass:[NSDictionary class]])
//                                             {
//                                                 if ([obj[@"RSPCOD"] isEqualToString:@"00"])
//                                                 {
//                                                     
//                                                     TradeSuccessViewController *tradeSucController = [[TradeSuccessViewController alloc] init];
//                                                     tradeSucController.logNum = self.logNum;
//                                                     [self.navigationController pushViewController:tradeSucController animated:YES];
//                                                     
//                                                 }
//                                                 else
//                                                 {
//                                                     [SVProgressHUD showErrorWithStatus:obj[@"RSPMSG"]];
//                                                 }
//                                                 
//                                             }
//                                             
//                                         }
//                                                                                  failure:^(NSString *errMsg)
//                                         {
//                                             [SVProgressHUD showErrorWithStatus:@"上传失败，请稍后再试!"];
//                                             
//                                         }];
//    
//    [[Transfer sharedTransfer] doQueueByTogether:[NSArray arrayWithObjects:operation, nil] prompt:@"正在上传..." completeBlock:^(NSArray *operations) {
//    }];
//    
//    
//}


@end
