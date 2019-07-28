//
//  BD_CaculatePowerManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BD_TestDataParamModel;
@interface BD_CaculatePowerManager : NSObject
/**功率因素*/
+(float)getpowerElementWithVData:(BD_TestDataParamModel *)VData CData:(BD_TestDataParamModel *)CData;
/**有功功率*/
+(float)getActivePowerWithVData:(BD_TestDataParamModel *)VData CData:(BD_TestDataParamModel *)CData;
/**无功功率*/
+(float)getReactivePowerWithVData:(BD_TestDataParamModel *)VData CData:(BD_TestDataParamModel *)CData;
/**视在功率*/
+(float)getApparentPowerWithVData:(BD_TestDataParamModel *)VData CData:(BD_TestDataParamModel *)CData;
@end
