//
//  WNSecondTableViewCell.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/12.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNSecondTableViewCell.h"
#import <Masonry.h>

#import "WNAqi.h"
#import "WNCity.h"
#import "WNBasic.h"
#import "WNNow.h"
#import "WNSuggestion.h"
#import "WNDaily_forecast.h"
#import <MJExtension.h>

@implementation WNSecondTableViewCell
- (IBAction)today:(id)sender {
}

- (IBAction)tomorrow:(id)sender {
}

- (void)awakeFromNib {
    // Initialization code
     CGFloat padding = 0.0;
    [_today mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(padding);
        make.top.equalTo(self.contentView.mas_top).offset(padding);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(padding);
//        make.width.equalTo(_tomorrow.mas_width);
        make.width.equalTo(@[_tomorrow]);
    }];
    [_tomorrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_today.mas_right).offset(padding);
        make.top.equalTo(self.contentView.mas_top).offset(padding);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(padding);
        make.right.equalTo(self.contentView.mas_right).offset(padding);
    }];
    _today.layer.borderWidth = 1;
    _today.layer.borderColor = [UIColor whiteColor].CGColor;
    _tomorrow.layer.borderWidth = 1;
    _tomorrow.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [_todayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_today.mas_left).offset(padding);
        make.top.equalTo(_today.mas_top).offset(padding);
        make.size.equalTo(@[_todayFl,_todayTxt,_tomorrowFl,_tomorrowTxt,_tomorrowLable]);
    }];
    [_todayFl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_today.mas_top).offset(padding);
        make.left.equalTo(_todayLable.mas_right).offset(padding);
        make.right.equalTo(_today.mas_right).offset(padding);
        
    }];
    [_todayTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_today.mas_left).offset(padding);
        make.bottom.equalTo(_today.mas_bottom).offset(padding);
        make.top.equalTo(_todayLable.mas_bottom).offset(padding);
    }];
    [_tomorrowLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tomorrow.mas_top).offset(padding);
        make.left.equalTo(_tomorrow.mas_left).offset(padding);
    
    }];
    [_tomorrowFl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tomorrow.mas_top).offset(padding);
        make.left.equalTo(_tomorrowLable.mas_right).offset(padding);
        make.right.equalTo(_tomorrow.mas_right).offset(padding);
        
    }];
    [_tomorrowTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tomorrow.mas_left).offset(10);
        make.bottom.equalTo(_tomorrow.mas_bottom).offset(padding);
        make.top.equalTo(_tomorrowLable.mas_bottom).offset(padding);
    }];
    
    [_todayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat centerx = 0 - _today.frame.size.width/4;
        CGFloat centery = 0 + _today.frame.size.height/4;
        make.center.equalTo([NSValue valueWithCGPoint:CGPointMake(centerx, centery)]);
        make.width.equalTo(_today).dividedBy(4.0/1);
        make.height.equalTo(_tomorrowLable).dividedBy(1.0/1);
        make.size.equalTo(@[_tomorrowImage]);
    }];
    [_tomorrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat centerx = 0 + _tomorrow.frame.size.width/4*3;
        CGFloat centery = 0 + _tomorrow.frame.size.height/4;
        make.center.equalTo([NSValue valueWithCGPoint:CGPointMake(centerx+10, centery)]);
    }];
}
-(void)creatSecondCellWithDict:(NSDictionary *)dict
{
    
    NSArray *daily_forecast = [WNDaily_forecast objectArrayWithKeyValuesArray:dict[@"daily_forecast"]];
    WNDaily_forecast *today = daily_forecast[0];
    _todayTxt.text = today.cond[@"txt_n"];
    if (today.tmp[@"max"] == nil) {
        _todayFl.text = @"";
    }else{
    _todayFl.text = [NSString stringWithFormat:@"%@/%@°C",today.tmp[@"max"],today.tmp[@"min"]];
    }
    _todayImage.image = [[UIImage imageNamed:today.cond[@"code_n"]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    WNDaily_forecast *tomorrow = daily_forecast[1];
    if (tomorrow.tmp[@"max"] == nil) {
        _tomorrowFl.text = @"";
    }else{
    _tomorrowFl.text = [NSString stringWithFormat:@"%@/%@°C",tomorrow.tmp[@"max"],tomorrow.tmp[@"min"]];
    }
    _tomorrowTxt.text = tomorrow.cond[@"txt_n"];
    _tomorrowImage.image = [[UIImage imageNamed:tomorrow.cond[@"code_n"]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
