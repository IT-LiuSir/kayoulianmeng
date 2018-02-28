//
//  GetData.h
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/1/21.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "AFNetworking.h"

@interface LY_AFNetworking : NSObject
/*
 
*  可配合SVProgressHUD设置loading
 
*  get请求  并通过block返回json数据

*  URLString  ----> 网络地址

*  parameters  ----> 参数请求体

*  success       ----> 请求成功

*  failure         ----> 请求失败
 
*/

//创建get请求

+(void)LY_NetworkingForGET:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure;


//创建post请求

+(void)LY_NetworkingForPOST:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure;

@end
