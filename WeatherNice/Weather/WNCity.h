//
//  WNCity.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/10.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNCity : NSObject
/*
 "aqi": { //空气质量，仅限国内部分城市，国际城市无此字段
 "city": {
 "aqi": "30", //空气质量指数
 "co": "0", //一氧化碳1小时平均值(ug/m³)
 "no2": "10", //二氧化氮1小时平均值(ug/m³)
 "o3": "94", //臭氧1小时平均值(ug/m³)
 "pm10": "10", //PM10 1小时平均值(ug/m³)
 "pm25": "7", //PM2.5 1小时平均值(ug/m³)
 "qlty": "优", //空气质量类别
 "so2": "3" //二氧化硫1小时平均值(ug/m³)
 }
 },
 **/
@property (nonatomic, copy) NSString *aqi;
@property (nonatomic, copy) NSString *co;
@property (nonatomic, copy) NSString *no2;
@property (nonatomic, copy) NSString *o3;
@property (nonatomic, copy) NSString *pm25;
@property (nonatomic, copy) NSString *qlty;
@property (nonatomic, copy) NSString *so2;

@end
