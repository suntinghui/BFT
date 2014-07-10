//
//  PooCodeView.h
//  Code
//
//  Created by crazypoo on 14-4-14.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CodeViewDelegate <NSObject>

- (void)CodeViewClicked;

@end

@interface PooCodeView : UIView
@property (nonatomic, retain) NSString *codeString;
@property (nonatomic, retain) UILabel *codeLabel;
@property (nonatomic, assign) id<CodeViewDelegate>delete;


@end
