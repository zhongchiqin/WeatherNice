//
//  WNRequest.m
//  WeatherNice
//
//  Created by LeYuan on 15/12/2.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNRequest.h"
#import <AFNetworking.h>

@implementation WNRequest
/*
 基于AF
 完成网络请求
 网址
 请求完成时的回调
 请求失败时的回调
 **/
 
+ (void)requestWithUrl:(NSString *)urlString Complete:(CompleteBlock)success Fail:(FailtureBlock)failture
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failture(error);
    }];
}

/*
 百度APIStore接口
 网址
 参数
 请求完成时的回调
 请求失败时的回调
 **/
+ (void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg Complete:(CompleteBlock)success fail:(FailtureBlock)failture;
{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"51c3a9bb615099801494c0fe656fe154" forHTTPHeaderField: @"apikey"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failture(error);
        }else{
            success(data);;
        }    }];
    [dataTask resume];

//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (connectionError) {
//            failture(connectionError);
//        }else{
//            success(data);;
//        }
//    }];
    
    
}
@end
