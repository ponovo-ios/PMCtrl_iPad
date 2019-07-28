//
//  BD_TestItemParamModel.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/6/1.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TestItemParamModel.h"

@implementation BD_TestItemParamModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemNum = 1;
        self.itemProject = @"";
        self.itemName = @"";
        self.itemSelect = YES;
        self.itemResult = @"";
    }
    return self;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_TestItemParamModel *model = [[[self class]allocWithZone:zone]init];
    model.itemNum = self.itemNum;
    model.itemName = self.itemName;
    model.itemProject = self.itemProject;
    model.itemSelect = self.itemSelect;
    model.itemResult = self.itemResult;
    return model;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_TestItemParamModel *model = [[[self class]allocWithZone:zone]init];
    model.itemNum = self.itemNum;
    model.itemName = self.itemName;
    model.itemProject = self.itemProject;
    model.itemSelect = self.itemSelect;
    model.itemResult = self.itemResult;
    return model;
}
@end
