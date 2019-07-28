//
//  BD_HarmModel.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//  谐波模型

#import <Foundation/Foundation.h>
#import "BD_HarmTableDataModel.h"
#import "BD_HarmParamsSettingModel.h"
#import "BD_HarmSwitchSettingModel.h"
#import "BD_HarmDataSettingModel.h"
#import "BD_HarmDCSettingModel.h"

typedef NS_ENUM(NSUInteger, HarmTestType) {
    SIMULATION_TYPE,   //模拟
    DIGITAL_TYPE       //数字
};

typedef NS_ENUM(NSUInteger, HarmTestChannel) {
    S_U_S_I,             //6U6I
    F_U_T_I             //4U3I
    
};

@interface BD_HarmModel : NSObject

/**参数设置模型*/
@property (nonatomic, strong) BD_HarmParamsSettingModel *paramsModel;

/**开关量模型*/
@property (nonatomic, strong) BD_HarmSwitchSettingModel *switchModel;

/**数据设置模型*/
@property (nonatomic, strong) BD_HarmDataSettingModel *dataModel;

/**直流设置模型*/
@property (nonatomic, strong) BD_HarmDCSettingModel *dcSettingModel;

/**测试类型*/
@property (nonatomic, assign) HarmTestType testType;

/**测试通道类型*/
@property (nonatomic, assign) HarmTestChannel testChannel;

/**通道数组*/
@property (nonatomic, strong) NSMutableArray *passagewayArray;

/**所有数据数组*/
@property (nonatomic, copy) NSMutableArray *allDataArray;
/**是否锁定*/
@property(nonatomic,assign)BOOL isLock;

//切换谐波通道
-(void)changedType:(BDDeviceType)type passageway:(BDHarmPassageType)passageway;

/**通过 修改某一项 改变总有效值 */
-(BOOL)changeValueWithTableData:(BD_HarmTableDataModel *)tableDataModel index:(NSInteger)index view:(UIView *)view;

/**改变总有效值*/
-(void)changeAllValueOnView:(UIView *)view;

@end
