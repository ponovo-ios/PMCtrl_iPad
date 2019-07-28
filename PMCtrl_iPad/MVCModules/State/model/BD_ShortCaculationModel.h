//
//  BD_ShortCaculationModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_ShortCaculationModel : NSObject
@property(nonatomic,strong)NSString *faultStyle;
@property(nonatomic,assign)int ZPhiOrRx;//0 Zphi 1 Rx
@property(nonatomic,strong)NSString *ZPhi1;
@property(nonatomic,strong)NSString *ZPhi2;
@property(nonatomic,strong)NSString *Rx1;
@property(nonatomic,strong)NSString *Rx2;
@property(nonatomic,strong)NSString *caculationModel;
@property(nonatomic,strong)NSString *shortCurrent;
@property(nonatomic,strong)NSString *shortVoltage;
@property(nonatomic,strong)NSString *ZSZL;
@property(nonatomic,strong)NSString *cacultationStyle;
@property(nonatomic,strong)NSString *ampletude;
@property(nonatomic,strong)NSString *phase;
@property(nonatomic,strong)NSString *loadCurrent;
@property(nonatomic,strong)NSString *loadPowerPhase;
@property(nonatomic,strong)NSString *selectedGroup;
-(instancetype)initWithFaultStyle:(NSString *)faultStyle ZPhiOrRx:(int)ZPhiOrRx ZPhi1:(NSString *)ZPhi1 ZPhi2:(NSString *)ZPhi2 Rx1:(NSString *)Rx1 Rx2:(NSString *)Rx2 caculationModel:(NSString *)caculationModel shortCurrent:(NSString *)shortCurrent shortVoltage:(NSString *)shortVoltage ZSZL:(NSString *)ZSZL cacultationStyle:(NSString *)cacultationStyle ampletude:(NSString *)ampletude phase:(NSString *)phase loadCurrent:(NSString *)loadCurrent loadPowerPhase:(NSString *)loadPowerPhase selectedGroup:(NSString *)selectedGroup;
@end
