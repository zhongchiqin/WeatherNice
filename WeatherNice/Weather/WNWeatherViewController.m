//
//  WNWeatherViewController.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/2.
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
#import "WNButton.h"

static NSString * const Identifier1 = @"Identifier1";
static NSString * const Identifier2 = @"Identifier2";
static NSString * const Identifier3 = @"Identifier3";
static NSString * const Identifier4 = @"Identifier4";
static NSString * const Identifier5 = @"Identifier5";
static NSString * const Identifier6 = @"Identifier6";

@interface WNWeatherViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UITableView *           _tableView;
    NSMutableArray *        _dataArray;
    NSMutableDictionary *   _dict;
    NSString *              _city;
    WNButton *              centerButton;
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
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"account_bg@2x"];
    [self.view addSubview:imageView];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self creatNavigationBarButton];
    _dataArray = [[NSMutableArray alloc]init];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"array"] == nil) {
        _cityStr = @"beijing";
    }else{
        NSArray *arr = [ud objectForKey:@"array"];
        _dataArray = [NSMutableArray arrayWithArray:arr];
        _cityStr = [arr objectAtIndex:arr.count-1];
        NSLog(@"+++++%@",_cityStr);
         _cityStr = [self chineseCharactersIntoPinyinWithCityname:_cityStr];
    }
    [self creatDataSourceWithHttpArg:_cityStr];
    [self addNotification];
    [self creatTableView];
    
}
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDateTitle:) name:@"CitySearchViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData:) name:@"sendStr" object:nil];
}
- (void)reloadData:(NSNotification *)nc
{
    NSDictionary * dict = nc.userInfo;
    NSString *cityStr = [self chineseCharactersIntoPinyinWithCityname:dict[@"cityStr"]];
    NSLog(@"%@",cityStr);
    if (dict[@"cityStr"]) {
        [self creatDataSourceWithHttpArg:cityStr];
    }
}
- (void)upDateTitle:(NSNotification *)nc
{
    NSDictionary * dict = nc.userInfo;
    NSString *cityStr = [self chineseCharactersIntoPinyinWithCityname:dict[@"cityName"]];
    NSLog(@"%@",cityStr);
    if (dict[@"cityName"]) {
        [self creatDataSourceWithHttpArg:cityStr];
    }
}

#pragma mark---------将汉字转化成拼音（数据请求用到拼音）
- (NSString *)chineseCharactersIntoPinyinWithCityname:(NSString *)cityName{
    //把汉字装换成拼音
    NSString * st = [[NSMutableString alloc]init];
    if ([cityName length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:cityName];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            
            //ms为汉字转换成拼音  但是有空格  还要剔除空格
            NSString *str = ms;
            for (int i = 0; i < str.length; i++) {
                unichar c = [str characterAtIndex:i];
                if (c>='a'&&c<='z') {
                    st = [NSMutableString stringWithFormat:@"%@%c",st,c];
                }
            }
        }
    }
    return st;

}

- (void)creatNavigationBarButton
{
    AppDelegate *appdalegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIWindow * window = appdalegate.window;
    LeftSlideViewController * lsv = (LeftSlideViewController *)window.rootViewController;
    WNButton *leftButton = [WNButton creatButtonWithType:UIButtonTypeCustom Title:@"" BackgoundImage:[UIImage imageNamed:@"ws_search@2x"] State:UIControlStateNormal Action:^(UIButton *sender) {
        [lsv openLeftView];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    WNButton *rigthButon = [WNButton creatButtonWithType:UIButtonTypeCustom Title:@"" BackgoundImage:[UIImage imageNamed:@"right_button_share@2x"] State:UIControlStateNormal Action:^(UIButton *sender) {
        NSLog(@"分享");
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rigthButon];
 
}
//返回手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count>1) {
        return YES;
    }
    return NO;
}

- (void)creatDataSourceWithHttpArg:(NSString *)httpArg
{
    NSString *httpUrl = @"http://apis.baidu.com/heweather/weather/free";
//    httpArg = @"city=beijing";
    _dict = [[NSMutableDictionary alloc]init];
    NSString *str = [NSString stringWithFormat:@"city=%@",httpArg];
    [WNRequest request:httpUrl withHttpArg:str Complete:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            _dict = dict[@"HeWeather data service 3.0"][0];
            
            if ([_dict[@"status"]isEqualToString:@"ok"]) {
                
                [_tableView reloadData];
                NSLog(@"%@",_dict);
                _city = _dict[@"basic"][@"city"];
                if ([_dataArray containsObject:_city]) {
                    
                }else{
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [_dataArray addObject:_city];
                    [userDefaults setObject:_dataArray forKey:@"array"];
                    [userDefaults synchronize];
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendArray" object:nil userInfo:@{@"array":_dataArray}];
                    
                }
                AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                UIWindow * window = appdelegate.window;
                LeftSlideViewController * lsv = (LeftSlideViewController *)window.rootViewController;
                centerButton = [WNButton creatButtonWithType:UIButtonTypeCustom Title:_city BackgoundImage:nil State:UIControlStateNormal Action:^(UIButton *sender) {
                    [lsv openLeftView];
                }];
                self.navigationItem.titleView = centerButton;
            }else{
                NSLog(@"失败");
                UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"查无此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }
            
        });
    } fail:^(NSError *error) {
        NSLog(@"==========%@",error);
        
    }];
}

- (void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight-64-49)];
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
        cell.textLabel.textColor = [UIColor whiteColor];
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
        cell.textLabel.textColor = [UIColor whiteColor];
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
