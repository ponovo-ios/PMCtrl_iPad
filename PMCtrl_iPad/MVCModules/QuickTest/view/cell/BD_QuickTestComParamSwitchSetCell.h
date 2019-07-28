//
//  BD_QuickTestComParamSwitchSetCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/16.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *手动测试 通用参数设置页 开关量设置cell
 */

@interface BD_QuickTestComParamSwitchSetCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *makeInTitle;
@property (weak, nonatomic) IBOutlet UISwitch *makeInSwitch;

@property (weak, nonatomic) IBOutlet UILabel *makeOutTitle;
@property (weak, nonatomic) IBOutlet UISwitch *makeOutSwitch;


@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *makeInsegment;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@property (nonatomic,strong)NSIndexPath *cellindex;
@property (nonatomic,strong)void(^binaryInChangedBlock)(NSNumber *,NSIndexPath *);
@property (nonatomic,strong)void(^binaryOutChangedBlock)(NSNumber *,NSIndexPath *);
@property (nonatomic,strong)void(^binaryLogicChangedBlock)(int);

@end
