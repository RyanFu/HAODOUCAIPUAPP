//
//  YHSCookBookToolsModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookToolsModel.h"

@implementation YHSCookBookToolsModel
- (NSString *)description
{
    return [NSString stringWithFormat:@"\n%@\n%@\n%@\n", _Title, _Img, _Url];
}
@end
