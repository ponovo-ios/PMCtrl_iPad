//
//  BD_HarmSwitchCell.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_HarmSwitchCell : UITableViewCell
/**开出数组*/
@property (nonatomic, weak) NSMutableArray *switchOutArray;
/**index*/
@property (nonatomic, assign) NSInteger index;
/**标题1*/
@property (nonatomic, weak) UILabel *firstTitle;
/**标题2*/
@property (nonatomic, weak) UILabel *secondTitle;
/**开关1*/
@property (nonatomic, weak) UISwitch *firstSwitch;
/**开关2*/
@property (nonatomic, weak) UISwitch *secondSwitch;
@end
