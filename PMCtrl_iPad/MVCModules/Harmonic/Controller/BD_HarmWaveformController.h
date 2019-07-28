//
//  BD_HarmWaveformController.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2018/1/22.
//  Copyright © 2018年 ponovo. All rights reserved.
//  谐波波形视图

#import <UIKit/UIKit.h>
#import "BD_HarmModel.h"

@interface BD_HarmWaveformController : UIViewController

/**谐波模型*/
@property (nonatomic, weak) BD_HarmModel *harmModel;

/**重汇波形*/
-(void)drawWaveformLine:(BD_HarmModel *)harmModel;

@end
