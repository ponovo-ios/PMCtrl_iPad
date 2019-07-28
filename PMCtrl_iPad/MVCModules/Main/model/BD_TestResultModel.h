//
//  BD_TestResultModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/22.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_ReultInfo:NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)NSInteger binaryData;
@property(nonatomic,assign)CGFloat actionValue;
@property(nonatomic,assign)CGFloat actionTime;
@end

@interface BD_TestResultData:NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,strong)NSMutableArray<BD_ReultInfo *> *actionInfoArr;
@property(nonatomic,assign)BOOL isMark;
@property(nonatomic,assign)CGFloat returnValue;
@property(nonatomic,assign)CGFloat returnTime;

@end


@interface BD_TestResultModel : NSObject<NSCopying,NSMutableCopying>
/**
 结果类型
 --1：开始实验    2：实验结束    3：状态切换    4：开入变位 5: 递变
 */
@property(nonatomic,assign)int nType;
/**
 //当type为开入变位，为变位的开入通道，bit9~bit0对应开入9~0
 //当type为状态切换时，为状态切换触发条件，
 //bit12:手动触发    bit11：时间触发    bit10：GPS触发
 //bit9~bit0:对应开关量9~0
 */
@property(nonatomic,assign)int nSource;
/**产生结果的时间秒值,小数点前*/
@property(nonatomic,assign)int nSec;
/**产生结果的时间纳秒值，小数点后的位数*/
@property(nonatomic,assign)int nNanoSec;
/**产生结果时开入量的值*/
@property(nonatomic,assign)int nInput;

@property(nonatomic,assign)int nGooseValue;
/**当前状态索引号*/
@property(nonatomic,assign)int currentIndex;
/**要跳转的状态索引号*/
@property(nonatomic,assign)int nObjective;
/**自动递变已经执行的步数*/
@property(nonatomic,assign)int nStep;

-(instancetype)initWithnType:(int)nType nSource:(int)nSource nSec:(int)nSec nNanoSec:(int)nNanoSec nInput:(int)nInput nGooseValue:(int)nGooseValue currentIndex:(int)currentIndex nObjective:(int)nObjective nStep:(int)nStep;

@end
