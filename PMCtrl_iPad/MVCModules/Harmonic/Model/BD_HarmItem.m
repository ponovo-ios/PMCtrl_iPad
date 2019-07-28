//
//  BD_HarmItem.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmItem.h"

@implementation BD_HarmItem

-(instancetype)init
{
    if (self = [super init]) {
        _containingRate = @"0.00";
        _validValues = @"0.000";
        _phase = @"0.0";
    }
    return self;
}

@end
