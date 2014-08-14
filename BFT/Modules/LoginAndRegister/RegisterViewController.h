//
//  RegisterViewController.h
//  BFT
//
//  Created by 文彬 on 14-7-11.
//  Copyright (c) 2014年 文彬. All rights reserved.
//
/*----------------------------------------------------------------
 // Copyright (C)
 // 版权所有。
 //
 // 文件功能描述：注册页面
 
 // 创建标识：
 // 修改标识：
 // 修改日期：
 // 修改描述：
 //
 ----------------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface RegisterViewController : BaseViewController<UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate>
{
    NSArray *images;
    NSArray *placeHolds;
    UITextField *currentTxtField;
    NSMutableDictionary *resutDict;
    NSString *pswRsaValue;
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UITextField *messCodeTxtField;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIView *protocalView; //阅读协议的视图
@property (weak, nonatomic) IBOutlet UITextView *protocalTxtView;

- (IBAction)buttonClick:(id)sender;

@end
