//
//  BDFaultCaculateLib.h
//  BDFaultCaculateLib
//
//  Created by ponovo on 2018/3/28.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BD_FaultCaculateModel;
@class BD_FaultCacuResultModel;
@interface BDFaultCaculateManager : NSObject
/**短路计算
 @param data 短路计算需要传入参数 从测试项参数中和通用参数中获取对应的值
 @return 返回值，包含短路短路电流的值和故障态3U3I的幅值和相位的结果
 */
-(BD_FaultCacuResultModel *)caculateFaultDataWithTestData:(BD_FaultCaculateModel *)data;
//状态序列短路计算
-(BD_FaultCacuResultModel *)stateCaculateShortDataWithTestData:(BD_FaultCaculateModel *)data;
@end
