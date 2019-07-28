//
//  BD_HardwareConfigView.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2017/11/19.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BD_DevicePassagewayModel;
@class BD_HardwarkConfigModel;

@protocol BD_HardwareConfitDelegate <NSObject>

-(void)disMissHardwareView;

@end
@interface BD_HardwareConfigView : UIView
@property(nonatomic,strong)BD_HardwarkConfigModel *viewModel;
@property(nonatomic,weak)id<BD_HardwareConfitDelegate>dissdelegate;
@property(nonatomic,strong)NSMutableArray<BD_DevicePassagewayModel *> *passagewayNameArr_V;
@property(nonatomic,strong)NSMutableArray<BD_DevicePassagewayModel *> *passagewayNameArr_C;
@property(nonatomic,strong)void(^hardwareConfigComplete)(BD_HardwarkConfigModel *);
@property(nonatomic,assign)BD_TestModuleType moduletype;
-(void)setViewDataFromRead;
/**差动／距离／递变／搜索阻抗／整组等，系统配置为4U3I,无数模一体，设置页面样式*/
-(void)SUSUViewConfig;
/**谐波配置页面*/
-(void)SixUIViewConfig;
@end
