//
//  IPhoneCustomKeyboard.m
//  iOS Custom Keyboards
//
//  Created by kongbei on 13-6-4.
//  Copyright (c) 2013年 Kulpreet Chilana. All rights reserved.
//

#import "IPhoneCustomKeyboard.h"

//popView样式(左、中、右、最大)
enum {
    PKNumberPadViewImageLeft = 0,
    PKNumberPadViewImageInner = 1,
    PKNumberPadViewImageRight = 2,
    PKNumberPadViewImageMax = 3
};

//显示何种键盘
enum {
    keyboardTypeLetter = 0,
    keyboardTypeNumeral = 1,
    keyboardTypePunctuation = 2
}keyboardType;

//显示大写还是小写字母键盘
enum {
    letterKeyboardTypeLower = 0,
    letterKeyboardTypeUpper = 1
}letterKeyboardType;


@interface IPhoneCustomKeyboard()

@property (nonatomic, assign, getter = isShifted) BOOL shifted;

@end

@implementation IPhoneCustomKeyboard
@synthesize textView = _textView;
@synthesize delegate = _delegate;

//@synthesize systemInputView;

- (id)init
{
	UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
	CGRect frame;
    
	if(UIDeviceOrientationIsLandscape(orientation))
    {
        //TODO 横屏时这个高度要再看看用多少？ 是否要支持横屏
        frame = CGRectMake(0, 0, 480, 162);
    }
    else
    {
        frame = CGRectMake(0, 0, 320, 260);
    }
	
	self = [super initWithFrame:frame];
	
	if (self)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IPhoneCustomKeyboard" owner:self options:nil];
		[[nib objectAtIndex:0] setFrame:frame];
        self = [nib objectAtIndex:0];
    }
	
    //加载小写键盘
	[self loadLettersWithArray:kChar_letter];
    //加载数字键盘
    [self loadNumeralsWithArray:kChar_numeral];
    //加载标点键盘
    [self loadPunctuationsWithArray:kChar_punctuation];
    
    //默认显示字母输入键盘
    [self showKeyboardType:keyboardTypeLetter];
    
    //设置按钮背景图片和事件
    [self setBtnBgAndEvent];
    
    
    
	return self;
}

/*
 * 设置按钮背景图片和事件
 */
