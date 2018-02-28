//
//  BasicTextField.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/2/14.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "BasicTextField.h"

@implementation BasicTextField

//  重写leftView的X值
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}

//  重写占位符的x值
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    placeholderRect.origin.x += 1;
    return placeholderRect;
}

//  重写文字输入时的x值
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 20;
    return editingRect;
}

//  重写文字显示时的x值
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 20;
    return textRect;
}

@end
