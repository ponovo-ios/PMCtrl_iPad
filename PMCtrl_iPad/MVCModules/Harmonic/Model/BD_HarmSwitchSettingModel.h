//
//  BD_HarmSwitchSettingModel.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//  开关量设置模型

#import <Foundation/Foundation.h>

@interface BD_HarmSwitchSettingModel : NSObject

/**开入数组*/
@property (nonatomic, copy) NSMutableArray *switchInArray;

/**开出数组*/
@property (nonatomic, copy) NSMutableArray *switchOutArray;

/**开入逻辑*/
@property (nonatomic, assign) NSInteger switchLogic;

@end
