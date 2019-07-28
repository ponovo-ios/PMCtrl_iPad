//
//  BD_DifferentialCharacteristicModel.h
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/6.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_DifferentialCharacteristicModel : NSObject

@property(nonatomic,assign)float thresholdLevel;//门槛值
@property(nonatomic,assign)float SDCurrentLevel;//速断电流定值
@property(nonatomic,assign)float breakPoint1_current;//拐点1电流
@property(nonatomic,assign)float breakPoint2_current;//拐点2电流
@property(nonatomic,assign)float breakPoint3_current;//拐点3电流
@property(nonatomic,assign)float rateSlope1;//比率制动特性斜率1
@property(nonatomic,assign)float rateSlope2;//比率制动特性斜率2
@property(nonatomic,assign)float rateSlope3;//比率制动特性斜率3
@property(nonatomic,assign)float rateSlope4;//比率制动特性斜率4
@property(nonatomic,assign)float QDCurrentId;//启动电流子项-制动电流
@property(nonatomic,assign)float RateSlope1Id1;//比率制动系数1-制动电流
@property(nonatomic,assign)float RateSlope1Id2;//比率制动系数1-制动电流
@property(nonatomic,assign)float RateSlope2Id1;//比率制动系数2-制动电流
@property(nonatomic,assign)float RateSlope2Id2;//比率制动系数2-制动电流
@property(nonatomic,assign)float SDCurrentId;//速断电流子项-制动电流
-(instancetype)initWithThresholdLevel:(float)thresholdLevel SDCurrentLevel:(float)SDCurrentLevel breakPoint1_current:(float)breakPoint1_current breakPoint2_current:(float)breakPoint2_current breakPoint3_current:(float)breakPoint3_current rateSlope1:(float)rateSlope1 rateSlope2:(float)rateSlope2 rateSlope3:(float)rateSlope3 rateSlope4:(float)rateSlope4 QDCurrentId:(float)QDCurrentId RateSlope1Id1:(float)RateSlope1Id1 RateSlope1Id2:(float)RateSlope1Id2 RateSlope2Id1:(float)RateSlope2Id1 RateSlope2Id2:(float)RateSlope2Id2 SDCurrentId:(float)SDCurrentId ;
@end
