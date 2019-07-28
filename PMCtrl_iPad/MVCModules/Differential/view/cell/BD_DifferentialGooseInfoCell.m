//
//  BD_DifferentialGooseInfoCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/13.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferentialGooseInfoCell.h"

@implementation BD_DifferentialGooseInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_value2 setCorenerRadius:0.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [_value1 setCorenerRadius:0.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)getReverseAction:(id)sender {
    _getReverseBtn.selected = !_getReverseBtn.selected;
    
}

- (IBAction)repairAction:(id)sender {
    _repairBtn.selected = !_repairBtn.selected;
    
}

@end
