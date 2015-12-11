//
//  WNNow.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/10.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNNow : NSObject
/*
 "now": { //实况天气
 "cond": { //天气状况
 "code": "100", //天气状况代码
 "txt": "晴" //天气状况描述
 },
 "fl": "30", //体感温度
 "hum": "20%", //相对湿度（%）
 "pcpn": "0.0", //降水量（mm）
 "pres": "1001", //气压
 "tmp": "32", //温度
 "vis": "10", //能见度（km）
 "wind": { //风力风向
 "deg": "10", //风向（360度）
 "dir": "北风", //风向
 "sc": "3级", //风力
 "spd": "15" //风速（kmph）
 }
 },
 **/

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *fl;
@property (nonatomic, copy) NSString *hum;
@property (nonatomic, copy) NSString *pcpn;
@property (nonatomic, copy) NSString *pres;
@property (nonatomic, copy) NSString *tmp;
@property (nonatomic, copy) NSString *vis;
@property (nonatomic, strong) NSDictionary *cond;
@property (nonatomic, strong) NSDictionary *wind;




@end
