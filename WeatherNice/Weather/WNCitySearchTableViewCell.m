
//
//  WNCitySearchTableViewCell.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/17.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNCitySearchTableViewCell.h"
#import "AppDelegate.h"
#import "LeftSlideViewController.h"
#import "WNCitySearchViewController.h"
#import "WNWeatherViewController.h"

@implementation WNCitySearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatButton];
    }
    return self;
}

-(void)creatButton
{
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WScreenWidth, 40)];
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lable];
    
    NSArray *cityArray = @[@"北京",@"天津",@"上海",@"重庆",@"沈阳",@"大连",@"长春",@"哈尔滨",@"郑州",@"武汉",@"长沙",@"广州",@"深圳",@"南京",@"南昌"];
    int t = 0;
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(30+((WScreenWidth-120)/3+30)*j , 60+((200-60)/5+10)*i, (WScreenWidth-120)/3, (200-60)/5)];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:cityArray[t] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            button.layer.cornerRadius = 15;
            button.layer.borderWidth = 0.5;
            button.tag = 10 + t;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [button addTarget:self action:@selector(BuClick:)forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            t++;
        }
    }

}
- (void)BuClick:(UIButton *)send
{
    if (send.tag) {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        UIWindow *window = delegate.window;
        LeftSlideViewController *leftController = (LeftSlideViewController *)window.rootViewController;
        [leftController closeLeftView];
        [self postNotification:send.titleLabel.text];
        [self.vc dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)postNotification:(NSString *)cityName
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CitySearchViewController" object:nil userInfo:@{@"cityName":cityName}];
}

@end
