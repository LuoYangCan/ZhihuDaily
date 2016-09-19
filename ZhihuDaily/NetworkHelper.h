//
//  NetworkHelper.h
//  ZhihuDaily
//
//  Created by 孤岛 on 16/9/14.
//  Copyright © 2016年 孤岛. All rights reserved.
//
#import "AFNetworking.h"
#import <Foundation/Foundation.h>

@interface NetworkHelper : NSObject
+ (AFHTTPSessionManager *) ShareHttpManager;
@end
