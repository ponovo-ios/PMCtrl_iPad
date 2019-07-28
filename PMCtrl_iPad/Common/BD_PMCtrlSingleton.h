//
//  BD_PMCtrlSingleton.h
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/11.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BD_QuickTestResultModel.h"
#import "BD_HardwarkConfigModel.h"
@interface BD_PMCtrlSingleton : NSObject
+(instancetype)shared;
@property(nonatomic,assign)float qdCurrent;
@property(nonatomic,assign)float ratio1Ir1;
@property(nonatomic,assign)float ratio1Ir2;
@property(nonatomic,assign)float ratio2Ir1;
@property(nonatomic,assign)float ratio2Ir2;
@property(nonatomic,assign)float sdCurrent;
//差动电流拐点个数
@property(nonatomic,assign)int breakPointCount;

@property(nonatomic,assign)int quickResult_lastCount;
@property(nonatomic,assign)int stateResult_lastCount;

//@property(nonatomic,strong)BD_BeginTestModel *StatebeginModel;
@property(nonatomic,assign)BDDeviceType deviceType;

////手动测试是否直流
//@property(nonatomic,assign)BOOL quickTestisCocurrent;

@end
