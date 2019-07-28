//
//  BD_HarmSwitchSettingModel.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmSwitchSettingModel.h"

@implementation BD_HarmSwitchSettingModel

-(instancetype)init
{
    if (self = [super init]) {
        _switchLogic = 0;//逻辑或
        _switchInArray = [NSMutableArray arrayWithObjects:@(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), nil];
        _switchOutArray = [NSMutableArray arrayWithObjects: @(NO), @(NO),  @(NO),  @(NO),  @(NO),  @(NO),  @(NO),  @(NO), nil];
        
        
    }
    return self;
}

//-(NSMutableArray *)switchInArray
//{
//    if (!_switchInArray) {
//        _switchInArray = [NSMutableArray arrayWithObjects:@"启动", @"未使用", @"未使用", @"未使用", @"未使用", @"未使用", @"未使用", @"未使用", @"未使用", @"未使用", nil];
//    }
//    return _switchInArray;
//}
//
//-(NSMutableArray *)switchOutArray
//{
//    if (!_switchOutArray) {
//        _switchOutArray = [NSMutableArray arrayWithObjects:@"打开", @"打开", @"打开", @"打开", @"打开", @"打开", @"打开", @"打开", nil];
//    }
//    return _switchOutArray;
//}


@end
