//
//  BD_DifferGeneralSetDataModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/13.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
/**差动模块--通用参数*/
@interface BD_DifferGeneralSetDataModel : NSObject
@property(nonatomic,strong)NSString *ED_V;//额定线电压
@property(nonatomic,strong)NSString *ED_I;//额定电流
@property(nonatomic,strong)NSString *ED_Hz;//额定频率
@property(nonatomic,strong)NSString *PreTime;//准备时间
@property(nonatomic,strong)NSString *PrefaultTime;//故障前时间
@property(nonatomic,strong)NSString *FaultTime;//故障时间
@property(nonatomic,strong)NSString *BalanceParaCacuType;//各侧平衡系数0或1
@property(nonatomic,strong)NSString *SN;//变压器额定容量
@property(nonatomic,strong)NSString *Uh;//高压侧额定电压
@property(nonatomic,strong)NSString *Um;//中压侧额定电压
@property(nonatomic,strong)NSString *Ul;//低压侧额定电压
@property(nonatomic,strong)NSString *CTPh;//高压侧CT一次值
@property(nonatomic,strong)NSString *CTPm;//中压侧CT一次值
@property(nonatomic,strong)NSString *CTPl;//低压侧CT一次值
@property(nonatomic,strong)NSString *CTSh;//高压侧CT二次值
@property(nonatomic,strong)NSString *CTSm;//中压侧CT二次值
@property(nonatomic,strong)NSString *CTSl;//低压侧CT二次值
@property(nonatomic,strong)NSString *Kph;//高压侧差动平衡系数
@property(nonatomic,strong)NSString *Kpm;//中压侧差动平衡系数
@property(nonatomic,strong)NSString *Kpl;//低压侧差动平衡系数
@property(nonatomic,strong)NSString *WindH;//高压侧绕组接线型式
@property(nonatomic,strong)NSString *WindM;//中压侧绕组接线型式
@property(nonatomic,strong)NSString *WindL;//低压侧绕组接线型式
@property(nonatomic,strong)NSString *AngleMode;//校正选择
@property(nonatomic,strong)NSString *WindSide;//测试绕组
@property(nonatomic,strong)NSString *ConnMode;//测试绕组之间角差
@property(nonatomic,strong)NSString *JXFactor;//平衡系数计算是否考虑接线形式
@property(nonatomic,strong)NSString *SerachMode;//搜索方法
@property(nonatomic,strong)NSString *IdEqu;//CT极性
@property(nonatomic,strong)NSString *Equation;//制动方程
@property(nonatomic,strong)NSString *K1;
@property(nonatomic,strong)NSString *K2;
@property(nonatomic,strong)NSString *Phase_Type;//测试相
@property(nonatomic,strong)NSString *Reso;//测试精度
@property(nonatomic,strong)NSString *Ugroup1;//Ua、Ub、Uc
@property(nonatomic,strong)NSString *Ugroup2;//Ua2、Ub2、Uc2

@end
