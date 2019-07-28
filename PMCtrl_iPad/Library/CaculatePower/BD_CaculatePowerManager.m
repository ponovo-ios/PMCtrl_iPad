//
//  BD_CaculatePowerManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_CaculatePowerManager.h"
#import "BD_TestDataParamModel.h"
@implementation BD_CaculatePowerManager
+(float)getpowerElementWithVData:(BD_TestDataParamModel *)VData CData:(BD_TestDataParamModel *)CData{
    return cos([VData.phase doubleValue]-[CData.phase doubleValue]);
}
+(float)getActivePowerWithVData:(BD_TestDataParamModel *)VData CData:(BD_TestDataParamModel *)CData{
    float activepower = [VData.amplitude doubleValue]*[CData.amplitude doubleValue]*cos([VData.phase doubleValue]-[CData.phase doubleValue]);
    return activepower;
}
+(float)getReactivePowerWithVData:(BD_TestDataParamModel *)VData CData:(BD_TestDataParamModel *)CData{
    float reactivepower = [VData.amplitude doubleValue]*[CData.amplitude doubleValue]*sin([VData.phase doubleValue]-[CData.phase doubleValue]);
    return reactivepower;
}
+(float)getApparentPowerWithVData:(BD_TestDataParamModel *)VData CData:(BD_TestDataParamModel *)CData{
    float apparentpower = [VData.amplitude doubleValue]*[CData.amplitude doubleValue];
    return apparentpower;
    
}
@end
