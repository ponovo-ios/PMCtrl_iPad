//
//  BD_HardwarkConfigModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/21.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HardwarkConfigModel.h"

@implementation BD_HardwarkConfigModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _deviceType = BDDeviceType_Imitate;
        _voltagePassNum = 6;
        _currentPassNum = 6;
        _exchangeVoltage = @"120.000";
        _exchangeCurrent = @"20.000";
        _directVoltage = kTStrings(sqrt(2)*120.000);
        _directCurrent = @"10.000";
        _assistCurrent = @"300.000";
        }
    return self;
}
@end
