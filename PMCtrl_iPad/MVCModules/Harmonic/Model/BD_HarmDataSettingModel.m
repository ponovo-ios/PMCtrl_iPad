//
//  BD_HarmDataSettingModel.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2018/1/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_HarmDataSettingModel.h"

@implementation BD_HarmDataSettingModel

-(instancetype)init
{
    if (self = [super init]) {
        _isAuto = NO;
        _channelPort = @"";
        _passagewayIndex = @"基波";
        _step = @"0.500";
        _time = @"0.500";
        _start = @"0.000";
        _end = @"10.000";
        _fre = @"50";
        _passageValue = @"";
        _containingRate = @"";
        _phase = @"";
    }
    return self;
}

@end
