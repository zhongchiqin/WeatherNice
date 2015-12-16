//
//  WNCitySearchViewController.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/16.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNCitySearchViewController.h"
#import "WNButton.h"
#import "LeftSlideViewController.h"
#import "AppDelegate.h"
@interface WNCitySearchViewController ()

@end

@implementation WNCitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    LeftSlideViewController *leftController = (LeftSlideViewController *)window.rootViewController;
    [leftController setEditing:YES];
    WNButton *close = [WNButton creatButtonWithFrame:CGRectMake(20, 20, 40, 40) Title:nil BackgoundImage:[UIImage imageNamed:@"weather_ad_close"] State:UIControlStateNormal Action:^(UIButton *sender) {
        
//        [leftController closeLeftView];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    [self.view addSubview:close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
