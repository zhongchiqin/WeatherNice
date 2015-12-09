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

@interface WNWeatherViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation WNWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatTableView];
    [self creatDataSource];
}
-(void)creatDataSource
{
    NSString *httpUrl = @"http://apis.baidu.com/heweather/weather/free";
    NSString *httpArg = @"city=beijing";
    [WNRequest request:httpUrl withHttpArg:httpArg Complete:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dict:%@",dict);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight-64)];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

#pragma mark-------------tableViewDalegate----------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return WScreenHeight-64-49-150;
    }else if (indexPath.row == 1){
        return 150;
    }else if (indexPath.row == 2){
        return 30;
    }else if (indexPath.row == 3){
        return 300;
    }else
    return 320;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"hahha";
    return cell;

}
@end
