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
- (void)creatFirstCellWithDict:(NSDictionary *)dict
{
    self.backgroundColor = [UIColor clearColor];
    WNAqi *aqi = [WNAqi objectWithKeyValues:dict[@"aqi"]];
    WNNow *now = [WNNow objectWithKeyValues:dict[@"now"]];
    WNBasic *basic = [WNBasic objectWithKeyValues:dict[@"basic"]];
    _AqiLable.text = aqi.city.aqi;
    _TxtLable.text = now.cond[@"txt"];
    _headImage.image = [[UIImage imageNamed:now.cond[@"code"]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (!dict.count) {
        _FlLale.text = @"";
        _HumLable.text = @"";
        _WindLable.text = @"";
        _TimeLable.text = @"";
    }else{
        NSString *str = @"%";
        _FlLale.text = [NSString stringWithFormat:@"%@°",now.tmp];
        _HumLable.text = [NSString stringWithFormat:@"湿度%@%@",now.hum,str];
        _WindLable.text = [NSString stringWithFormat:@"%@%@级",now.wind[@"dir"],now.wind[@"sc"]];
        _TimeLable.text = [NSString stringWithFormat:@"发布时间:%@",basic.update[@"loc"]];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
