//
//  NewsItem.h
//  ZhihuDaily
//
//  Created by 孤岛 on 16/9/19.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject
@property(nonatomic,strong) NSString * newsid;
@property(nonatomic,strong) NSString * newstitle;
@property(nonatomic,strong) NSString * newsimage;
@property(nonatomic,strong) NSString * date;
@end
