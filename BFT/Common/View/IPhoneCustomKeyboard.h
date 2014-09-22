//
//  IPhoneCustomKeyboard.h
//  iOS Custom Keyboards
//
//  Created by kongbei on 13-6-4.
//  Copyright (c) 2013年 Kulpreet Chilana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol IPhoneCustomKeyboard <NSObject>

@end
//小写字母集
#define kChar_letter @[ @"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p", @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"z", @"x", @"c", @"v", @"b", @"n", @"m" ]
//大写字母集
//#define kChar_letter_shift @[ @"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"Z", @"X", @"C", @"V", @"B", @"N", @"M" ]
//数字集
#define kChar_numeral @[ @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9" ]
//标点集
#define kChar_punctuation @[ @":",@"!", @"#", @"}", @")", @"*", @">", @"_", @"|", @";", @"￥", @"]", @"{", @"~", @"^", @"=", @"\\", @"'", @"[", @"(", @"\"", @"+", @"-", @"<", @"$", @"&", @"%", @"@" ]


@interface IPhoneCustomKeyboard : UIView <UIInputViewAudioFeedback>
{
@private
    __weak id<IPhoneCustomKeyboard> _delegate;

    
}
@property(nonatomic, strong)id<IPhoneCustomKeyboard>delegate;




//数字键盘上按钮
//1.@符号
@property (nonatomic,retain) IBOutlet UIButton *numeralKeyboardAtBtn;
//2.空格
@property (nonatomic,retain) IBOutlet UIButton *numeralKeyboardSpaceBtn;


//取消按钮
@property (nonatomic,retain) IBOutlet UIButton *cancelBtn;
//切换系统键盘按钮
@property (nonatomic,retain) IBOutlet UIButton *changeToSysKeyboardBtn;
//完成按钮
@property (nonatomic,retain) IBOutlet UIButton *completeBtn;


//字母按钮控件集
@property (nonatomic,retain) IBOutletCollection(UIButton) NSArray *letterKeysBtnArray;
//标点按钮控件集
@property (nonatomic,retain) IBOutletCollection(UIButton) NSArray *punctuationKeysBtnArray;
//数字按钮控件集
@property (nonatomic,retain) IBOutletCollection(UIButton) NSArray *numeralKeysBtnArray;
@property (nonatomic,retain) IBOutletCollection(UIButton) NSArray *numeralOtherKeysBtnArray;

//切换大小写字母键盘
@property (nonatomic,retain) IBOutlet UIButton *shiftButton;
//切换到数字键盘
@property (nonatomic,retain) IBOutlet UIButton *numeralButton;
//切换到标点符号键盘
@property (nonatomic,retain) IBOutlet UIButton *punctuationButton;

//字母输入页板View
@property (nonatomic,retain) IBOutlet UIView *letterKeyboardView;
//数字输入页板View
@property (nonatomic,retain) IBOutlet UIView *numeralKeyboardView;
//标点输入页板View
@property (nonatomic,retain) IBOutlet UIView *punctuationKeyboardView;

@property (nonatomic,retain) IBOutlet UIButton *deleteButton;//设置点击效果背景图片时用
@property (assign) id<UITextInput> textView;
@property (nonatomic, retain) IBOutlet UIButton *spaceButton;//设置点击效果背景图片时用

//@property (nonatomic, retain) UIView *systemInputView;

- (IBAction)shiftPressed:(id)sender;

- (IBAction)showLetterKeyboardPressed:(id)sender;
- (IBAction)showNumeralKeyboardPressed:(id)sender;
- (IBAction)showPunctuationKeyboardPressed:(id)sender;

- (IBAction)deletePressed:(id)sender;
- (IBAction)unShift;
- (IBAction)spacePressed:(id)sender;

//取消按钮事件
- (IBAction)cancelPressed:(id)sender;
//确定按钮事件
- (IBAction)finishPressed:(id)sender;
//切换系统输入法按钮事件
- (IBAction)changeToSysInputMethodPressed:(id)sender;

@end
