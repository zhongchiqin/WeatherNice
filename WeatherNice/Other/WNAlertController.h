//
//  WNAlertController.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/9.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CancleBlock)(UIAlertAction *cancle);
typedef void(^DefineBlock)(UIAlertAction *define);

@interface WNAlertController : UIAlertController

- (void)showAlertInViewController:(UIViewController *)controller withTitle:(NSString *)title Message:(NSString *)messege ActionTitle1:(NSString *)actionTitle1 ActionTitle2:(NSString *)actionTitle2 Cancle:(CancleBlock)cancle Define:(DefineBlock)define;

@end
