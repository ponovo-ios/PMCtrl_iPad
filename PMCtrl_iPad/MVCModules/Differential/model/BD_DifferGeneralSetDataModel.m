//
//  BD_DifferGeneralSetDataModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/13.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferGeneralSetDataModel.h"

@implementation BD_DifferGeneralSetDataModel
-(instancetype)init{
    if (self = [super init]) {
        self.ED_V = @"";
        self.ED_I= @"";//额定电流
        self.ED_Hz= @"";//额定频率
        self.PreTime= @"";//准备时间
        self.PrefaultTime= @"";//故障前时间
        self.FaultTime= @"";//故障时间
        self.BalanceParaCacuType= @"";//各侧平衡系数0或1
        self.SN= @"";//变压器额定容量
        self.Uh= @"";//高压侧额定电压
        self.Um= @"";//中压侧额定电压
        self.Ul= @"";//低压侧额定电压
        self.CTPh= @"";//高压侧CT一次值
        self.CTPm= @"";//中压侧CT一次值
        self.CTPl= @"";//低压侧CT一次值
        self.CTSh= @"";//高压侧CT二次值
        self.CTSm= @"";//中压侧CT二次值
        self.CTSl= @"";//低压侧CT二次值
        self.Kph= @"";//高压侧差动平衡系数
        self.Kpm= @"";//中压侧差动平衡系数
        self.Kpl= @"";//低压侧差动平衡系数
        self.WindH= @"";//高压侧绕组接线型式
        self.WindM= @"";//中压侧绕组接线型式
        self.WindL= @"";//低压侧绕组接线型式
        self.AngleMode= @"";//校正选择
        self.WindSide= @"";//测试绕组
        self.ConnMode= @"";//测试绕组之间角差
        self.JXFactor= @"";//平衡系数计算是否考虑接线形式
        self.SerachMode= @"";//搜索方法
        self.IdEqu= @"";//CT极性
        self.Equation= @"";//制动方程
        self.K1= @"";
        self.K2= @"";
        self.Phase_Type= @"";//测试相
        self.Reso= @"";//测试精度
        self.Ugroup1= @"";//Ua、Ub、Uc
        self.Ugroup2= @"";//Ua2、Ub2、Uc2
    }
    return self;
}
@end
