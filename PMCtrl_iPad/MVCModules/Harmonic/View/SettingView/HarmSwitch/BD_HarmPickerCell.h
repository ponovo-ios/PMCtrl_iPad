//
//  BD_HarmPickerCell.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_PickerButton.h"

@class BD_HarmSwitchSettingModel;
@interface BD_HarmPickerCell : UITableViewCell
/**开关量设置模型*/
@property (nonatomic, weak) BD_HarmSwitchSettingModel *switchModel;

/**index*/
@property (nonatomic, assign) NSInteger index;
/**分割线*/
@property (nonatomic, weak) UIView *lineView;
/**标题1*/
@property (nonatomic, weak) UILabel *firstTitle;
/**标题2*/
@property (nonatomic, weak) UILabel *secondTitle;
/**按钮1*/
@property (nonatomic, weak) BD_PickerButton *firstBtn;
/**按钮2*/
@property (nonatomic, weak) BD_PickerButton *secondBtn;


@end
