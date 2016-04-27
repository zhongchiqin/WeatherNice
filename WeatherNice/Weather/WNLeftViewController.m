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
#import "LeftSlideViewController.h"
#import "WNWeatherViewController.h"
#import "AppDelegate.h"

static NSString * const Identifier = @"Identifier";

@interface WNLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *     _tableView;
    NSMutableArray *  _dataArray;
}
@end

@implementation WNLeftViewController
//#pragma mark-设置状态栏的样式
//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    //设置为白色
//    return UIStatusBarStyleLightContent;
//    //默认为黑色
////    return UIStatusBarStyleDefault;
//}
//#pragma mark-设置状态栏是否隐藏（否）
//-(BOOL)prefersStatusBarHidden
//{
//    return NO;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    [self creatTableView];
    [self creatNavView];
    [self addNotification];
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"array"]==nil) {
        [_dataArray addObject:@"北京"];
    }else{
        NSArray *arr = [ud objectForKey:@"array"];
        _dataArray = [NSMutableArray arrayWithArray:arr];
    }
    [_tableView reloadData];
}
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDateTitle:) name:@"sendArray" object:nil];
}

- (void)upDateTitle:(NSNotification *)nc
{
    NSDictionary * dict = nc.userInfo;
    if (dict[@"array"]) {
        _dataArray = [NSMutableArray arrayWithArray:dict[@"array"]];
        [_tableView reloadData];
    }
}

- (void)creatNavView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    WNButton *rigthButton = [WNButton creatButtonWithFrame:CGRectMake(WScreenWidth - 60, 15, 40, 40) Title:@"" BackgoundImage:[UIImage imageNamed:@"left_drawer_add_city_normal"] State:UIControlStateNormal Action:^(UIButton *sender) {
        WNCitySearchViewController *search = [[WNCitySearchViewController alloc]init];
        [self presentViewController:search animated:YES completion:nil];
    }];
    [view addSubview:rigthButton];
}
- (void)click:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_tableView setEditing:YES animated:YES];
    }else
        [_tableView setEditing:NO animated:YES];
}
-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(64, 64, WScreenWidth, WScreenHeight-64)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%@",_dataArray[indexPath.row]);
    NSString *str = _dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendStr" object:nil userInfo:@{@"cityStr":str}];
    AppDelegate * appdelegate = [[UIApplication sharedApplication] delegate];
    LeftSlideViewController * leftvc = (LeftSlideViewController *)appdelegate.window.rootViewController;
    [leftvc closeLeftView];
    
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *test1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:_dataArray forKey:@"array"];
        [_tableView reloadData];
        [ud synchronize];
        
    }];
    test1.backgroundColor = [UIColor redColor];
    return @[test1];
}
// 编辑状态下cell可以移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //sourceIndexPath 要被移动的cell的位置
    //destinationIndexPath 被移动到的位置
    NSLog(@"从(%ld), 到(%ld)", sourceIndexPath.row, destinationIndexPath.row);
    // 1;把要移动的数据取出来
    NSString *numberStr = [_dataArray objectAtIndex:sourceIndexPath.row];
    // 2;在数组的位置中移除
    [_dataArray removeObjectAtIndex:sourceIndexPath.row];
    // 3;再把它放到移动到的位置
    [_dataArray insertObject:numberStr atIndex:destinationIndexPath.row];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_dataArray forKey:@"array"];
    [_tableView reloadData];
    [ud synchronize];
}
@end
