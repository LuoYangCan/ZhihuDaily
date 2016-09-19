//
//  NetworkHelper.m
//  ZhihuDaily
//
//  Created by 孤岛 on 16/9/14.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "NetworkHelper.h"
static NSString * const shortMessages = @"http://news-at.zhihu.com/";
@implementation NetworkHelper

//- (NSURLSessionDataTask *)getUrlData:(NSURL *)url withParameters:(id)parameters Successful:(void (^) (NSDictionary *)) successful failure:(void (^) (NSString *)) failure{
//    if (url == nil) {
//        NSLog(@"valid url");
//        failure(@"valid url") ;
//    }
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:10.0];
//    
//    if (request == nil) {
//        NSLog(@"valid url");
//        failure(@"valid url");
//        }
//    [request setHTTPMethod:@"GET"];
//    NSURLSession *urlsession = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [urlsession dataTaskWithRequest:request];
//    [dataTask resume];
//    return dataTask;
//}
+ (AFHTTPSessionManager *) ShareHttpManager{
    static AFHTTPSessionManager * _shareClint = nil;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        _shareClint = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:shortMessages]];
    });
    return _shareClint ;
}

@end
