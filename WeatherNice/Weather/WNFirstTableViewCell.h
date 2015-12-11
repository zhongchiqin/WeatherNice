//
//  WNFirstTableViewCell.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/10.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNFirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *AqiLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *TxtLable;
@property (weak, nonatomic) IBOutlet UILabel *FlLale;
@property (weak, nonatomic) IBOutlet UILabel *WindLable;
@property (weak, nonatomic) IBOutlet UILabel *HumLable;

- (void)creatfirstCellWithDict:(NSDictionary *)dict;

@end
