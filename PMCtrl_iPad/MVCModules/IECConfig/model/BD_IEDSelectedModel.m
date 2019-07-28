//
//  BD_IEDSelectedModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/9.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_IEDSelectedModel.h"

@implementation BD_IEDSelectedModel
- (instancetype)init
{
    self = [super init];
    if (self) {
      
        self.iedType = @"";
        self.APPID = @"";
        self.dataSetDesc = @"";
        self.IedName = @"";
    }
    return self;
}


@end
