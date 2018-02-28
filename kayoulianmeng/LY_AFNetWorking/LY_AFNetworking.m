//
//  GetData.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/1/21.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "LY_AFNetworking.h"


@implementation LY_AFNetworking

//实现单例请求类对象

+(AFHTTPSessionManager *)shareManager;

{
    
    static AFHTTPSessionManager * manager;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager =[AFHTTPSessionManager manager];
        
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        manager.requestSerializer.timeoutInterval = 15.f;
        
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        
        
        
    });
    
    return manager;
    
}


+(AFHTTPSessionManager *)manager;

{
    
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    
    manager.securityPolicy.allowInvalidCertificates =true;
    
    
    return manager;
    
}


//创建get请求

+(void)LY_NetworkingForGET:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure;

{
    
    //字符串处理
    
    NSString * string =[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:URLString]];
    
//    [SVProgressHUD showWithStatus:@"数据加载中... "];
    
    //数据请求
    
    [[LY_AFNetworking shareManager]GET:string parameters:parameters progress:^(NSProgress *_Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) {
        
//        [SVProgressHUD dismiss];
        
        if (success) {
            
            // --- > 字典类型 --- > json数据 --- >解析数据并传值
            
            NSError * error =nil;
            
            if (error !=nil) {
                
//                [SVProgressHUD showErrorWithStatus:@"数据解析失败,请稍后尝试!"];
                
                return ;
                
            }
            
//            success(responseObject);
            
        }
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error) {
        
        
        
//        [SVProgressHUD showErrorWithStatus:@"请求数据失败,请检查网络后重试!"];
        
        if (failure) {
            
            failure(task,error);
            
        }
        
    }];
    
    
}

//创建post请求

+(void)LY_NetworkingForPOST:(nullable NSString *)URLString parameters:( nullable NSDictionary *)parameters success:(nullable void(^)(id _Nonnull json))success failure:(nullable void(^)(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error))failure;

{
    
    //字符串处理
    
    NSString * string =[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:URLString]];
    
//    [SVProgressHUD showWithStatus:@"数据加载中... "];
    
    
    [[LY_AFNetworking shareManager]POST:string parameters:parameters progress:^(NSProgress *_Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) {
        
//        [SVProgressHUD dismiss];
        
        if (success) {
            
            // --- > 字典类型 --- > json数据 --- >解析数据并传值

            NSError * error =nil;
            
            if (error !=nil) {
                
//                [SVProgressHUD showErrorWithStatus:@"数据解析失败,请稍后尝试!"];
                
                return ;
                
            }
            
            success(responseObject);
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error) {
        
        
        
//        [SVProgressHUD showErrorWithStatus:@"请求数据失败,请检查网络后重试!"];
        
        if (failure) {
            
            failure(task,error);
            
        }
        
    }];
    
}
@end
