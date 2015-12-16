//
//  WNLeftViewController.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNLeftViewController.h"
#import "WNButton.h"
#import "WNCitySearchViewController.h"

static NSString * const Identifier = @"Identifier";
@interface WNLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation WNLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    [self creatNavView];
}

- (void)creatNavView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    WNButton *leftButton = [WNButton creatButtonWithFrame:CGRectMake(10, 15, 40, 40) Title:@"编辑" BackgoundImage:nil State:UIControlStateNormal Action:^(UIButton *sender) {
        NSLog(@"dsag");
    }];
    [view addSubview:leftButton];
    
    WNButton *rigthButton = [WNButton creatButtonWithFrame:CGRectMake(WScreenWidth - 60, 15, 40, 40) Title:@"" BackgoundImage:[UIImage imageNamed:@"left_drawer_add_city_normal"] State:UIControlStateNormal Action:^(UIButton *sender) {
        WNCitySearchViewController *search = [[WNCitySearchViewController alloc]init];
        [self presentViewController:search animated:YES completion:nil];
    }];
    [view addSubview:rigthButton];
}

- (void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(64, 64, WScreenWidth, WScreenHeight-64)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.textLabel.text = @"frwf";
    return cell;
}
@end
