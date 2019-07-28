//
//  BD_HarmCellModel.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmCellModel.h"

@implementation BD_HarmCellModel

-(instancetype)init{
    if (self = [super init]) {
        _itemArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(instancetype)initWithItemNum:(NSInteger)num
{
    if (self = [super init]) {
        
        _itemArray = [NSMutableArray array];
        //初始化item模型
        for (NSInteger i = 0; i < num; i++) {
            BD_HarmItem *item = [[BD_HarmItem alloc] init];
            [_itemArray addObject:item];
        }
    }
    return self;
}


-(instancetype)initWithItemNum:(NSInteger)num firstCellType:(HarmFirstCellType)type
{
    if (self = [super init]) {
        _itemArray = [NSMutableArray array];
        //初始化item模型
        for (NSInteger i = 0; i < num; i++) {
            BD_HarmItem *item = [[BD_HarmItem alloc] init];
            [_itemArray addObject:item];
        }
        
        if (type == VOLTAGE) {//电压
            
            if (num == 3) {//三个item
                BD_HarmItem *firstItem = _itemArray.firstObject;
                firstItem.containingRate = @"100.00";
                firstItem.validValues = @"57.735";
                firstItem.phase = @"0.0";
                BD_HarmItem *secondItem = _itemArray[1];
                secondItem.containingRate = @"100.00";
                secondItem.validValues = @"57.735";
                secondItem.phase = @"-120.0";
                BD_HarmItem *thirdItem = _itemArray.lastObject;
                thirdItem.containingRate = @"100.00";
                thirdItem.validValues = @"57.735";
                thirdItem.phase = @"120.0";
            }else{//4个item
                BD_HarmItem *firstItem = _itemArray.firstObject;
                firstItem.containingRate = @"100.00";
                firstItem.validValues = @"57.735";
                firstItem.phase = @"0.0";
                BD_HarmItem *secondItem = _itemArray[1];
                secondItem.containingRate = @"100.00";
                secondItem.validValues = @"57.735";
                secondItem.phase = @"-120.0";
                BD_HarmItem *thirdItem = _itemArray[2];
                thirdItem.containingRate = @"100.00";
                thirdItem.validValues = @"57.735";
                thirdItem.phase = @"120.0";
                BD_HarmItem *fourthItem = _itemArray.lastObject;
                fourthItem.containingRate = @"100.00";
                fourthItem.validValues = @"57.735";
                fourthItem.phase = @"0.0";
            }
        }else{//电流
            BD_HarmItem *firstItem = _itemArray.firstObject;
            firstItem.containingRate = @"100.00";
            firstItem.validValues = @"5.000";
            firstItem.phase = @"0.0";
            BD_HarmItem *secondItem = _itemArray[1];
            secondItem.containingRate = @"100.00";
            secondItem.validValues = @"5.000";
            secondItem.phase = @"-120.0";
            BD_HarmItem *thirdItem = _itemArray.lastObject;
            thirdItem.containingRate = @"100.00";
            thirdItem.validValues = @"5.000";
            thirdItem.phase = @"120.0";

        }
        
    }
    return self;
}

@end
