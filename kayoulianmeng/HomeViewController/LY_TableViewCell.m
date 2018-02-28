//
//  TableViewCell.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/1/29.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "LY_TableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LY_TableViewCell

- (void)initCellWithImage:(NSURL *)imageURL withTitle:(NSString *)title  withClassify:(NSString *)classify withCommentNum:(NSInteger)commentNum isHeadLine:(BOOL)isHeadLine{
    
    _urlImageView_1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, Screen_Width*0.22, Screen_Width*0.147)];
    [_urlImageView_1 sd_setImageWithURL:imageURL];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width*0.22+24, 10, Screen_Width-Screen_Width*0.22-36, MAXFLOAT)];
//    _title.backgroundColor = [UIColor lightGrayColor];
    _title.text = title;
    _title.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(10.6)];
    _title.numberOfLines = 0;
    CGRect frameNew = [self.title.text boundingRectWithSize:CGSizeMake(Screen_Width-Screen_Width*0.22-36, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.title.font} context:nil];  // 指定为width，通常都是控件的width都是固定调整height
    _title.frame = frameNew;
    CGRect tempRect = _title.frame;
    tempRect.origin.x = Screen_Width*0.22+24;
    tempRect.origin.y = 10;
    _title.frame = tempRect;
    
    _classify = [[UILabel alloc] initWithFrame: CGRectMake(Screen_Width*0.22+24, Screen_Width*0.147-Screen_Width*0.0249+10, Screen_Width*0.22, Screen_Width*0.0249)];
//    _classify.backgroundColor = [UIColor lightGrayColor];
    _classify.text = classify;
    _classify.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(8)];
    _classify.textColor = [UIColor grayColor];
    
    if (isHeadLine) {
        UIImageView *headlineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-Screen_Width/68*5-12, Screen_Width*0.147-Screen_Width/136*5+10, Screen_Width/68*5, Screen_Width/136*5)];
        headlineImageView.image = [UIImage imageNamed:@"headline@2x.png"];
        [self addSubview:headlineImageView];
    }else{
        _palyNumAndCommentNum = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-12, Screen_Width*0.147-Screen_Width*0.0249+10, Screen_Width/2, Screen_Width*0.0249)];
        _palyNumAndCommentNum.text = [NSString stringWithFormat:@"%zd评论",commentNum];
        _palyNumAndCommentNum.textColor = [UIColor grayColor];
        _palyNumAndCommentNum.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(8)];
        _palyNumAndCommentNum.textAlignment = NSTextAlignmentRight;
        [self addSubview:_palyNumAndCommentNum];
    }
    
    [self addSubview:_urlImageView_1];
    [self addSubview:_title];
    [self addSubview:_classify];
//    return self;
}

- (void)initCellWithImageGroup:(NSArray *)imageArray withTitle:(NSString *)title  withClassify:(NSString *)classify withCommentNum:(NSInteger)commentNum isHeadLine:(BOOL)isHeadLine{
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, Screen_Width-24, MAXFLOAT)];
//    _title.backgroundColor = [UIColor lightGrayColor];
    _title.text = title;
    _title.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(10.6)];
    _title.numberOfLines = 0;
    CGRect frameNew = [self.title.text boundingRectWithSize:CGSizeMake(Screen_Width-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.title.font} context:nil];  // 指定为width，通常都是控件的width都是固定调整height
    _title.frame = frameNew;
    CGRect tempRect = _title.frame;
    tempRect.origin.x = 12;
    tempRect.origin.y = 10;
    _title.frame = tempRect;
    
    _urlImageView_1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, _title.frame.size.height+20, (Screen_Width-34)/3, (Screen_Width-34)/9*2)];
    NSURL *url_1 = [NSURL URLWithString:imageArray[0]];
    [_urlImageView_1 sd_setImageWithURL:url_1];
    
    _urlImageView_2 = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-34)/3+17, _title.frame.size.height+20, (Screen_Width-34)/3, (Screen_Width-34)/9*2)];
    NSURL *url_2 = [NSURL URLWithString:imageArray[1]];
    [_urlImageView_2 sd_setImageWithURL:url_2];
    
    _urlImageView_3 = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-34)/3*2+22, _title.frame.size.height+20, (Screen_Width-34)/3, (Screen_Width-34)/9*2)];
    NSURL *url_3 = [NSURL URLWithString:imageArray[2]];
    [_urlImageView_3 sd_setImageWithURL:url_3];
    
    _classify = [[UILabel alloc] initWithFrame: CGRectMake(12, frameNew.size.height + (Screen_Width-34)/9*2 + 30, Screen_Width*0.22, Screen_Width*0.0249)];