- (void)setBtnBgAndEvent
{
    //取消按钮背景
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"取消1.png"] forState:UIControlStateHighlighted];
    //切换到系统键盘按钮背景
    [self.changeToSysKeyboardBtn setBackgroundImage:[UIImage imageNamed:@"切换1.png"] forState:UIControlStateHighlighted];
    //完成按钮背景
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"完成1.png"] forState:UIControlStateHighlighted];
    
    //字母键盘上按钮
    //1.空格
    [self.spaceButton setBackgroundImage:[UIImage imageNamed:@"空格1.png"] forState:UIControlStateHighlighted];
    //2.删除(3套键盘用同一张图)
    [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"删除按钮1.png"] forState:UIControlStateHighlighted];
    
    //数字键盘上按钮
    //1.@符号
    [self.numeralKeyboardAtBtn setBackgroundImage:[UIImage imageNamed:@"数字按钮1.png"] forState:UIControlStateHighlighted];
    //2.空格
    [self.numeralKeyboardSpaceBtn setBackgroundImage:[UIImage imageNamed:@"数字空格1.png"] forState:UIControlStateHighlighted];
    
    //给所有数字键盘上的输入键加事件
    for (UIButton *tempBtn in self.numeralKeysBtnArray)
    {
        [tempBtn addTarget:self action:@selector(numeralKeyPressed:) forControlEvents:UIControlEventTouchUpInside];
        [tempBtn setBackgroundImage:[UIImage imageNamed:@"数字按钮1.png"] forState:UIControlStateHighlighted];
    }
    for (UIButton *tempBtn in self.numeralOtherKeysBtnArray)
    {
        [tempBtn addTarget:self action:@selector(numeralKeyPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //@符号背景和数字按钮不一样，在上面已经设置过了
        //D_yzf20130626  @
//        if (tempBtn.tag == 1001)
//        {
//            continue;
//        }
        [tempBtn setBackgroundImage:[UIImage imageNamed:@"确定按钮1.png"] forState:UIControlStateHighlighted];
        
        

     //  [UIColor colorWithRed:0.83f green:0.82f blue:0.82f alpha:1.00f];
        
        
    }
}


#pragma mark -
#pragma mark 随机加载字母、大小写字母键盘切换、数字、标点符号键盘
/*
 * 加换字母键盘
 */
- (void)loadLettersWithArray:(NSArray *)a
{
    NSMutableArray *randomMtbArray = [self randomCharactersArrayWithArray:a];
    
	int i = 0;
	for (UIButton *b in self.letterKeysBtnArray)
    {
		[b setTitle:[randomMtbArray objectAtIndex:i] forState:UIControlStateNormal];
		i ++;
	}
}

/*
 * 功能说明：显示大写还是小写字母键盘
 * @param letterKeyboardType:
 *        letterKeyboardTypeLower:小写字母键盘
 *        letterKeyboardTypeUpper:大写字母键盘
 */
- (void)showLetterKeyboardType:(NSInteger)letterKeyboardType
{
    switch (letterKeyboardType)
    {
        case letterKeyboardTypeLower:
            for (UIButton *b in self.letterKeysBtnArray)
            {                
                [b setTitle:[b.titleLabel.text lowercaseString] forState:UIControlStateNormal];
            }
            break;
            
        case letterKeyboardTypeUpper:
            for (UIButton *b in self.letterKeysBtnArray)
            {
                [b setTitle:[b.titleLabel.text uppercaseString] forState:UIControlStateNormal];
            }
            break;
            
        default:
            break;
    }

    
}

/*
 * 加换数字键盘
 */
- (void)loadNumeralsWithArray:(NSArray *)a
{
    NSMutableArray *randomMtbArray = [self randomCharactersArrayWithArray:a];
    
	int i = 0;
	for (UIButton *b in self.numeralKeysBtnArray)
    {
		[b setTitle:[randomMtbArray objectAtIndex:i] forState:UIControlStateNormal];
		i ++;
	}
}

/*
 * 加换标点键盘
 */
- (void)loadPunctuationsWithArray:(NSArray *)a
{
    NSMutableArray *randomMtbArray = [self randomCharactersArrayWithArray:a];
    
	int i = 0;
	for (UIButton *b in self.punctuationKeysBtnArray)
    {
		[b setTitle:[randomMtbArray objectAtIndex:i] forState:UIControlStateNormal];
		i ++;
	}
}


#pragma mark -
#pragma mark 切换键盘
/*
 * 功能说明：显示什么类型键盘
 * @param keyboardType:
 *        keyboardTypeLetter:字母
 *        keyboardTypeNumeral:数字
 *        keyboardTypePunctuation:标点
 */
- (void)showKeyboardType:(NSInteger)keyboardType
{
    switch (keyboardType)
    {
        case keyboardTypeLetter:
            [self.letterKeyboardView setHidden:NO];
            [self.numeralKeyboardView setHidden:YES];
            [self.punctuationKeyboardView setHidden:YES];
            break;
            
        case keyboardTypeNumeral:
            [self.letterKeyboardView setHidden:YES];
            [self.numeralKeyboardView setHidden:NO];
            [self.punctuationKeyboardView setHidden:YES];
            break;
            
        case keyboardTypePunctuation:
            [self.letterKeyboardView setHidden:YES];
            [self.numeralKeyboardView setHidden:YES];
            [self.punctuationKeyboardView setHidden:NO];
            break;
            
        default:
            break;
    }
}

/*
 * 功能说明：切换到字母键盘
 */
- (IBAction)showLetterKeyboardPressed:(id)sender
{
    [[UIDevice currentDevice] playInputClick];
    
    //切换到字母键盘
    //1.1 显示letterView
    [self showKeyboardType:keyboardTypeLetter];
    
    //1.2 重置为小写键盘
    [self showLetterKeyboardType:letterKeyboardTypeLower];
    
    //1.3 如果需要每次随机就在此处理数据源
}

/*
 * 功能说明：切换到数字键盘
 */
- (IBAction)showNumeralKeyboardPressed:(id)sender
{
    [[UIDevice currentDevice] playInputClick];
    
    //重置shiftButton状态
	[self.shiftButton setBackgroundImage:[UIImage imageNamed:@"大写按钮.png"] forState:UIControlStateNormal];
	self.shifted = NO;
	
    //切换到数字键盘
    //1.1 显示numeralView
    [self showKeyboardType:keyboardTypeNumeral];
    
    //1.2 如果需要每次随机就在此处理数据源
}

/*
 * 功能说明：切换到标点键盘
 */
- (IBAction)showPunctuationKeyboardPressed:(id)sender
{
    [[UIDevice currentDevice] playInputClick];
    
    //重置shiftButton状态
	[self.shiftButton setBackgroundImage:[UIImage imageNamed:@"大写按钮.png"] forState:UIControlStateNormal];
	self.shifted = NO;
	
    //切换到数字键盘
    //1.1 显示numeralView
    [self showKeyboardType:keyboardTypePunctuation];
    
    //1.2 如果需要每次随机就在此处理数据源
}


#pragma mark -
#pragma mark 功能键 IBActions for Keyboard Buttons
/*
 * 取消按钮
 */
- (IBAction)cancelPressed:(id)sender
{
    if ([self.textView isKindOfClass:[UITextView class]])
    {
        [(UITextView *)self.textView setText:@""];
        [(UITextView *)self.textView resignFirstResponder];
    }
	else if ([self.textView isKindOfClass:[UITextField class]])
    {
        [(UITextField *)self.textView setText:@""];
        [(UITextField *)self.textView resignFirstResponder];
    }
}

//确定按钮事件
- (IBAction)finishPressed:(id)sender
{
    if ([self.textView isKindOfClass:[UITextView class]])
    {
        [(UITextView *)self.textView resignFirstResponder];
    }
	else if ([self.textView isKindOfClass:[UITextField class]])
    {
        [(UITextField *)self.textView resignFirstResponder];
    }
}

/*
 * 切换系统输入法按钮事件
 */
- (IBAction)changeToSysInputMethodPressed:(id)sender
{
    if ([self.textView isKindOfClass:[UITextView class]])
    {
        [(UITextView *)self.textView resignFirstResponder];
    }
	else if ([self.textView isKindOfClass:[UITextField class]])
    {
        [(UITextField *)self.textView resignFirstResponder];
    }
    
    [self performSelector:@selector(changeInputMethod) withObject:nil afterDelay:0.3];
}

/*
 * 切换到系统键盘
 */
- (void)changeInputMethod
{
    if ([self.textView isKindOfClass:[UITextView class]])
    {
//        [(UITextView *)self.textView setInputView:self.systemInputView];
        [(UITextView *)self.textView setInputView:nil];
        [(UITextView *)self.textView becomeFirstResponder];
    }
	else if ([self.textView isKindOfClass:[UITextField class]])
    {
//        [(UITextField *)self.textView setInputView:self.systemInputView];
        [(UITextField *)self.textView setInputView:nil];
        [(UITextField *)self.textView becomeFirstResponder];
    }
}

/*
 * 大写锁定按钮
 */
- (IBAction)shiftPressed:(id)sender
{
	[[UIDevice currentDevice] playInputClick];
    
    //如果点之前是小写状态，切换到大写状态
	if (!self.isShifted)
    {
		[self.shiftButton setBackgroundImage:[UIImage imageNamed:@"大写按钮1.png"] forState:UIControlStateNormal];
        
        //显示大写字母键盘
        [self showLetterKeyboardType:letterKeyboardTypeUpper];
	}
}

/*
 * 大写锁定按钮(取消选中状态)
 */
- (IBAction)unShift
{
    //如果点之前是选中状态，取消选中状态，并换成小写字母集
	if (self.isShifted)
    {
		[self.shiftButton setBackgroundImage:[UIImage imageNamed:@"大写按钮.png"] forState:UIControlStateNormal];
        
        //显示小写字母键盘
        [self showLetterKeyboardType:letterKeyboardTypeLower];
	}
    
	if (!self.isShifted)
    {
        self.shifted = YES;
    }
	else
    {
        self.shifted = NO;
    }
}

/*
 * 空格按钮
 */
- (IBAction)spacePressed:(id)sender
{
    [[UIDevice currentDevice] playInputClick];
    
	[self.textView insertText:@" "];
    
    //如果点击空格时是大写状态，切换成小写
	if (self.isShifted)
    {
        [self unShift];
    }
	
	if ([self.textView isKindOfClass:[UITextView class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    }
	else if ([self.textView isKindOfClass:[UITextField class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
    }
}

/*
 * delete button click
 */
- (IBAction)deletePressed:(id)sender
{
    [[UIDevice currentDevice] playInputClick];
	[self.textView deleteBackward];
    
	if ([self.textView isKindOfClass:[UITextView class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    }
    else if ([self.textView isKindOfClass:[UITextField class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
    }
}

//数字键盘View上的所有输入字符按钮点击事件
- (IBAction)numeralKeyPressed:(id)sender
{
    [[UIDevice currentDevice] playInputClick];
    
    UIButton *button = (UIButton *)sender;
	NSString *character = [NSString stringWithString:button.titleLabel.text];
	[self.textView insertText:character];
	
	if ([self.textView isKindOfClass:[UITextView class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    }
	else if ([self.textView isKindOfClass:[UITextField class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
    }
}

/*
 * 所有输入字母/标点 button click
 */
- (IBAction)letterPressed:(id)sender
{
	UIButton *button = (UIButton *)sender;
	NSString *character = [NSString stringWithString:button.titleLabel.text];
    
	[self.textView insertText:character];
    
	if (self.isShifted)
    {
        [self unShift];
    }
	
	if ([self.textView isKindOfClass:[UITextView class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    }
	else if ([self.textView isKindOfClass:[UITextField class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
    }
}

/*
 * (字母/标点)按下时，pop出阴影框
 */
- (void)addPopupToButton:(UIButton *)b
{
    UIImageView *keyPop;
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 52, 60)];
    
    if (self.letterKeyboardView.hidden == NO)
    {//字母键盘
        if (b == [self.letterKeysBtnArray objectAtIndex:0])
        {
            keyPop = [[UIImageView alloc] initWithImage:
                      [UIImage imageWithCGImage:[self createKeytopImageWithKind:PKNumberPadViewImageRight]
                                          scale:[[UIScreen mainScreen] scale]
                                    orientation:UIImageOrientationDown]];
            
            keyPop.frame = CGRectMake(-16, -71, keyPop.frame.size.width, keyPop.frame.size.height);
        }
        else if (b == [self.letterKeysBtnArray objectAtIndex:9])
        {
            keyPop = [[UIImageView alloc] initWithImage:
                      [UIImage imageWithCGImage:[self createKeytopImageWithKind:PKNumberPadViewImageLeft]
                                          scale:[[UIScreen mainScreen] scale]
                                    orientation:UIImageOrientationDown]];
            
            keyPop.frame = CGRectMake(-38, -71, keyPop.frame.size.width, keyPop.frame.size.height);
        }
        else
        {
            keyPop = [[UIImageView alloc] initWithImage:
                      [UIImage imageWithCGImage:[self createKeytopImageWithKind:PKNumberPadViewImageInner]
                                          scale:[[UIScreen mainScreen] scale]
                                    orientation:UIImageOrientationDown]];
            
            keyPop.frame = CGRectMake(-27, -71, keyPop.frame.size.width, keyPop.frame.size.height);
        }
    }
    else
    {//字符键盘
        if (b.tag == 311 || b.tag == 321 || b.tag == 331)
        {
            keyPop = [[UIImageView alloc] initWithImage:
                      [UIImage imageWithCGImage:[self createKeytopImageWithKind:PKNumberPadViewImageRight]
                                          scale:[[UIScreen mainScreen] scale]
                                    orientation:UIImageOrientationDown]];
            
            keyPop.frame = CGRectMake(-16, -71, keyPop.frame.size.width, keyPop.frame.size.height);
        }
        else if (b.tag == 3110 || b.tag == 3210)
        {
            keyPop = [[UIImageView alloc] initWithImage:
                      [UIImage imageWithCGImage:[self createKeytopImageWithKind:PKNumberPadViewImageLeft]
                                          scale:[[UIScreen mainScreen] scale]
                                    orientation:UIImageOrientationDown]];
            
            keyPop.frame = CGRectMake(-38, -71, keyPop.frame.size.width, keyPop.frame.size.height);
        }
        else
        {
            keyPop = [[UIImageView alloc] initWithImage:
                      [UIImage imageWithCGImage:[self createKeytopImageWithKind:PKNumberPadViewImageInner]
                                          scale:[[UIScreen mainScreen] scale]
                                    orientation:UIImageOrientationDown]];
            
            keyPop.frame = CGRectMake(-27, -71, keyPop.frame.size.width, keyPop.frame.size.height);
        }
    }
    
    [text setFont:[UIFont boldSystemFontOfSize:44]];
   // [text setTextAlignment:UITextAlignmentCenter];
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setBackgroundColor:[UIColor clearColor]];
    [text setShadowColor:[UIColor whiteColor]];
    [text setText:b.titleLabel.text];
    
    keyPop.layer.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0].CGColor;
    keyPop.layer.shadowOffset = CGSizeMake(0, 3.0);
    keyPop.layer.shadowOpacity = 1;
    keyPop.layer.shadowRadius = 5.0;
    keyPop.clipsToBounds = NO;
    
    [keyPop addSubview:text];
    [b addSubview:keyPop];
}


#pragma mark -
#pragma mark View 点击触发 Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.letterKeyboardView.hidden == NO)
    {//字母键盘
        CGPoint location = [[touches anyObject] locationInView:self.letterKeyboardView];
        
        for (UIButton *tempBtn in self.letterKeysBtnArray)
        {//遍历所有按钮控件，移除掉按钮的pop显示页
            if ([tempBtn subviews].count > 1)
            {
                [[[tempBtn subviews] objectAtIndex:1] removeFromSuperview];
            }
            
            //如果点击的是字母按钮
            if(CGRectContainsPoint(tempBtn.frame, location))
            {
                [self addPopupToButton:tempBtn];
                [[UIDevice currentDevice] playInputClick];
            }
        }
    }
    else if(self.punctuationKeyboardView.hidden == NO)
    {//标点键盘
        CGPoint location = [[touches anyObject] locationInView:self.punctuationKeyboardView];
        
        for (UIButton *tempBtn in self.punctuationKeysBtnArray)
        {//遍历所有按钮控件，移除掉按钮的pop显示页
            if ([tempBtn subviews].count > 1)
            {
                [[[tempBtn subviews] objectAtIndex:1] removeFromSuperview];
            }
            
            //如果点击的是字母按钮
            if(CGRectContainsPoint(tempBtn.frame, location))
            {
                [self addPopupToButton:tempBtn];
                [[UIDevice currentDevice] playInputClick];
            }
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.letterKeyboardView.hidden == NO)
    {//字母键盘
        CGPoint location = [[touches anyObject] locationInView:self.letterKeyboardView];
        
        for (UIButton *tempBtn in self.letterKeysBtnArray)
        {
            if ([tempBtn subviews].count > 1)
            {
                [[[tempBtn subviews] objectAtIndex:1] removeFromSuperview];
            }
            
            if(CGRectContainsPoint(tempBtn.frame, location))
            {
                [self addPopupToButton:tempBtn];
            }
        }
    }
    else if (self.punctuationKeyboardView.hidden == NO)
    {//标点键盘
        CGPoint location = [[touches anyObject] locationInView:self.punctuationKeyboardView];
        
        for (UIButton *tempBtn in self.punctuationKeysBtnArray)
        {
            if ([tempBtn subviews].count > 1)
            {
                [[[tempBtn subviews] objectAtIndex:1] removeFromSuperview];
            }
            
            if(CGRectContainsPoint(tempBtn.frame, location))
            {
                [self addPopupToButton:tempBtn];
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.letterKeyboardView.hidden == NO)
    {
        CGPoint location = [[touches anyObject] locationInView:self.letterKeyboardView];
        
        for (UIButton *tempBtn in self.letterKeysBtnArray)
        {//移除Button的popView
            if ([tempBtn subviews].count > 1)
            {
                [[[tempBtn subviews] objectAtIndex:1] removeFromSuperview];
            }
            
            //如果点中了tempBtn，则将tempBtn的值追加到textView的text值后
            if(CGRectContainsPoint(tempBtn.frame, location))
            {
                [self letterPressed:tempBtn];
            }
        }
    }
    else if (self.punctuationKeyboardView.hidden == NO)
    {
        CGPoint location = [[touches anyObject] locationInView:self.punctuationKeyboardView];
        
        for (UIButton *tempBtn in self.punctuationKeysBtnArray)
        {//移除Button的popView
            if ([tempBtn subviews].count > 1)
            {
                [[[tempBtn subviews] objectAtIndex:1] removeFromSuperview];
            }
            
            //如果点中了b，则将b的值追加到textView的text值后
            if(CGRectContainsPoint(tempBtn.frame, location))
            {
                [self letterPressed:tempBtn];
            }
        }
    }
}

- (BOOL)enableInputClicksWhenVisible
{
    return YES;
}


#pragma mark -
#pragma mark UI Utilities
/*
 * 根据色值，画出image
 */
+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#define _UPPER_WIDTH   (52.0 * [[UIScreen mainScreen] scale])
#define _LOWER_WIDTH   (32.0 * [[UIScreen mainScreen] scale])

#define _PAN_UPPER_RADIUS  (7.0 * [[UIScreen mainScreen] scale])
#define _PAN_LOWER_RADIUS  (7.0 * [[UIScreen mainScreen] scale])

#define _PAN_UPPDER_WIDTH   (_UPPER_WIDTH-_PAN_UPPER_RADIUS*2)
#define _PAN_UPPER_HEIGHT    (61.0 * [[UIScreen mainScreen] scale])

#define _PAN_LOWER_WIDTH     (_LOWER_WIDTH-_PAN_LOWER_RADIUS*2)
#define _PAN_LOWER_HEIGHT    (32.0 * [[UIScreen mainScreen] scale])

#define _PAN_UL_WIDTH        ((_UPPER_WIDTH-_LOWER_WIDTH)/2)

#define _PAN_MIDDLE_HEIGHT    (11.0 * [[UIScreen mainScreen] scale])

#define _PAN_CURVE_SIZE      (7.0 * [[UIScreen mainScreen] scale])

#define _PADDING_X     (15 * [[UIScreen mainScreen] scale])
#define _PADDING_Y     (10 * [[UIScreen mainScreen] scale])
#define _WIDTH   (_UPPER_WIDTH + _PADDING_X*2)
#define _HEIGHT   (_PAN_UPPER_HEIGHT + _PAN_MIDDLE_HEIGHT + _PAN_LOWER_HEIGHT + _PADDING_Y*2)


#define _OFFSET_X    -25 * [[UIScreen mainScreen] scale])
#define _OFFSET_Y    59 * [[UIScreen mainScreen] scale])


/*
 * 创建pop出来的区域图片
 */
- (CGImageRef)createKeytopImageWithKind:(int)kind
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint p = CGPointMake(_PADDING_X, _PADDING_Y);
    CGPoint p1 = CGPointZero;
    CGPoint p2 = CGPointZero;
    
    p.x += _PAN_UPPER_RADIUS;
    CGPathMoveToPoint(path, NULL, p.x, p.y);
    
    p.x += _PAN_UPPDER_WIDTH;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y += _PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 _PAN_UPPER_RADIUS,
                 3.0 * M_PI / 2.0,
                 4.0 * M_PI / 2.0,
                 false);
    
    p.x += _PAN_UPPER_RADIUS;
    p.y += _PAN_UPPER_HEIGHT - _PAN_UPPER_RADIUS - _PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y + _PAN_CURVE_SIZE);
    switch (kind)
    {
        case PKNumberPadViewImageLeft:
            p.x -= _PAN_UL_WIDTH * 2;
            break;
            
        case PKNumberPadViewImageInner:
            p.x -= _PAN_UL_WIDTH;
            break;
            
        case PKNumberPadViewImageRight:
            break;
    }
    
    p.y += _PAN_MIDDLE_HEIGHT + _PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y - _PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y += _PAN_LOWER_HEIGHT - _PAN_CURVE_SIZE - _PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x -= _PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 _PAN_LOWER_RADIUS,
                 4.0 * M_PI / 2.0,
                 1.0 * M_PI / 2.0,
                 false);
    
    p.x -= _PAN_LOWER_WIDTH;
    p.y += _PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y -= _PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 _PAN_LOWER_RADIUS,
                 1.0 * M_PI / 2.0,
                 2.0 * M_PI / 2.0,
                 false);
    
    p.x -= _PAN_LOWER_RADIUS;
    p.y -= _PAN_LOWER_HEIGHT - _PAN_LOWER_RADIUS - _PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y - _PAN_CURVE_SIZE);
    
    switch (kind)
    {
        case PKNumberPadViewImageLeft:
            break;
            
        case PKNumberPadViewImageInner:
            p.x -= _PAN_UL_WIDTH;
            break;
            
        case PKNumberPadViewImageRight:
            p.x -= _PAN_UL_WIDTH*2;
            break;
    }
    
    p.y -= _PAN_MIDDLE_HEIGHT + _PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y + _PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y -= _PAN_UPPER_HEIGHT - _PAN_UPPER_RADIUS - _PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x += _PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 _PAN_UPPER_RADIUS,
                 2.0*M_PI/2.0,
                 3.0*M_PI/2.0,
                 false);
    //----
    CGContextRef context;
    UIGraphicsBeginImageContext(CGSizeMake(_WIDTH,
                                           _HEIGHT));
    context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, _HEIGHT);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    // draw gradient
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGFloat components[] = {
        0.95f, 1.0f,
        0.85f, 1.0f,
        0.675f, 1.0f,
        0.8f, 1.0f};
    
    size_t count = sizeof(components) / (sizeof(CGFloat) * 2);
    
    CGRect frame = CGPathGetBoundingBox(path);
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = frame.origin;
    endPoint.y = frame.origin.y + frame.size.height;
    
    CGGradientRef gradientRef =
    CGGradientCreateWithColorComponents(colorSpaceRef, components, NULL, count);
    
    CGContextDrawLinearGradient(context,
                                gradientRef,
                                startPoint,
                                endPoint,
                                kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIGraphicsEndImageContext();
    
    CFRelease(path);
    
    return imageRef;
}


#pragma mark -
#pragma mark textView get/set方法
- (void)setTextView:(id<UITextInput>)textView
{
	if ([textView isKindOfClass:[UITextView class]])
    {
//        self.systemInputView = ((UITextView *)textView).inputView;
        [(UITextView *)textView setInputView:self];
    }
    else if ([textView isKindOfClass:[UITextField class]])
    {
//        self.systemInputView = ((UITextField *)textView).inputView;
        [(UITextField *)textView setInputView:self];
    }
    
    _textView = textView;
}

- (id<UITextInput>)textView
{
	return _textView;
}


#pragma mark -
#pragma mark 获取随机数组
/*
 * @功能:将数组打乱顺序
 * @param:
 *      charactersArray:要打乱顺序的数组
 */
- (NSMutableArray *)randomCharactersArrayWithArray:(NSArray *)charactersArray
{
    NSMutableArray *pickedMtbArray = [[[NSMutableArray alloc] init] autorelease];
    int remaining = [charactersArray count];
    
    if ([charactersArray count] >= remaining)
    {
        while (remaining > 0)
        {
            id character = [charactersArray objectAtIndex:arc4random() % [charactersArray count]];
            if (![pickedMtbArray containsObject:character])
            {
                [pickedMtbArray addObject:character];
                remaining--;
            }
        }
    }
    
    return pickedMtbArray;
}

@end
