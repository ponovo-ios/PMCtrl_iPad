//
//  BD_QuickTestParamModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**  通用参数页面 pickerView 选择变量模型 数据页面+／-用到相关参数  */
@interface BD_QuickTestPickerModel : NSObject
/** 名称 */
@property (nonatomic,strong)NSString *title;
/** 所选择行 */
@property (nonatomic,strong)NSArray *row;
/** 所选择列 */
@property (nonatomic,assign)int column;
@property (nonatomic,assign)int group;
-(instancetype)initWithTitle:(NSString *)title row:(NSArray *)row column:(int)column group:(int)group;

@end

/** 通用参数设置模型 */
@interface BD_QuickTestComSetModel : NSObject
//整定动作值
@property (nonatomic,strong)NSString *integervalue;
//整定动作时间
@property (nonatomic,strong)NSString *integerActionTime;
//变量
@property (nonatomic,strong)NSString *varlabel;
//变量类型
@property (nonatomic,assign)int ParaType;//0 幅值 1 项位 2 频率
//始值
@property (nonatomic,strong)NSString *startValue;
//终值
@property (nonatomic,strong)NSString *endValue;
//变化步长
@property (nonatomic,strong)NSString *stepValue;
//变化时间
@property (nonatomic,strong)NSString *changeTime;
//是否自动
@property (nonatomic,assign)bool isAuto;
//自动递变变化方式
@property (nonatomic,assign)int autoChangeStyle;//自动递变变化方式 0 始值-终值 1 始值--终值--始值
//是否直流
@property (nonatomic,assign)bool isCocurrent;
//是否老化试验
@property (nonatomic,assign)bool isAgingTest;
//延时时长 触发延时
@property (nonatomic,strong)NSString *delayTime;
////动作时间
//@property (nonatomic,strong)NSString *actionTime;
//开入量
@property (nonatomic,assign)NSNumber *binaryIn;
//开出量
@property (nonatomic,assign)NSNumber *binaryOut;
//开入逻辑
@property (nonatomic,assign)int binaryLogic;//0 逻辑或 1 逻辑与
//是否锁定
@property (nonatomic,assign)bool isLock;
//额定线电压
@property (nonatomic,strong)NSString  *rateVoltage;
//额定电流
@property (nonatomic,strong)NSString *rateCurrent;
//额定频率
@property (nonatomic,strong)NSString *rateFrequency;

//-(instancetype)initWithIntegervalue:(NSString *)intergervalue integerActionTime:(NSString *)integerActionTime varlabel:(NSString *)varlabel startValue:(NSString *)startValue endValue:(NSString *)endValue stepValue:(NSString *)stepValue changeTime:(NSString *)changeTime isAuto:(bool)isAuto autoChangeStyle :(int) autoChangeStyle isCocurrent:(bool)isCocurrent isAgingTest:(bool)isAgingTest delayTime:(NSString *)delayTime actionTime:(NSString *)actionTime isLock:(bool)isLock rateVoltage:(NSString *)rateVoltage rateCurrent:(NSString *)rateCurrent rateFrequency:(NSString *)rateFrequency ;

@end

@interface BD_PassagewayNumModel : NSObject
@property(nonatomic,assign)int voltagePassageNum;
@property(nonatomic,assign)int currentPassageNum;
-(instancetype)initWithNum:(int)voltagePassageNum currentPassageNum:(int)currentPassageNum;

@end

