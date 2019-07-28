//
//  BD_QuickTestParamHeaderView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *手动测试页面 数据页 tableView headerView  幅值 相位 频率 */
@interface BD_QuickTestParamHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *phaseLabel;

@property (weak, nonatomic) IBOutlet UILabel *amplitudeLabel;
@end
