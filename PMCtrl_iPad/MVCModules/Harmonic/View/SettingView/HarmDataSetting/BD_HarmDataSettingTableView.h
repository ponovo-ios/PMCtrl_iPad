//
//  BD_HarmDataSettingTableView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_HarmModel.h"

@interface BD_HarmDataSettingTableView : UITableView
///**通道选择*/
//@property (nonatomic, weak) NSMutableArray *passagewayArray;

/**谐波模型*/
@property (nonatomic, weak) BD_HarmModel *harmModel;

/**切换谐波通道设置*/
-(void)changedType:(BDDeviceType)type passageway:(BDHarmPassageType)passageway;
@end
