//
//  WNRequest.h
//  WeatherNice
//
//  Created by LeYuan on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNRequest : NSObject

+(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg Complete:(void(^)(NSData *data))success fail:(void(^)(NSError *error))failture;

/*
 完成网络请求
 网址
 请求完成时的回调
 请求失败时的回调
 **/
+(void)requestWithUrl:(NSString *)urlString Complete:(void(^)(NSData *data))success Fail:(void (^)(NSError *))failture;
@end
