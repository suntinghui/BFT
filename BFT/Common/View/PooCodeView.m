//
//  PooCodeView.m
//  Code
//
//  Created by crazypoo on 14-4-14.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "PooCodeView.h"

@implementation PooCodeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor blueColor];

    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delete!=nil)
    {
        if ([self.delete respondsToSelector:@selector(CodeViewClicked)])
        {
            [self.delete CodeViewClicked];
        }
    }
    
}
- (void)setCodeString:(NSMutableString *)codeString
{
    _codeString = codeString;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
        float red = arc4random() % 100 / 100.0;
        float green = arc4random() % 100 / 100.0;
        float blue = arc4random() % 100 / 100.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//        [self setBackgroundColor:color];

        NSString *text = [NSString stringWithFormat:@"%@",self.codeString];
        CGSize cSize = [@"S" sizeWithFont:[UIFont systemFontOfSize:20]];
        int width = rect.size.width / text.length - cSize.width;
        int height = rect.size.height - cSize.height;
        CGPoint point;
    
        float pX, pY;
        for (int i = 0; i < text.length; i++)
        {
            pX = arc4random() % width + rect.size.width / text.length * i;
            pY = arc4random() % height;
            point = CGPointMake(pX, pY);
            unichar c = [text characterAtIndex:i];
            NSString *textC = [NSString stringWithFormat:@"%C", c];
            [textC drawAtPoint:point withFont:[UIFont systemFontOfSize:20]];
        }
    
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0);
        for(int cout = 0; cout < 20; cout++)
        {
            red = arc4random() % 100 / 100.0;
            green = arc4random() % 100 / 100.0;
            blue = arc4random() % 100 / 100.0;
            color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            CGContextSetStrokeColorWithColor(context, [color CGColor]);
            pX = arc4random() % (int)rect.size.width;
            pY = arc4random() % (int)rect.size.height;
            CGContextMoveToPoint(context, pX, pY);
            pX = arc4random() % (int)rect.size.width;
            pY = arc4random() % (int)rect.size.height;
            CGContextAddLineToPoint(context, pX, pY);
            CGContextStrokePath(context);
        }
}
@end
