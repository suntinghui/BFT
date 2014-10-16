//
//  YLTPasswordTextField.m
//  YLTiPhone
//
//  Created by xushuang on 14-1-16.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "YLTPasswordTextField.h"
#import "EncryptionUtil.h"

@interface YLTPasswordTextField ()
{
    
}

@end

@implementation YLTPasswordTextField

@synthesize pwdTF;
@synthesize randomKeyBoardView;
@synthesize rsaValue;
@synthesize md5Value;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        // Initialization code
        UIImageView *bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bgIV setImage:[UIImage imageNamed:@"loginInputbg_long.png"]];
        [self addSubview:bgIV];
        
        float y = 3.0;
        if (DeviceVersion >= 7)
        {
            y = 3.0;
        }
        else
        {
            y = 10.0;
        }
        pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(0, y, frame.size.width, frame.size.height)];
        self.backgroundColor = [UIColor clearColor];
        pwdTF.delegate = self;
        [pwdTF setPlaceholder:@"请输入密码"];
        pwdTF.secureTextEntry = YES;

        [pwdTF setFont:[UIFont systemFontOfSize:15]];
        
        randomKeyBoardView = [[IPhoneCustomKeyboard alloc] init];
                [randomKeyBoardView setTextView:pwdTF];
        
        randomKeyBoardView.delegate = self;
        
        [self addSubview:pwdTF];
    }
    return self;
}

-(void) awakeFromNib{
    
    
    // Initialization code
//    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    [bgIV setImage:[UIImage imageNamed:@"loginInputbg_long.png"]];
//    [self addSubview:bgIV];
    
    float y = 3.0;
    if (DeviceVersion >= 7)
    {
        y = 3.0;
    }
    else
    {
        y = 10.0;
    }
    pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, self.frame.size.height)];
    self.backgroundColor = [UIColor clearColor];
    pwdTF.delegate = self;
    [pwdTF setPlaceholder:@"请输入密码"];
    pwdTF.secureTextEntry = YES;
    [pwdTF setFont:[UIFont systemFontOfSize:15]];
    
    randomKeyBoardView = [[IPhoneCustomKeyboard alloc]init];
    [randomKeyBoardView setTextView:pwdTF];
    
  //  randomKeyBoardView.delegate = self;
    [self addSubview:pwdTF];
}



- (void) numberKeyBoardAbout
{
    NSString *mess = [NSString stringWithFormat:@"%@为保护您的密码安全，请您使用定制的键盘输入密码。密码键盘每次随机打乱按键顺序，并且在您输入完6位密码后自动对密码进行加密，全面保护您的账户安全。",@"百付通"];
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"关于"
                                                   message:mess
                                                  delegate:self
                                         cancelButtonTitle:@"确 定"
                                         otherButtonTitles:nil];
    [alert show];
}

-(void)setRsa
{
#ifndef DEMO
    
        rsaValue = [NSString stringWithString:[EncryptionUtil rsaEncrypt:[NSString stringWithFormat:@"%@",pwdTF.text]]];
    
#endif
}

- (NSString *)rsaValue
{
#ifdef DEMO
    NSLog(@"写死的密码");
    return @"3dc8afdc432bf3be2370fde5707ccbf248a1853d5a85e3782088f7d4a8767e12dfe687096a6364876dd62f7148191608f118bc65a85002cf74f4a5afb65be312b612ce8358da9dcdfbcf84adab8a4c50613cd225617314e882a41a52037ca648ca13bed5829e99b86cd59a26d56536f0a1e3e2cb5e99703b63872e726c1321e0";
#else
    
   
    return rsaValue;
#endif
}



#pragma mark - UITextFieldDelegate 每一次弹出密码框都要刷新键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   // [self.randomKeyBoardView refresh:nil];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:textField];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{

    
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [self.delegate textFieldDidEndEditing:textField];
    }
}
@end
