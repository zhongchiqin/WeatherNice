//
//  WNConstant.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#ifndef WNConstant_h
#define WNConstant_h

//屏幕高度
#define WScreenWidth [UIScreen mainScreen].bounds.size.width

//屏幕宽度
#define WScreenHeight [UIScreen mainScreen].bounds.size.height


#define WNUserDefaults [NSUserDefaults standardUserDefaults]
#define Reqid @"array"
#define WNCityUD  [WNUserDefaults objectForKey:Reqid]

#define CityNameNoti @"CitySearchViewController"
#define SendStrNoti @"sendStr"
#define sendArrayNoti @"sendArray"

#endif /* WNConstant_h */
