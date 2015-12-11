//
//  WNRequest.h
//  WeatherNice
//
//  Created by LeYuan on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)(NSData *data);
typedef void(^FailtureBlock)(NSError *error);

@interface WNRequest : NSObject

/*
 百度APIStore接口
 网址
 参数
 请求完成时的回调
 请求失败时的回调
 **/
+ (void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg Complete:(CompleteBlock)success fail:(FailtureBlock)failture;

/*
 基于AF
 完成网络请求
 网址
 请求完成时的回调
 请求失败时的回调
 **/
+ (void)requestWithUrl:(NSString *)urlString Complete:(CompleteBlock)success Fail:(FailtureBlock)failture;
@end
