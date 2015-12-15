//
//  WNWeatherViewController.m
//  WeatherNice
//
//  Created by LeYuan on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNWeatherViewController.h"
#import "WNRequest.h"
#import <MJExtension.h>
#import "WNAqi.h"
#import "WNBasic.h"
#import "WNNow.h"
#import "WNCity.h"
#import "WNBasic.h"
#import "WNFirstTableViewCell.h"
#import "YWViewController.h"
#import "AppDelegate.h"
#import "LeftSlideViewController.h"
#import "WNSecondTableViewCell.h"
#import "WNTNThirdTableVIewCell.h"
#import "WNDaily_forecast.h"
#import "WNFourthTableViewCell.h"

static NSString * const Identifier1 = @"Identifier1";
static NSString * const Identifier2 = @"Identifier2";
static NSString * const Identifier3 = @"Identifier3";
static NSString * const Identifier4 = @"Identifier4";
static NSString * const Identifier5 = @"Identifier5";
static NSString * const Identifier6 = @"Identifier6";

@interface WNWeatherViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableDictionary *_dict;
}
@end

@implementation WNWeatherViewController

//把侧滑手势打开
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *appdalegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIWindow * window = appdalegate.window;
    LeftSlideViewController * lsv = (LeftSlideViewController *)window.rootViewController;
    [lsv setPanEnabled:YES];
}
//把侧滑手势关闭
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow * window = appdelegate.window;
    LeftSlideViewController * lsv = (LeftSlideViewController *)window.rootViewController;
    [lsv setPanEnabled:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"account_bg@2x"]];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self creatDataSource];
    [self creatTableView];
    
}

//返回手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count>1) {
        return YES;
    }
    return NO;
}

- (void)creatDataSource
{
    NSString *httpUrl = @"http://apis.baidu.com/heweather/weather/free";
    NSString *httpArg = @"city=beijing";
    _dict = [[NSMutableDictionary alloc]init];
    [WNRequest request:httpUrl withHttpArg:httpArg Complete:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _dict = dict[@"HeWeather data service 3.0"][0];
        NSLog(@"%@",_dict);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight-64)];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    UINib *firstNib = [UINib nibWithNibName:@"WNFirstTableViewCell" bundle:nil];
    [_tableView registerNib:firstNib forCellReuseIdentifier:Identifier1];
    UINib *secondNib = [UINib nibWithNibName:@"WNSecondTableViewCell" bundle:nil];
    [_tableView registerNib:secondNib forCellReuseIdentifier:Identifier2];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier3];
    UINib *thirdNib = [UINib nibWithNibName:@"WNTNThirdTableVIewCell" bundle:nil];
    [_tableView registerNib:thirdNib forCellReuseIdentifier:Identifier4];
    [_tableView registerClass:[WNFourthTableViewCell class] forCellReuseIdentifier:Identifier5];
    
}

#pragma mark-------------tableViewDalegate----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return WScreenHeight-64-49-100;
    }else if (indexPath.row == 1){
        return 100;
    }else if (indexPath.row == 2){
        return 30;
    }else if (indexPath.row == 3){
        return 300;
    }else if (indexPath.row == 4){
        return 30;
    }else
    return 320;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WNFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell creatFirstCellWithDict:_dict];
        return cell;
    }
    else if(indexPath.row == 1){
    WNSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier2];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell creatSecondCellWithDict:_dict];
        
         return cell;
    } else if(indexPath.row == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier3];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"七天预报";
        return cell;
    }else if(indexPath.row == 3){
        WNTNThirdTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier4];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell creatThirdCellWithDict:_dict];
        return cell;
    }else if(indexPath.row == 4){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier3];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"指数";
        return cell;
    }else {
        WNFourthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier5];
        [cell creatFourthCellWithDict:_dict];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YWViewController *wj = [[YWViewController alloc]init];
    [self.navigationController pushViewController:wj animated:YES];
    

}
@end
