//
//  YHSBackHomeDataUtil.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/3.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSBackHomeDataUtil : NSObject


#pragma mark - N001.到家请求数据
+ (NSString *)getBackHomeMainRequestURLString;
#pragma mark - N001.到家请求数据
+ (NSMutableDictionary *)getBackHomeMainRequestParams;



#pragma mark - N002.到家分类详情请求数据
+ (NSString *)getBackHomeCateDetailRequestURLString;
#pragma mark - N002.到家分类详情请求数据
+ (NSMutableDictionary *)getBackHomeCateDetailRequestParams;




@end
