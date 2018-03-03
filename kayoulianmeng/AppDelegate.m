//
//  AppDelegate.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/1/9.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ForumViewController.h"
#import "LogisticsViewController.h"
#import "NearbyViewController.h"
#import "MyViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    ForumViewController *forumVC = [[ForumViewController alloc]init];
    LogisticsViewController *LogisticsVC = [[LogisticsViewController alloc]init];
    NearbyViewController *nearbyVC = [[NearbyViewController alloc]init];
    MyViewController *myVC = [[MyViewController alloc]init];
    
//    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
//    UINavigationController *forunmNav = [[UINavigationController alloc]initWithRootViewController:forumVC];
//    UINavigationController *LogisticsNav = [[UINavigationController alloc]initWithRootViewController:LogisticsVC];
//    UINavigationController *nearbyNav = [[UINavigationController alloc]initWithRootViewController:nearbyVC];
//    UINavigationController *myNav = [[UINavigationController alloc]initWithRootViewController:myVC];
    //将Navigation储存在数组中
//    NSArray *array = @[homeNav,forunmNav,LogisticsNav,nearbyNav,myNav];
    NSArray *array = @[homeVC,forumVC,LogisticsVC,nearbyVC,myVC];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers=array;
    tabBarController.selectedIndex =0;
    
    UINavigationController *rootNavigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    
    //设置Bmob
    [Bmob registerWithAppKey:@"fc2b8f038ded90f95527e2bd39e63454"];
    
    //设置高德Key
    [AMapServices sharedServices].apiKey = @"卡友联盟-地图";
    
    //设置环信
    EMOptions *options = [EMOptions optionsWithAppkey:@"1128180204115107#kayoulianmeng"];
    options.apnsCertName = nil;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    EMError *error = [[EMClient sharedClient] initializeSDKWithOptions:options];
    if (!error) {
        NSLog(@"初始化成功");
    }
    
    
    
    self.window.rootViewController = rootNavigationController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {

    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application {
}




@end
