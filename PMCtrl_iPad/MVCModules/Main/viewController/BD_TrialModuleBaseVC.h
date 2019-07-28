//
//  BD_TrialModuleBaseVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BD_PMCtrlBaseVC.h"
@class BD_HardwareConfigView;
@class BD_HardwarkConfigModel;
@interface BD_TrialModuleBaseVC : BD_PMCtrlBaseVC
@property(nonatomic,strong)BD_HardwareConfigView *hardWareView;
@property (nonatomic,strong)BD_HardwarkConfigModel *hardwarkSetData;

/** 显示iec配置页面方法*/
-(void)showIECView;
//硬件配置完成后调用方法
-(void)deviceSettingFinised:(BD_HardwarkConfigModel *)hardData;
//显示系统配置页面
-(void)showDeviceConfig;
/**读取测试仪信息后，修改页面数据配置*/
-(void)getDeviceInfoToChangeViewData;

/**网络断开，各个子页面自己的操作*/
-(void)netWordDisConnect;
@end
