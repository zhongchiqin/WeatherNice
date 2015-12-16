//
//  WNButton.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/16.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^action)(UIButton *sender);

@interface WNButton : UIButton

+(WNButton *)creatButtonWithFrame:(CGRect)frame Title:(NSString *)title BackgoundImage:(UIImage *)image State:(UIControlState)state Action:(action)btn;

+ (instancetype)creatButtonWithType:(UIButtonType)type Title:(NSString *)title BackgoundImage:(UIImage *)image State:(UIControlState)state Action:(action)btn;

@end
