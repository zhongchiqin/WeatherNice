//
//  WNFirstTableViewCell.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/10.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNFirstTableViewCell.h"
#import "WNAqi.h"
#import "WNCity.h"
#import "WNBasic.h"
#import "WNNow.h"
#import "WNSuggestion.h"
#import "WNDaily_forecast.h"
#import <MJExtension.h>


@implementation WNFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)creatfirstCellWithDict:(NSDictionary *)dict
{
    self.backgroundColor = [UIColor clearColor];
   
    WNAqi *aqi = [WNAqi objectWithKeyValues:dict[@"aqi"]];
    WNNow *now = [WNNow objectWithKeyValues:dict[@"now"]];
    WNBasic *basic = [WNBasic objectWithKeyValues:dict[@"basic"]];
    _AqiLable.text = aqi.city.aqi;
    _TxtLable.text = now.cond[@"txt"];
    _FlLale.text = now.fl;
    NSString *str = @"%";
    NSLog(@"%@",now.hum);
    if (now.hum == nil) {
        _HumLable.text = @"";
    }else{
    _HumLable.text = [NSString stringWithFormat:@"湿度%@%@",now.hum,str];
    }if (now.wind[@"dir"] == nil) {
        _WindLable.text = @"";
    }else{
    _WindLable.text = [NSString stringWithFormat:@"%@%@级",now.wind[@"dir"],now.wind[@"sc"]];
    }if (basic.update[@"loc"] == nil) {
        _TimeLable.text = @"";
    }else{
    _TimeLable.text = [NSString stringWithFormat:@"发布时间:%@",basic.update[@"loc"]];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
