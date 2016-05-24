//
//  YHSRootViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSRootViewController.h"
#import "YHSBasicNavigationController.h"
#import "YHSCookBookMainViewController.h"
#import "YHSBackHomeMainViewController.h"
#import "YHSSquareMainViewController.h"
#import "YHSMineMainViewController.h"

@interface YHSRootViewController ()

@end

@implementation YHSRootViewController


#pragma mark 添加子控制器
- (void)addChildControllers
{
    // 菜谱
    [self addChildNavigationController:[YHSBasicNavigationController class]
                    rootViewController:[YHSCookBookMainViewController class]
                                 title:@"菜谱"
                       tabBarImageName:@"collect_normal"
                 tabBarSelectImageName:@"collect_pressed"];
    
    // 到家
    [self addChildNavigationController:[YHSBasicNavigationController class]
                    rootViewController:[YHSBackHomeMainViewController class]
                                 title:@"到家"
                       tabBarImageName:@"find_normal"
                 tabBarSelectImageName:@"find_pressed"];
    
    // 广场
    [self addChildNavigationController:[YHSBasicNavigationController class]
                    rootViewController:[YHSSquareMainViewController class]
                                 title:@"广场"
                       tabBarImageName:@"group_normal"
                 tabBarSelectImageName:@"group_pressed"];
    
    // 我的
    [self addChildNavigationController:[YHSBasicNavigationController class]
                    rootViewController:[YHSSquareMainViewController class]
                                 title:@"我的"
                       tabBarImageName:@"mine_normal"
                 tabBarSelectImageName:@"mine_pressed"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
