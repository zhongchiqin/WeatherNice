//
//  WNBasic.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/10.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNBasic : NSObject
/*
 "basic": {  //基本信息
 "city": "北京",  //城市名称
 "cnty": "中国",  //国家
 "id": "CN101010100",  //城市ID，参见http://www.heweather.com/documents/cn-city-list
 "lat": "39.904000",  //城市维度
 "lon": "116.391000",  //城市经度
 "update": {  //更新时间
 "loc": "2015-07-02 14:44", //当地时间
 "utc": "2015-07-02 06:46"  //UTC时间
 }
 },
 **/
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cnty;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, strong) NSDictionary *update;

@end
