//
//  WNSuggestion.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/10.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNSuggestion : NSObject
/*
 "suggestion": { //生活指数，仅限国内城市，国际城市无此字段
 "comf": { //舒适度指数
 "brf": "较不舒适", //简介
 "txt": "白天天气多云，同时会感到有些热，不很舒适。" //详细描述
 },
 "cw": { //洗车指数
 "brf": "较适宜",
 "txt": "较适宜洗车，未来一天无雨，风力较小，擦洗一新的汽车至少能保持一天。"
 },
 "drsg": { //穿衣指数
 "brf": "炎热",
 "txt": "天气炎热，建议着短衫、短裙、短裤、薄型T恤衫等清凉夏季服装。"
 },
 "flu": { //感冒指数
 "brf": "少发",
 "txt": "各项气象条件适宜，发生感冒机率较低。但请避免长期处于空调房间中，以防感冒。"
 },
 "sport": { //运动指数
 "brf": "较适宜",
 "txt": "天气较好，户外运动请注意防晒。推荐您进行室内运动。"
 },
 "trav": { //旅游指数
 "brf": "较适宜",
 "txt": "天气较好，温度较高，天气较热，但有微风相伴，还是比较适宜旅游的，不过外出时要注意防暑防晒哦！"
 },
 "uv": { //紫外线指数
 "brf": "中等",
 "txt": "属中等强度紫外线辐射天气，外出时建议涂擦SPF高于15、PA+的防晒护肤品，戴帽子、太阳镜。"
 }
 }
 }
 **/
@property (nonatomic, strong)NSDictionary *comf;
@property (nonatomic, strong)NSDictionary *cw;
@property (nonatomic, strong)NSDictionary *drsg;
@property (nonatomic, strong)NSDictionary *flu;
@property (nonatomic, strong)NSDictionary *sport;
@property (nonatomic, strong)NSDictionary *trav;
@property (nonatomic, strong)NSDictionary *uv;

@end
