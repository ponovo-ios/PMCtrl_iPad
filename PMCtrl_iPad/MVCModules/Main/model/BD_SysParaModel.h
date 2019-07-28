//
//  BD_SysParaModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/8.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>


//@interface BD_AnalogMap:NSObject
//@property(nonatomic,strong)NSArray<NSNumber *>* nDeviceChanelArr;
//@end

@interface BD_DeviceChanelDesc:NSObject
@property(nonatomic,assign)int smvMaxGroupNum;//SMV最大组数
@property(nonatomic,assign)int goosePubMaxGroupMum;//GOOSE最大组数
@property(nonatomic,assign)int gooseinMaxGroupNum;//goosein 最大组数
@property(nonatomic,assign)int analogVoltMaxChanel;//模拟量电压最大通道
@property(nonatomic,assign)int analogCurrentMaxChanel;//模拟量电流最大通道
@property(nonatomic,assign)float frequencyMax;//频率范围
@property(nonatomic,assign)float voltageMax;//电压范围
@property(nonatomic,assign)float currentMax;//电流范围
@property(nonatomic,assign)bool  isHasUDC;//是否有Udc;
@property(nonatomic,assign)float UDCMax;//Udc范围
@property(nonatomic,assign)bool  isHasIDC;
@property(nonatomic,assign)float IDCMax;
@property(nonatomic,assign)int binaryInMaxNum;//开入量个数
@property(nonatomic,assign)int binaryOutMaxNum;//开出量个数
@property(nonatomic,assign)bool   isHasDigitalOut ;//是否有数字输出功能
@property(nonatomic,assign)bool   isHasVoltAnalogOut  ;//是否有模拟输出功能
@property(nonatomic,assign)bool   isHasCurAnalogOut;//
@property(nonatomic,assign)int digitalModuleNum ;//数字模块数
@property(nonatomic,assign)int digitalModulePortNum ;//数字模块光口数
@property(nonatomic,assign)int analogVoltModuleCount ;//电压模块数
@property(nonatomic,assign)int analogVoltModuleBeginNum ;//电压模块起始编号
@property(nonatomic,strong)NSArray *AnalogVoltModuleChanleCount;//电压模块通道数,数组中存放int
@property(nonatomic,assign)int analogCurrentModuleCount;//电流模块数
@property(nonatomic,assign)int analogCurrentModuleBeginNum;//电流模块起始编号
@property(nonatomic,strong)NSArray  *analogCurrentModuleChanleCount;//电流模块通道数,数组中存放int
@property(nonatomic,assign)int deviceNumber;//device number only one;
@end

@interface BD_SysParaModel : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,strong)BD_DeviceChanelDesc *chanelDesc;
@end
