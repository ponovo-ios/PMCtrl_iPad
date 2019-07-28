//
//  BD_TestBinarySwitchSetModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/16.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_TestBinarySwitchSetModel : NSObject<NSMutableCopying,NSCopying>
@property(nonatomic,assign)NSInteger iKA;         //0:开放 1：闭锁
@property(nonatomic,assign)NSInteger iKB;
@property(nonatomic,assign)NSInteger iKC;
@property(nonatomic,assign)NSInteger iKD;
@property(nonatomic,assign)NSInteger iKE;
@property(nonatomic,assign)NSInteger iKF;
@property(nonatomic,assign)NSInteger iKG;
@property(nonatomic,assign)NSInteger iKH;
@property(nonatomic,assign)NSInteger iKI;
@property(nonatomic,assign)NSInteger iKJ;
@property(nonatomic,assign)NSInteger iLogic;     //0: 逻辑或 逻辑与
@property(nonatomic,assign)NSInteger iOut1;         //0:打开 1关闭
@property(nonatomic,assign)NSInteger iOut2;         //0:打开 1关闭
@property(nonatomic,assign)NSInteger iOut3;         //0:打开 1关闭
@property(nonatomic,assign)NSInteger iOut4;         //0:打开 1关闭
@property(nonatomic,assign)NSInteger iOut5;         //0:打开 1关闭
@property(nonatomic,assign)NSInteger iOut6;         //0:打开 1关闭
@property(nonatomic,assign)NSInteger iOut7;         //0:打开 1关闭
@property(nonatomic,assign)NSInteger iOut8;         //0:打开 1关闭
@end
