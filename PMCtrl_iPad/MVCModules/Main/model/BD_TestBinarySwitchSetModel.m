//
//  BD_TestBinarySwitchSetModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/16.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TestBinarySwitchSetModel.h"

@implementation BD_TestBinarySwitchSetModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iKA= 1;         //0:开放 1：闭锁
        self.iKB= 1;
        self.iKC= 1;
        self.iKD= 1;
        self.iKE= 1;
        self.iKF= 1;
        self.iKG= 1;
        self.iKH= 1;
        self.iKI= 1;
        self.iKJ= 1;
        self.iLogic= 0;     //0: 逻辑或 逻辑与 默认逻辑或
        self.iOut1= 0;         //0:打开 1关闭
        self.iOut2= 0;         //0:打开 1关闭
        self.iOut3= 0;         //0:打开 1关闭
        self.iOut4= 0;         //0:打开 1关闭
        self.iOut5= 0;         //0:打开 1关闭
        self.iOut6= 0;         //0:打开 1关闭
        self.iOut7= 0;         //0:打开 1关闭
        self.iOut8= 0;         //0:打开 1关闭
    }
    return self;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_TestBinarySwitchSetModel *copy = [[[self class] allocWithZone:zone]init];
    copy.iKA=self.iKA;
    copy.iKB= self.iKB;
    copy.iKC= self.iKC;
    copy.iKD= self.iKD;
    copy.iKE= self.iKE;
    copy.iKF= self.iKF;
    copy.iKG= self.iKG;
    copy.iKH= self.iKH;
    copy.iKI= self.iKI;
    copy.iKJ= self.iKJ;
    copy.iLogic= self.iLogic;
    copy.iOut1= self.iOut1;
    copy.iOut2= self.iOut2;
    copy.iOut3= self.iOut3;
    copy.iOut4= self.iOut4;
    copy.iOut5= self.iOut5;
    copy.iOut6= self.iOut6;
    copy.iOut7= self.iOut7;
    copy.iOut8= self.iOut8;
    return copy;
    
}
-(id)copyWithZone:(NSZone *)zone{
    BD_TestBinarySwitchSetModel *copy = [[[self class] allocWithZone:zone]init];
    copy.iKA=self.iKA;
    copy.iKB= self.iKB;
    copy.iKC= self.iKC;
    copy.iKD= self.iKD;
    copy.iKE= self.iKE;
    copy.iKF= self.iKF;
    copy.iKG= self.iKG;
    copy.iKH= self.iKH;
    copy.iKI= self.iKI;
    copy.iKJ= self.iKJ;
    copy.iLogic= self.iLogic;
    copy.iOut1= self.iOut1;
    copy.iOut2= self.iOut2;
    copy.iOut3= self.iOut3;
    copy.iOut4= self.iOut4;
    copy.iOut5= self.iOut5;
    copy.iOut6= self.iOut6;
    copy.iOut7= self.iOut7;
    copy.iOut8= self.iOut8;
    return copy;
}
@end
