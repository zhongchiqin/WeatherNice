//
//  WNButton.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/16.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNButton.h"

typedef void(^Dotype) (WNButton *sender);

@implementation WNButton
{
    Dotype touch;
}
+ (instancetype)creatButtonWithType:(UIButtonType)type Title:(NSString *)title BackgoundImage:(UIImage *)image State:(UIControlState)state Action:(action)btn
{
    WNButton *button = [WNButton buttonWithType:type];
    button.frame = CGRectMake(0, 0, 35, 35);
    if (title) {
        [button setTitle:title forState:state];
    }
    if (image) {
        [button setBackgroundImage:image forState:state];
    }
    [button addTarget:button action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    button->touch = btn;
    return button;
}
+(WNButton *)creatButtonWithFrame:(CGRect)frame Title:(NSString *)title BackgoundImage:(UIImage *)image State:(UIControlState)state Action:(action)btn
{
    WNButton *button = [[WNButton alloc]initWithFrame:frame];
    if (title) {
        [button setTitle:title forState:state];
        [button setTitleColor:[UIColor blueColor] forState:state];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    if (image) {
        [button setBackgroundImage:image forState:state];
    }
    [button addTarget:button action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    button->touch = btn;
    return button;
}
-(void) click:(WNButton*)sender{
    //回调block，处理事件
    sender->touch(sender);
}
@end
