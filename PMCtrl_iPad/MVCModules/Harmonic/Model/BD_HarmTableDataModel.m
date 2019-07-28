//
//  BD_HarmTableDataModel.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmTableDataModel.h"

@interface BD_HarmTableDataModel()
{
    BD_HarmCellModel *_firstCellModel;
}



@end

@implementation BD_HarmTableDataModel

-(instancetype)initWithHarmParamsType:(HarmParamsType)type
{
    if (self = [super init]) {

        _itemType = type;
        
        [self setupDataWith:type];
    }
    return self;
}


//内容数据数组
-(NSMutableArray *)contentDataArray
{
    if (!_contentDataArray) {
        _contentDataArray = [NSMutableArray array];
    }
    return _contentDataArray;
}


//初始化数据内容
-(void)setupDataWith:(HarmParamsType)type
{
    BD_HarmCellModel *firstCellModel;
    //初始化头部数组
    switch (type) {
        case S_V://模拟电压
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ua(总有效值 = 57.735V)", @"Ub(总有效值 = 57.735V)", @"Uc(总有效值 = 57.735V)", @"Uz(总有效值 = 57.735V)"]];
            self.itemArray = @[@"Ua", @"Ub", @"Uc", @"Uz"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:VOLTAGE];
            break;
            
        case S_C://模拟电流
        case S_C1://模拟电流1
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ia(总有效值 = 5.000A)", @"Ib(总有效值 = 5.000A)", @"Ic(总有效值 = 5.000A)"]];
            self.itemArray = @[@"Ia", @"Ib", @"Ic"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:CURRENT];
            break;
            
        case N_V://数字电压
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ua`(总有效值 = 57.735V)", @"Ub`(总有效值 = 57.735V)", @"Uc`(总有效值 = 57.735V)", @"Uz`(总有效值 = 57.735V)"]];
            self.itemArray = @[@"Ua`", @"Ub`", @"Uc`", @"Uz`"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:VOLTAGE];
            break;
            
        case N_C://数字电流
        case N_C1://数字电流1
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ia`(总有效值 = 5.000A)", @"Ib`(总有效值 = 5.000A)", @"Ic`(总有效值 = 5.000A)"]];
            self.itemArray = @[@"Ia`", @"Ib`", @"Ic`"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:CURRENT];
            break;
    
        case S_V1://模拟电压1
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ua(总有效值 = 57.735V)", @"Ub(总有效值 = 57.735V)", @"Uc(总有效值 = 57.735V)"]];
            self.itemArray = @[@"Ua", @"Ub", @"Uc"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:VOLTAGE];
            break;
        
        case N_V1://数字电压1
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ua`(总有效值 = 57.735V)", @"Ub`(总有效值 = 57.735V)", @"Uc`(总有效值 = 57.735V)"]];
            self.itemArray = @[@"Ua`", @"Ub`", @"Uc`"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:VOLTAGE];
            break;
            
        case S_V2://模拟电压2
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ua2(总有效值 = 57.735V)", @"Ub2(总有效值 = 57.735V)", @"Uc2(总有效值 = 57.735V)"]];
            self.itemArray = @[@"Ua2", @"Ub2", @"Uc2"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:VOLTAGE];
            break;
            
        case S_C2://模拟电流2
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ia2(总有效值 = 5.000A)", @"Ib2(总有效值 = 5.000A)", @"Ic2(总有效值 = 5.000A)"]];
            self.itemArray = @[@"Ia2", @"Ib2", @"Ic2"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:CURRENT];
            break;
            
        case N_V2://数字电压2
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ua2`(总有效值 = 57.735V)", @"Ub2`(总有效值 = 57.735V)", @"Uc2`(总有效值 = 57.735V)"]];
            self.itemArray = @[@"Ua2`", @"Ub2`", @"Uc2`"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:VOLTAGE];
            break;
            
        case N_C2://数字电流2
            self.headerDataArray = [NSMutableArray arrayWithArray:@[@"Ia2`(总有效值 = 5.000A)", @"Ib2`(总有效值 = 5.000A)", @"Ic2`(总有效值 = 5.000A)"]];
            self.itemArray = @[@"Ia2`", @"Ib2`", @"Ic2`"];
            firstCellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count firstCellType:CURRENT];
            break;
            
        default:
            break;
    }
    
    //初始化内容数组
    for (NSInteger i = 0; i < 50; i++) {
        
        if (i == 0) {//第一行cellModel
            [self.contentDataArray addObject:firstCellModel];
        }else{//其他cellModel
            BD_HarmCellModel *cellModel = [[BD_HarmCellModel alloc] initWithItemNum:self.headerDataArray.count];
            [self.contentDataArray addObject:cellModel];
        }
        
    }
    
}

@end
