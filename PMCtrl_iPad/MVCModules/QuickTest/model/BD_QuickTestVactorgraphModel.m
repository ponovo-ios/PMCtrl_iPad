//
//  BD_QuickTestVactorgraphModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestVactorgraphModel.h"
#import "BD_TestDataParamModel.h"
@implementation BD_QuickTestVactorgraphModel
-(instancetype)initWithvoltageArr:(NSMutableArray<BD_TestDataParamModel *> *)voltageArr currentArr:(NSMutableArray<BD_TestDataParamModel *> *)currentArr{
    self = [super init];
    if (self) {
        self.voltageArr = voltageArr;
        self.currentArr = currentArr;
    }
    return self;
}
@end


@implementation BD_QuickTestVactorgrapViewModel


@end
