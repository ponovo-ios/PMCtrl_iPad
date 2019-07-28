//
//  BD_SMVDetailSettingWeakSignalMapModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BD_SMVDetailSettingWeakSignalMapModel_passageWay : NSObject
@property(nonatomic,strong)NSString *leftPassageway;
@property(nonatomic,strong)NSString *rightPassageway;

-(instancetype)initWithLeftPassageway:(NSString *)leftPassageway rightPassageway:(NSString *)rightPassageway;
@end
/**  smv详细设置中弱信号输出模块数据模型   */
@interface BD_SMVDetailSettingWeakSignalMapModel : NSObject
@property(nonatomic,assign)BOOL isWeakSigalMap;
@property(nonatomic,strong)NSMutableArray<BD_SMVDetailSettingWeakSignalMapModel_passageWay *> *weakpassageWays;
@property(nonatomic,strong)NSString *PTChangeValue1;
@property(nonatomic,strong)NSString *PTChangeValue2;
@property(nonatomic,strong)NSString *CTChangeValue1;
@property(nonatomic,strong)NSString *CTChangeValue2;
-(instancetype)initWithWeakSingalMap :(BOOL)isWeakSigalMap weakpassageWays:(NSMutableArray<BD_SMVDetailSettingWeakSignalMapModel_passageWay *> *)weakpassageWays PTChangeValue1:(NSString *)PTChangeValue1 PTChangeValue2:(NSString *)PTChangeValue2 CTChangeValue1:(NSString *)CTChangeValue1  CTChangeValue2:(NSString *)CTChangeValue2;

@end
