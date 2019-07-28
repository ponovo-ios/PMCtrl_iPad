//
//  BD_HarmDCTableView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_HarmDCSettingModel.h"

@interface BD_HarmDCTableView : UITableView

/**直流设置模型*/
@property (nonatomic, strong) BD_HarmDCSettingModel *dcSettingModel;

-(void)reloadDataWithType:(BDDeviceType)type passageway:(BDHarmPassageType)passageway;

@end
