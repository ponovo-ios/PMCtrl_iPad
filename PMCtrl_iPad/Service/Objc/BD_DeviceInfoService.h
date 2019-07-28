//
//  BD_DeviceInfoService.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/8.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BD_DeviceChanelDesc;

@interface BD_DeviceInfoService : NSObject{
}

typedef void(^complete)(BD_DeviceChanelDesc *resultModel,bool isSucess);

+(instancetype)shared;
@property(nonatomic,strong)NSTimer *timer;
/**读取测试仪信息 - 通道个数等信息*/
-(bool)readDevicePara:(complete)complete;
/**启动定时器*/
-(void)startTimer;
/**停止定时器*/
-(void)stopTimer;
/**创建定时器*/
-(void)createTimer;
/**销毁定时器*/
-(void)cancelTimer;
@end
