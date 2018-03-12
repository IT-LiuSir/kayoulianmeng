//
//  LY_CollectionViewCell.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/3/7.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "LY_CollectionViewCell.h"

@implementation LY_CollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置CollectionViewCell中的图像框
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(((Screen_Width -50)/4-40)/2, ((Screen_Width -50)/4-65)/2, 40, 40)];
        [self addSubview:self.imageView];
        //文本框
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, ((Screen_Width -50)/4-65)/2 + 50, CGRectGetWidth(self.frame), 15)];
//        self.label.backgroundColor = [UIColor greenColor];
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
    }
    return self;
}
@end
