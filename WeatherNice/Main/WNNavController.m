//
//  WNNavController.m
//  WeatherNice
//
//  Created by LeYuan on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNNavController.h"

@interface WNNavController ()

@end

@implementation WNNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.alpha = 0.5;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = dict;
    
}



@end
