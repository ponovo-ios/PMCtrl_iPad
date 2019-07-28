//
//  OCCenter.h
//  PQCProj
//
//  Created by liwei on 2017/3/29.
//  Copyright © 2017年 weiwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BD_EnumCollection.h"
@class BD_HarmModel;
@class BD_StateTestCommonParamModel;
@class BD_DifferGeneralSetDataModel;
@class BD_DifferSetDataModel;
@class BD_TestBinarySwitchSetModel;
@class BD_BinaryInSetData;
@class BD_TestDataParamModel;
@class BD_UtcTime;

@interface OCCenter : NSObject
@property(nonatomic, copy)NSString              *ip;  //rpc ip
@property(nonatomic, assign)NSInteger           port; //rpc端口


+ (OCCenter *)shareCenter; //单例

- (void)serviceRun; //开启服务端

- (int)start:(int)startNum;//开始测试

- (int)stop;//停止测试



//手动测试
- (bool)ManualTest:(NSArray *)values;

//状态序列
- (bool)statesTest:(NSArray<BD_TestDataParamModel *> *)testListDatas commonPara:(BD_StateTestCommonParamModel *)comparam deviceGPSTime:(BD_UtcTime *)deviceGPSTime;

//差动
- (bool)DifferentialTestWithGeneralParam:(BD_DifferGeneralSetDataModel *)generalParam setParam:(BD_DifferSetDataModel *)setParam binarySwitch:(BD_TestBinarySwitchSetModel *)binarySwitch testItem:(NSArray *)testItem outputType:(BDDeviceType)outputType;

//谐波
-(bool)harmTestChange:(BD_HarmModel *)model;

//开入量参数下发
-(bool)binarySetAction:(BD_BinaryInSetData *)binaryData;
//获取开入量数据
-(nullable BD_BinaryInSetData *)getBinaryInfo;

/**
 直流设置
 @pragma isStart yes 开始输出 no 停止输出
 @pragma dirCurrentValue 幅值
 @return 下发参数是否成功
 */
-(bool)directCurrentSetActionIsStart:(bool)isStart dirCurrentValue:(float)dirCurrentValue;

@end
