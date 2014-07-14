//
//  AuthenticationUpImageViewController.h
//  BFT
//
//  Created by liao jia on 14-7-14.
//  Copyright (c) 2014年 文彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticationUpImageViewController : BaseViewController

@property(strong, nonatomic)IBOutlet UITextField *tf_cardNo;
@property(strong, nonatomic)IBOutlet UITextField *tf_merchantName;
@property(strong, nonatomic)IBOutlet UITextField *tf_msg;
-(IBAction)imageOneAction:(id)sender;
-(IBAction)imageTwoAction:(id)sender;
-(IBAction)imageThreeAction:(id)sender;

-(IBAction)confirmAction:(id)sender;
-(IBAction)bankAction:(id)sender;
-(IBAction)provinceAction:(id)sender;
-(IBAction)cityAction:(id)sender;

-(IBAction)msgAction:(id)sender;


@end
