//
//  PublicDefine.h
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/1/7.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h


#define random_Color [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0]

#define UIColorWithRGB(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]

#define Screen_Width    [UIScreen mainScreen].bounds.size.width
#define Screen_Height    [UIScreen mainScreen].bounds.size.height
#define Status_Height   [[UIApplication sharedApplication] statusBarFrame].size.height
#define Navigation_Height   self.navigationController.navigationBar.frame.size.height



#define IsIphone5S          Screen_Width==320
#define SizeScale           (IsIphone5S ? 1 : 1.5)
#define kFontSize(value)    value*SizeScale
#define kFont(value)        [UIFont systemFontOfSize:value*SizeScale]

#endif /* PublicDefine_h */
