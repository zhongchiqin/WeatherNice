//
//  WNAqi.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/10.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WNCity;
@interface WNAqi : NSObject
//"aqi": { //空气质量，仅限国内部分城市，国际城市无此字段
@property (nonatomic, strong) WNCity *city;

@end
