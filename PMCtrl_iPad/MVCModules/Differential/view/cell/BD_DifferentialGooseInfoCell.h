//
//  BD_DifferentialGooseInfoCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/13.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_DifferentialGooseInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *value1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *value2;

@property (weak, nonatomic) IBOutlet UILabel *getReverseLabel;
@property (weak, nonatomic) IBOutlet UIButton *getReverseBtn;
@property (weak, nonatomic) IBOutlet UIButton *repairBtn;
@property (weak, nonatomic) IBOutlet UILabel *repairLabel;




@end
