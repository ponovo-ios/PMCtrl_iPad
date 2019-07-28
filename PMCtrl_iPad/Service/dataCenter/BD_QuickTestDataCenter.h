//
//  BD_QuickTestDataCenter.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/22.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BD_TestDataParamModel.h"
#import "BD_OutputwaveShapeDataModel.h"
@interface BD_QuickTestDataCenter : NSObject

@property(nonatomic,strong)NSMutableArray *times;
@property(nonatomic,strong)NSMutableArray *binaryStateDatas;

@property(nonatomic,assign)int binarynbinall;
@property(nonatomic,assign)int binarynbinall_out;
/**状态图开入开出定时器*/
@property(nonatomic,strong) NSTimer *timer;

/** 硬件配置通道 更新输出数据数据源*/
-(void)updateTestData:(int)V_passNum C_passNum:(int)C_passNum complete:(void(^)(NSMutableArray *))complete;

/**  初始化输出波形图数据   */
-(NSMutableArray *)outPutWaveShapeDataCenter:(NSArray<NSMutableArray<BD_TestDataParamModel *> *> *)dataArr;

/**  刷新输出波形图数据   */
-(NSMutableArray *)updateOutPutWaveShapeDataCenter:(NSArray<NSMutableArray<BD_TestDataParamModel *> *> *)dataArr;


///**启动定时器*/
//-(void)startTimer;
///**停止定时器*/
//-(void)stopTimer;
///**取消定时器*/
//-(void)cancelTimer;
///**创建定时器*/
//-(void)createTimer;
/** 开入开出创建数据*/
-(NSMutableArray *)createBinaryStateLineViewDatas;
-(NSMutableArray *)createRefreshTime;
/**重新开始后开入开出状态置为默认*/
-(void)setBinaryDataDefault;
@end
