//
//  AppDelegate.m
//  WeatherNice
//
//  Created by LeYuan on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "AppDelegate.h"
#import "WNBarController.h"
#import "WNLeftViewController.h"
#import "WNWeatherViewController.h"
#import "LeftSlideViewController.h"
#import <UIKit+AFNetworking.h>
#import <AFNetworking.h>
#import "WNAlertController.h"

#define kThemeDidChangeNotification @"kThemeDidChangeNotification"

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    WNBarController *nvc = [[WNBarController alloc]init];
    [_window makeKeyAndVisible];
   //left控制器
    WNLeftViewController * leftController = [[WNLeftViewController alloc] init];
    LeftSlideViewController *left = [[LeftSlideViewController alloc] initWithLeftView:leftController andMainView:nvc];
    _window.rootViewController = left;
//    监听网络
    [self monitorUrl];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    
    return YES;
    
    
}

//监听网络
- (void)monitorUrl
{
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    NSURL *url = [NSURL URLWithString:@"http://baidu.com"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                [operationQueue setSuspended:NO];
                
                NSLog(@"有网络");
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            default:{

                [operationQueue setSuspended:YES];
                
                 NSLog(@"无网络");
                
                LeftSlideViewController * leftVC =(LeftSlideViewController *)self.window.rootViewController;
                WNAlertController *alertConrtoller = [[WNAlertController alloc]init];
                [alertConrtoller showAlertInViewController:leftVC withTitle:@"Reminder" Message:@"没有联网哦" ActionTitle1:@"知道啦" ActionTitle2:@"取消" Cancle:^(UIAlertAction *cancle) {
                    [alertConrtoller dismissViewControllerAnimated:YES completion:nil];
                } Define:^(UIAlertAction *define) {
                    [alertConrtoller dismissViewControllerAnimated:YES completion:nil];
                }];
                [leftVC presentViewController:alertConrtoller animated:YES completion:nil];
            
            }
                break;
        }
        
    }];
    
    /**
     *  开始监听
     */
    [manager.reachabilityManager startMonitoring];
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
