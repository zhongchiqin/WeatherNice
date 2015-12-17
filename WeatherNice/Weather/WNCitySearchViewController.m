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

{
    UIImageView *_zoomImageView;//变焦图片做底层
    UICollectionView *collectionView;
    UITableView *  _tableView;
    UITextField * _searchTextField;

}

@end
static NSString * const Identifier = @"Identifier";
#define ImageHight 200.f

@implementation WNCitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

    [self creatTableView];
}


- (void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 200;
    _tableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
    _zoomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    _zoomImageView.frame = CGRectMake(0, -ImageHight, WScreenWidth , ImageHight);
    _zoomImageView.userInteractionEnabled = YES;
    //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    [_tableView addSubview:_zoomImageView];
    //设置autoresizesSubviews让子类自动布局
    _zoomImageView.autoresizesSubviews = YES;
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    UIWindow *window = delegate.window;
//    LeftSlideViewController *leftController = (LeftSlideViewController *)window.rootViewController;
//    [leftController setEditing:YES];
    WNButton *close = [WNButton creatButtonWithFrame:CGRectMake(20, 20, 40, 40) Title:nil BackgoundImage:[UIImage imageNamed:@"weather_ad_close"] State:UIControlStateNormal Action:^(UIButton *sender) {
        
        //        [leftController closeLeftView];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    [_zoomImageView addSubview:close];
    
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake((WScreenWidth-250)/2, ImageHight - 40, 250, 40)];
    _searchTextField.layer.borderWidth = 0.5;
    _searchTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _searchTextField.layer.cornerRadius = 20;
    _searchTextField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_zoomImageView addSubview:_searchTextField];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, ImageHight - 90, WScreenWidth, 40)];
    label.text = @"你来过，我记得，便是永远。";
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:23];
    label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_zoomImageView addSubview:label];
   
    //设置autoresizesSubviews让子类自动布局
    _zoomImageView.autoresizesSubviews = YES;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.textLabel.text = @"frewg";
    return cell;

}


@end
