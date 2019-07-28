//
//  BD_HarmCellModel.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//  数据行模型

#import <Foundation/Foundation.h>
#import "BD_HarmItem.h"


typedef NS_ENUM(NSUInteger, HarmFirstCellType) {
    VOLTAGE,//电压
    CURRENT//电流
};

@interface BD_HarmCellModel : NSObject

/**模型数组*/
@property (nonatomic, strong) NSMutableArray *itemArray;

-(instancetype)initWithItemNum:(NSInteger)num;

//第一行cell模型
-(instancetype)initWithItemNum:(NSInteger)num firstCellType:(HarmFirstCellType)type;

@end
