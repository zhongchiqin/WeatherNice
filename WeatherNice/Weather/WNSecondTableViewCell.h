//
//  WNSecondTableViewCell.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/12.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNSecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *today;
@property (weak, nonatomic) IBOutlet UIButton *tomorrow;
@property (weak, nonatomic) IBOutlet UILabel *todayLable;
@property (weak, nonatomic) IBOutlet UILabel *todayFl;
@property (weak, nonatomic) IBOutlet UILabel *todayTxt;
@property (weak, nonatomic) IBOutlet UIImageView *todayImage;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowLable;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowFl;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowTxt;
@property (weak, nonatomic) IBOutlet UIImageView *tomorrowImage;


- (void)creatSecondCellWithDict:(NSDictionary *)dict;

@end
