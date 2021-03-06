//
//  PasswordTextField.h
//  redarrow
//
//  Created by jia liao on 12/16/12.
//  Copyright (c) 2012 GP. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RandomKeyBoardView.h"
#import "IPhoneCustomKeyboard.h"


//@interface PwdLeftTextField : UIView<UITextFieldDelegate, RandomKeyBoardDelegate>

@interface PwdLeftTextField : UIView<UITextFieldDelegate>


@property(nonatomic, strong) UITextField                *pwdTF;
//@property(nonatomic, strong) RandomKeyBoardView         *randomKeyBoardView;

@property(nonatomic, strong) IPhoneCustomKeyboard *randomKeyBoardView;

@property(nonatomic, strong, readonly)NSString          *rsaValue;
@property(nonatomic, strong) NSString                   *md5Value;
@property(nonatomic, strong) NSString                   *inputStr;
- (id) initWithFrame:(CGRect)frame left:(NSString*)leftStr prompt:(NSString*)prompt;
- (void) numberKeyBoardInput:(NSInteger) number;
- (void) numberKeyBoardDelete;
- (void) numberKeyBoardConfim;
- (void) numberKeyBoardClear;
- (void) numberKeyBoardAbout;
- (void) setRsa;

@end
