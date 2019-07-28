//
//  BD_HarmSuperDCVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/7/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BD_HarmDCSettingModel;
@interface BD_HarmSuperDCVC : UIViewController

/**页面赋值*/
-(void)setViewData:(BD_HarmDCSettingModel *)dcSettingModel deviceType:(BDDeviceType)deviceType passageWay:(BDHarmPassageType)passageType;
-(void)closeView;
@end
