//
//  WNAlertController.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/9.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNAlertController.h"

@interface WNAlertController ()

@end

@implementation WNAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

}
- (void)showAlertInViewController:(UIViewController *)controller withTitle:(NSString *)title Message:(NSString *)messege ActionTitle1:(NSString *)actionTitle1 ActionTitle2:(NSString *)actionTitle2 Cancle:(CancleBlock)cancle Define:(DefineBlock)define;
{
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:title message:messege preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:actionTitle1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancle(action);
        
    }];
    UIAlertAction *defineAction = [UIAlertAction actionWithTitle:actionTitle2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        define(action);
    }];
    [alert addAction:cancleAction];
    [alert addAction:defineAction];
    [controller presentViewController:alert animated:YES completion:nil];
}


@end
