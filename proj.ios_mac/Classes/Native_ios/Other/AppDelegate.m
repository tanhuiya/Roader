//
//  AppDelegate.m
//  DianPing
//
//  Created by tanhui on 15/12/11.
//  Copyright © 2015年 tanhui. All rights reserved.
//

#import "AppDelegate.h"

#import "MTDealsViewController.h"
#import "MTNavigationController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsService.h"
#import "UMSocialData.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MTDealsViewController* dealVc=[[MTDealsViewController alloc]init];
    self.window.rootViewController=[[MTNavigationController alloc]initWithRootViewController:dealVc];
    [self.window makeKeyAndVisible];
    
    [self configureThirdSetting:launchOptions];
    
    return YES;
}
-(void)configureThirdSetting:(NSDictionary *)launchOptions{
    [UMSocialData openLog:YES];
    [UMSocialData setAppKey:UMKEY];
    [UMSocialWechatHandler setWXAppId:@"wx1fc78ae6cf0d7a1e" appSecret:@"2a8d80e4b2f50a3a28a4603c2ded31b9" url:@"http://www.umeng.com/social"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