//    _classify.backgroundColor = [UIColor lightGrayColor];
    _classify.text = classify;
    _classify.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(8)];
    _classify.textColor = [UIColor grayColor];
    
    if (isHeadLine) {
        UIImageView *headlineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-Screen_Width/68*5-12, frameNew.size.height + (Screen_Width-34)/9*2 + 30, Screen_Width/68*5, Screen_Width/136*5)];
        headlineImageView.image = [UIImage imageNamed:@"headline@2x.png"];
        [self addSubview:headlineImageView];
    }else{
        _palyNumAndCommentNum = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-12, frameNew.size.height + (Screen_Width-34)/9*2 + 30, Screen_Width/2, Screen_Width*0.0249)];
        _palyNumAndCommentNum.text = [NSString stringWithFormat:@"%zd评论",commentNum];
        _palyNumAndCommentNum.textColor = [UIColor grayColor];
        _palyNumAndCommentNum.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(8)];
        _palyNumAndCommentNum.textAlignment = NSTextAlignmentRight;
        [self addSubview:_palyNumAndCommentNum];
    }
    
    [self addSubview:_urlImageView_1];
    [self addSubview:_urlImageView_2];
    [self addSubview:_urlImageView_3];
    [self addSubview:_title];
    [self addSubview:_classify];
    
//    return self;
}

- (void)initCellVideoWithImage:(NSURL *)imageurl withTitle:(NSString *)title  withClassify:(NSString *)classify withPlayNum:(NSInteger)playNum  withCommentNum:(NSInteger)commentNum isBigView:(BOOL)isBigView{
    
    if (isBigView) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, Screen_Width-24, MAXFLOAT)];
        //    _title.backgroundColor = [UIColor lightGrayColor];
        _title.text = title;
        _title.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(10.6)];
        _title.numberOfLines = 0;
        CGRect frameNew = [self.title.text boundingRectWithSize:CGSizeMake(Screen_Width-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.title.font} context:nil];  // 指定为width，通常都是控件的width都是固定调整height
        _title.frame = frameNew;
        CGRect tempRect = _title.frame;
        tempRect.origin.x = 12;
        tempRect.origin.y = 10;
        _title.frame = tempRect;
        
        _urlImageView_1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, _title.frame.size.height+20, (Screen_Width-24), (Screen_Width-24)/3*2)];
        [_urlImageView_1 sd_setImageWithURL:imageurl];
        
        _urlImageView_2 = [[UIImageView alloc] initWithFrame:CGRectMake(((Screen_Width-24)- (Screen_Width-24)/7)/2, ((Screen_Width-24)/3*2- (Screen_Width-24)/7)/2, (Screen_Width-24)/7, (Screen_Width-24)/7)];

        _urlImageView_2.image = [UIImage imageNamed:@"paly@2x.png"];
        [_urlImageView_1 addSubview:_urlImageView_2];
        
        [self addSubview:_title];
        [self addSubview:_urlImageView_1];
        
    }else{
        
    }
    
//    return self;
}
- (void)initCellWithNoData{
    _urlImageView_1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, Screen_Width*0.22, Screen_Width*0.147)];
    _urlImageView_1.backgroundColor = UIColorWithRGB(238, 238, 238, 1);
    _urlImageView_1.layer.cornerRadius = 3;
    
    NSInteger random = arc4random() % 2;
    NSInteger width = arc4random() % 10;
    if (random) {
        _urlImageView_2 = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width*0.22+24, 10, Screen_Width-Screen_Width*0.22-36, kFontSize(20/1.5))];
        _urlImageView_2.backgroundColor = UIColorWithRGB(238, 238, 238, 1);
        _urlImageView_2.layer.cornerRadius = 3;
        _urlImageView_3 = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width*0.22+24, 14 + kFontSize(20/1.5), width * 20, kFontSize(20/1.5))];
        _urlImageView_3.backgroundColor = UIColorWithRGB(238, 238, 238, 1);
        _urlImageView_3.layer.cornerRadius = 3;
        [self addSubview:_urlImageView_3];
        NSLog(@"YES");
    }else{
        if (width >5) {
            _urlImageView_2 = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width*0.22+24, 10, width * 30, kFontSize(20/1.5))];
            _urlImageView_2.backgroundColor = UIColorWithRGB(238, 238, 238, 1);
            _urlImageView_2.layer.cornerRadius = 3;
            NSLog(@"YES2");
        }else{
            _urlImageView_2 = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width*0.22+24, 10, Screen_Width-Screen_Width*0.22-36, kFontSize(20/1.5))];
            _urlImageView_2.backgroundColor = UIColorWithRGB(238, 238, 238, 1);
            _urlImageView_2.layer.cornerRadius = 3;
            NSLog(@"YES3");
        }
    }
    
    _classify = [[UILabel alloc] initWithFrame: CGRectMake(Screen_Width*0.22+24, Screen_Width*0.147-Screen_Width*0.0249+10, Screen_Width*0.15, Screen_Width*0.0249)];
    _classify.backgroundColor = UIColorWithRGB(238, 238, 238, 1);
    _classify.layer.cornerRadius = 3;

    _palyNumAndCommentNum = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-Screen_Width/5 -12, Screen_Width*0.147-Screen_Width*0.0249+10, Screen_Width/5, Screen_Width*0.0249)];
    _palyNumAndCommentNum.backgroundColor = UIColorWithRGB(238, 238, 238, 1);
    _palyNumAndCommentNum.layer.cornerRadius = 3;
    
    [self addSubview:_urlImageView_1];
    [self addSubview:_urlImageView_2];
    [self addSubview:_classify];
    [self addSubview:_palyNumAndCommentNum];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
