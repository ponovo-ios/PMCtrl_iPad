//
//  BD_DifferentialBinarayCell.h
//  PMCtrl_iOS
//
//  Created by wang on 2017/5/30.
//  Copyright © 2017年 wgx. All rights reserved.
//  开关量设置

#import <UIKit/UIKit.h>

@interface BD_DifferentialBinarayCell : UITableViewCell
/**标题*/
@property (weak, nonatomic) UILabel *titleLabel;

@property (nonatomic, weak) UIButton * valueBtn;
/**数值*/
@property (weak, nonatomic) UIButton *selected;

@end
