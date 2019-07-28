//
//  BD_HarmParamsSettingModel.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//  谐波参数设置模型

#import <Foundation/Foundation.h>

@interface BD_HarmParamsSettingModel : NSObject

/**测试仪类型*/
@property (nonatomic, copy) NSString *type;

/**通道选择*/
@property (nonatomic, copy) NSString *channelSelection;

/**交流电压*/
@property (nonatomic, strong) NSString *acVoltage;
/**交流电流*/
@property (nonatomic, strong) NSString *acCurrent;
/**直流电压*/
@property (nonatomic, strong) NSString *dcVoltage;
/**直流电流*/
@property (nonatomic, strong) NSString *dcCurrent;

@end
