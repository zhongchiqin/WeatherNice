//
//  WNBarController.m
//  WeatherNice
//
//  Created by LeYuan on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNBarController.h"
#import "WNNavController.h"

@interface WNBarController ()

@end

@implementation WNBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTabBar];
}

-(void)creatTabBar
{
    self.tabBar.barTintColor = [UIColor blackColor];
    self.tabBar.translucent = YES;
    [self addController:@"WNWeatherViewController" WithTitle:@"天气" NormalImage:@"tabbar_weather_normal@2x" SelectImage:@"tabbar_weather_select@2x"];
    [self addController:@"WNSceneViewController" WithTitle:@"实景" NormalImage:@"tabbar_live_normal@2x" SelectImage:@"tabbar_live_select@2x"];
    [self addController:@"WNSelfViewController" WithTitle:@"我" NormalImage:@"tabbar_profile_normal@2x" SelectImage:@"tabbar_profile_select@2x"];
}

-(void)addController:(NSString *)controllerName WithTitle:(NSString *)title NormalImage:(NSString *)normalImageName SelectImage:(NSString *)selectImageName
{
    Class class = NSClassFromString(controllerName);
    UIViewController *controller = [[class alloc]init];
    controller.title = title;
    UIImage *normalImage = [[UIImage imageNamed:normalImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage = [[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:normalImage selectedImage:selectImage];
    WNNavController * nvc = [[WNNavController alloc]initWithRootViewController:controller];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [array addObject:nvc];
    self.viewControllers = array;
}



@end
