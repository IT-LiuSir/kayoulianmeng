//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * 🌟🌟🌟 新建SDCycleScrollView交流QQ群：185534916 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * 新浪微博:GSD_iOS
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios
 *
 * 另（我的自动布局库SDAutoLayout）：
 *  一行代码搞定自动布局！支持Cell和Tableview高度自适应，Label和ScrollView内容自适应，致力于
 *  做最简单易用的AutoLayout库。
 * 视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * 用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 * GitHub：https://github.com/gsdios/SDAutoLayout
 *********************************************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
    __weak UILabel *_mainTitleLabel;
    __weak UILabel *_subTitleLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
//        [self setupTitleLabel];
        [self setupMainTitleLabel];
        [self setupSubTitleLabel];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setMainTitleLabelBackgroundColor:(UIColor *)mainTitleLabelBackgroundColor{
    _mainTitleLabelBackgroundColor = mainTitleLabelBackgroundColor;
    _mainTitleLabel.backgroundColor = mainTitleLabelBackgroundColor;
}

- (void)setMainTitleLabelTextColor:(UIColor *)mainTitleLabelTextColor{
    _mainTitleLabelTextColor = mainTitleLabelTextColor;
    _mainTitleLabel.textColor = mainTitleLabelTextColor;
}

- (void)setMainTitleLabelTextFont:(UIFont *)mainTitleLabelTextFont{
    _mainTitleLabelTextFont = mainTitleLabelTextFont;
    _mainTitleLabel.font = mainTitleLabelTextFont;
}

- (void)setSubTitleLabelBackgroundColor:(UIColor *)subTitleLabelBackgroundColor{
    _subTitleLabelBackgroundColor = subTitleLabelBackgroundColor;
    _subTitleLabel.backgroundColor = subTitleLabelBackgroundColor;
}

- (void)setSubTitleLabelTextColor:(UIColor *)subTitleLabelTextColor{
    _subTitleLabelTextColor = subTitleLabelTextColor;
    _subTitleLabel.textColor = subTitleLabelTextColor;
}

- (void)setSubTitleLabelTextFont:(UIFont *)subTitleLabelTextFont{
    _subTitleLabelTextFont = subTitleLabelTextFont;
    _subTitleLabel.font = subTitleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
}

- (void)setTitleLabelTextAlignment:(NSTextAlignment)titleLabelTextAlignment
{
    _titleLabelTextAlignment = titleLabelTextAlignment;
    _titleLabel.textAlignment = titleLabelTextAlignment;
}

- (void)setupMainTitleLabel{
    UILabel *mainTitleLabel = [[UILabel alloc]init];
    _mainTitleLabel = mainTitleLabel;
    _mainTitleLabel.hidden = YES;
    [self.contentView addSubview:mainTitleLabel];
}

- (void)setMainTitle:(NSString *)mainTitle{
    _mainTitle = [mainTitle copy];
    NSMutableAttributedString *mainAttributedString = [[NSMutableAttributedString alloc] initWithString:mainTitle];
    NSMutableParagraphStyle *mainStyle = [[NSMutableParagraphStyle alloc] init];
    mainStyle.firstLineHeadIndent = 10;
    [mainAttributedString addAttribute:NSParagraphStyleAttributeName value:mainStyle range:NSMakeRange(0, mainTitle.length)];
    
    NSShadow *mainShadow = [[NSShadow alloc] init];
    mainShadow.shadowBlurRadius = 1.5;
    mainShadow.shadowOffset = CGSizeMake(1.5, 1.5);
    [mainAttributedString addAttribute:NSShadowAttributeName value:mainShadow range:NSMakeRange(0, mainTitle.length)];
    
    [mainAttributedString addAttribute:NSStrokeWidthAttributeName value:@-7 range:NSMakeRange(0, mainTitle.length)];
    
    _mainTitleLabel.attributedText = mainAttributedString;
    if (_mainTitleLabel.hidden) {
        _mainTitleLabel.hidden = NO;
    }
}

- (void)setMainTitleLabelTextAlignment:(NSTextAlignment)mainTitleLabelTextAlignment
{
    _mainTitleLabelTextAlignment = mainTitleLabelTextAlignment;
    _mainTitleLabel.textAlignment = mainTitleLabelTextAlignment;
}

- (void)setupSubTitleLabel{
    UILabel *subTitleLabel = [[UILabel alloc]init];
    _subTitleLabel = subTitleLabel;
    _subTitleLabel.hidden = YES;
    [self.contentView addSubview:subTitleLabel];
}

- (void)setSubTitle:(NSString *)subTitle{
    _subTitle = [subTitle copy];
    NSMutableAttributedString *subAttributedString = [[NSMutableAttributedString alloc] initWithString:subTitle];
    NSMutableParagraphStyle *subStyle = [[NSMutableParagraphStyle alloc] init];
    subStyle.firstLineHeadIndent = 10;
    [subAttributedString addAttribute:NSParagraphStyleAttributeName value:subStyle range:NSMakeRange(0, subTitle.length)];
    _subTitleLabel.attributedText = subAttributedString;
    if (_subTitleLabel.hidden) {
        _subTitleLabel.hidden = NO;
    }
}

- (void)setSubTitleLabelTextAlignment:(NSTextAlignment)subTitleLabelTextAlignment
{
    _subTitleLabelTextAlignment = subTitleLabelTextAlignment;
    _subTitleLabel.textAlignment = subTitleLabelTextAlignment;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat titleLabelW = self.sd_width;
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.sd_height - titleLabelH;
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
    
    if (self.onlyDisplayText) {
        _mainTitleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat mainTitleLabelW = self.sd_width;
        CGFloat mainTitleLabelH = _mainTitleLabelHeight;
        CGFloat mainTitleLabelX = 0;
        CGFloat mainTitleLabelY = self.sd_height - _subTitleLabelHeight - mainTitleLabelH;
        _mainTitleLabel.frame = CGRectMake(mainTitleLabelX, mainTitleLabelY, mainTitleLabelW, mainTitleLabelH);
    }
    
    if (self.onlyDisplayText) {
        _subTitleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat subTitleLabelW = self.sd_width;
        CGFloat subTitleLabelH = _subTitleLabelHeight;
        CGFloat subTitleLabelX = 0;
        CGFloat subTitleLabelY = self.sd_height - subTitleLabelH;
        _subTitleLabel.frame = CGRectMake(subTitleLabelX, subTitleLabelY, subTitleLabelW, subTitleLabelH);
    }
}

@end
