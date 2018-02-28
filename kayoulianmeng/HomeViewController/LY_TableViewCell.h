//
//  TableViewCell.h
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/1/29.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LY_TableViewCell : UITableViewCell
@property(nonatomic,strong,readonly) UIImageView *urlImageView_1;
@property(nonatomic,strong,readonly) UIImageView *urlImageView_2;
@property(nonatomic,strong,readonly) UIImageView *urlImageView_3;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *classify;
@property(nonatomic,strong) UILabel *palyNumAndCommentNum;

- (void)initCellWithImage:(NSURL *)imageurl withTitle:(NSString *)title  withClassify:(NSString *)classify withCommentNum:(NSInteger)commentNum isHeadLine:(BOOL)isHeadLine;

- (void)initCellWithImageGroup:(NSArray *)imageArray withTitle:(NSString *)title  withClassify:(NSString *)classify withCommentNum:(NSInteger)commentNum isHeadLine:(BOOL)isHeadLine;

- (void)initCellVideoWithImage:(NSURL *)imageurl withTitle:(NSString *)title  withClassify:(NSString *)classify withPlayNum:(NSInteger)playNum  withCommentNum:(NSInteger)commentNum isBigView:(BOOL)isBigView;
- (void)initCellWithNoData;

@end
