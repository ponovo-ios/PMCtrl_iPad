//
//  BD_StateTestItemModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestItemModel.h"
#import "BD_StateTestParamModel.h"
@implementation BD_StateTestItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemNum = 1;
        self.itemName = @"状态序列";
        self.itemProject = @"常态";
        self.itemSelect = YES;
        self.itemResult = @"";
        self.itemParam = [[BD_StateTestParamModel alloc]init];
    }
    return self;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_StateTestItemModel *model = [[[self class]allocWithZone:zone]init];
    model.itemNum = self.itemNum;
    model.itemName = self.itemName;
    model.itemProject = self.itemProject;
    model.itemSelect = self.itemSelect;
    model.itemResult = self.itemResult;
    model.itemParam = [self.itemParam copy];
    return model;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_StateTestItemModel *model = [[[self class]allocWithZone:zone]init];
    model.itemNum = self.itemNum;
    model.itemName = self.itemName;
    model.itemProject = self.itemProject;
    model.itemSelect = self.itemSelect;
    model.itemResult = self.itemResult;
    model.itemParam = [self.itemParam copy];
    return model;
}
@end
