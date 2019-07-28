//
//  BD_DifferSetDataModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/13.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferSetDataModel.h"

@implementation BD_DifferSetDataModel
- (instancetype)init
{
    self = [super init];
    if (self) {
       self.Axis = 0;//定值整定方式
       self.Insel = 0;//基准电流选择
       self.Inom = 0;//基准电流
       self.Isd = 0;//差动速断电流定值
       self.Icdqd = 0;//差动动作电流门揽值
       self.KneePoint = 1;//拐点个数
       self.Ip1 = 0;//比率制动特性拐点1电流
       self.Ip2 = 0;//比率制动特性拐点1电流
       self.Ip3 = 0;//比率制动特性拐点1电流
       self.Kid1 = 0;//启动电流斜率
       self.Kid2 = 0;//基波比率制动特性斜率1
       self.Kid3 = 0;//速断电流斜率
       self.Kid4 = 0;//速断电流斜率
       self.Kxb2 = 0;//二次谐波制动系数
        self.Kxb3 = 0;//三次谐波制动系数
       self.Kxb5 = 0;//5次谐波制动系数
    }
    return self;
}
@end
