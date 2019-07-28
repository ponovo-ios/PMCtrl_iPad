//
//  BD_HarmDataController.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_HarmModel.h"

@interface BD_HarmDataController : UIViewController

/**谐波模型*/
@property (nonatomic, weak) BD_HarmModel *harmModel;

-(void)loadSubViewType:(BDDeviceType)type passageway:(BDHarmPassageType)passageway;

//-(void)loadSubView;

//移除子视图
-(void)clearSubViews;
-(void)updateDataView;
@end
