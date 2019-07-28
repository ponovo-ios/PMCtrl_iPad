//
//  BD_HardwarkConfigModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/21.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BD_HardwarkConfigModel : NSObject
/**测试仪类型*/
@property (nonatomic,assign)BDDeviceType deviceType;
/** 电压通道个数*/
@property (nonatomic,assign)int voltagePassNum;
/** 电流通道个数*/
@property (nonatomic,assign)int currentPassNum;
/**交流电压*/
@property (nonatomic,strong)NSString *exchangeVoltage;
/**交流电流*/
@property (nonatomic,strong)NSString *exchangeCurrent;
/**直流电压*/
@property (nonatomic,strong)NSString *directVoltage;
/**直流电流*/
@property (nonatomic,strong)NSString *directCurrent;
/**辅助电流*/
@property (nonatomic,strong)NSString *assistCurrent;

@end
