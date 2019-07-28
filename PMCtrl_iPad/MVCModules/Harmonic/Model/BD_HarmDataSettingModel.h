//
//  BD_HarmDataSettingModel.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2018/1/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//  数据设置模型

#import <Foundation/Foundation.h>

@interface BD_HarmDataSettingModel : NSObject

/**是否自动*/
@property (nonatomic, assign) BOOL isAuto;

/**频率*/
@property (nonatomic, strong) NSString *fre;

/**通道选择端口*/
@property (nonatomic, strong) NSString *channelPort;
/**通道选择谐波次数*/
@property (nonatomic, strong) NSString *passagewayIndex;
/**变化步长*/
@property (nonatomic, strong) NSString *step;
/**变化时间*/
@property (nonatomic, strong) NSString *time;
/**变化始值*/
@property (nonatomic, strong) NSString *start;
/**变化终值*/
@property (nonatomic, strong) NSString *end;

/**含有率*/
@property (nonatomic, strong) NSString *containingRate;
/**幅值*/
@property (nonatomic, strong) NSString *passageValue;
/**相位*/
@property (nonatomic, strong) NSString *phase;


@end
