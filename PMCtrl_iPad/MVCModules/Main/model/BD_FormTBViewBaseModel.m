//
//  BD_FormTBViewBaseModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_FormTBViewBaseModel.h"

@implementation BD_FormTBViewBaseModel
-(instancetype)initWithNum:(int)num{
    if (self = [super init]) {
        [self cogfitProperty:num];
    }
    return  self;
}
-(void)cogfitProperty:(int)num{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<num; i++) {
        [arr addObject:@""];
    }
    self.modelDatas = [arr copy];
}
@end
