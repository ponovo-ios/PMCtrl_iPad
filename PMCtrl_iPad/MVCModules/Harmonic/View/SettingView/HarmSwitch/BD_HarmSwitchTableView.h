//
//  BD_HarmSwitchTableView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_HarmSwitchSettingModel.h"


@interface BD_HarmSwitchTableView : UITableView

/**开关量设置模型*/
@property (nonatomic, weak) BD_HarmSwitchSettingModel *switchModel;

@end
