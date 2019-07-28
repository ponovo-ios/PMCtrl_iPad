//
//  BD_StateTestParamModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BD_TestDataParamModel.h"
#import "BD_StateTestTransmutationDetailModel.h"

@interface BD_StateTestTriggerParamModel : NSObject<NSMutableCopying,NSCopying>

@property (nonatomic,strong)NSNumber *TriggerType; //触发模式
@property (nonatomic,strong)NSNumber *TriggerLogic;//逻辑或、与 ，开入逻辑
@property (nonatomic,strong)NSNumber *TriggerTime; //时间触发参数或 GPS触发秒数
//@property (nonatomic,strong)NSNumber *sGpstime;
//@property (nonatomic,strong)NSNumber *nsGpsTime;  //GPS时间 hour:minute:second.ns;
@property (nonatomic,strong)NSString *Gpstime;
@property (nonatomic,strong)NSNumber *nBiValide;  //开入有效位
@property (nonatomic,strong)NSNumber *nbinaryout; //开出有效位
@property (nonatomic,strong)NSNumber *trigerHoldTime;//触发后保持时间
@property (nonatomic,assign)bool isBinaryOutStateInvert;//是否开出状态反转
@property (nonatomic,strong)NSNumber *binaryOutStateInvertHoldTime;//开出状态翻转保持时间
@property (nonatomic,assign)bool isdfdt;//是否df/dt
@property (nonatomic,assign)bool isdvdt;//是否dv/dt
@property (nonatomic,assign)bool isComGradient;//普通递变

//开入
@property (nonatomic,strong)NSArray<NSNumber *> *BArr;
//开出
@property (nonatomic,strong)NSArray<NSNumber *> *BoArr;


-(instancetype)initWithTirggerType:(NSNumber *)TriggerType TriggerLogic:(NSNumber *)TriggerLogic TriggerTime:(NSNumber *)TriggerTime Gpstime:(NSString *)Gpstime  nBiValide:(NSNumber *)nBiValide nbinaryout:(NSNumber *)nbinaryout trigerHoldTime:(NSNumber *)trigerHoldTime isBinaryOutStateInvert:(bool)isBinaryOutStateInvert binaryOutStateInvertHoldTime:(NSNumber *)binaryOutStateInvertHoldTime isdfdt:(bool)isdfdt isdvdt:(bool)isdvdt isComGradient:(bool)isComGradient  BArr:(NSArray<NSNumber *> *)BArr BoArr:(NSArray<NSNumber *> *)BoArr;
@end

@interface BD_StateTestOutputParamModel:NSObject<NSMutableCopying,NSCopying>
@property(nonatomic,assign)bool isDirectCurrent;//是否直流输出
@property (nonatomic,strong)NSMutableArray<BD_TestDataParamModel *> *voltageOutputDatas;//电压输出通道幅值／相位／频率 值
@property (nonatomic,strong)NSMutableArray<BD_TestDataParamModel *> *currentOutputDatas;//电流输出通道幅值／相位／频率 值
-(instancetype)initWithIsDirectCurrent:(bool)isDirectCurrent voltageOutputDatas:(NSMutableArray<BD_TestDataParamModel *>*)voltageOutputDatas currentOutputDatas:(NSMutableArray<BD_TestDataParamModel *> *)currentOutputDatas;
@end



@interface BD_StateTestParamModel : NSObject<NSMutableCopying,NSCopying>
@property (nonatomic,strong)BD_StateTestOutputParamModel *stateParam;
@property (nonatomic,strong)BD_StateTestTriggerParamModel *triggerParam;
@property (nonatomic,strong)BD_StateTestTransmutationDetailModel *transmutationParam;
@property (nonatomic,strong)NSNumber *result;
-(instancetype)initWithStateParam:(BD_StateTestOutputParamModel *)stateParam triggerParam:(BD_StateTestTriggerParamModel *)triggerParam transmutationParam:(BD_StateTestTransmutationDetailModel *)transmutationParam result:(NSNumber *)result;
@end
