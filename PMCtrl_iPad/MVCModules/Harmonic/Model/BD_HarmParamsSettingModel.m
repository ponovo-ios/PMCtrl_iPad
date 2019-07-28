//
//  BD_HarmParamsSettingModel.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmParamsSettingModel.h"

@implementation BD_HarmParamsSettingModel

-(instancetype)init
{
    if (self = [super init]) {
        _type = @"模拟";
        _channelSelection = @"4U3I";
        _acVoltage = @"120.000";
        _acCurrent = @"20.000";
        _dcVoltage = @"169.706";
        _dcCurrent = @"10.000";
    }
    return self;
}

@end
