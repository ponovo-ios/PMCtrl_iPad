//
//  BD_HarmTableDataModel.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//  数据页面模型

#import <Foundation/Foundation.h>
#import "BD_HarmCellModel.h"

typedef NS_ENUM(NSUInteger, HarmParamsType) {
    S_V,//模拟电压
    S_C,//模拟电流
    N_V,//数字电压
    N_C,//数字电流
    S_V1,//模拟电压1
    S_C1,//模拟电流1
    N_V1,//数字电压1
    N_C1,//数字电流1
    S_V2,//模拟电压2
    S_C2,//模拟电流2
    N_V2,//数字电压2
    N_C2//数字电流2
};

@interface BD_HarmTableDataModel : NSObject

/**数据类型*/
@property (nonatomic, assign) HarmParamsType itemType;

/**头部数据数组*/
@property (nonatomic, strong) NSMutableArray *headerDataArray;

/**属性数组*/
@property (nonatomic, copy) NSArray *itemArray;

/**内容数据*/
@property (nonatomic, copy) NSMutableArray *contentDataArray;

-(instancetype)initWithHarmParamsType:(HarmParamsType)type;

@end
