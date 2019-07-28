//
//  BD_QuickTestComParamSwitchSetCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/16.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestComParamSwitchSetCell.h"

@implementation BD_QuickTestComParamSwitchSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = MainBgColor;
    self.contentView.backgroundColor = ClearColor;
//    
//    self.contentView.layer.borderColor = Black.CGColor;
//    self.contentView.layer.borderWidth = 1.0;
    [_containerView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_containerView setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]];
    _makeInTitle.textColor = White;
    _makeOutTitle.textColor = White;
    
    
    [_makeInSwitch setOnTintColor:SwitchBGColor];
    [_makeOutSwitch setOnTintColor:SwitchBGColor];

    [_makeInsegment setTitleTextAttributes:@{NSForegroundColorAttributeName:Black,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateNormal];
    [_makeInsegment setTitleTextAttributes:@{NSForegroundColorAttributeName:White,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateSelected];
     

    [_makeInsegment setTintColor:SwitchBGColor];

    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)makeInSegmentSelected:(id)sender {
    self.binaryLogicChangedBlock((int)_makeInsegment.selectedSegmentIndex);
}

- (IBAction)changebinaryInState:(id)sender {
    
    self.binaryInChangedBlock(@(_makeInSwitch.isOn),_cellindex);
    
}

- (IBAction)changebinaryOutState:(id)sender {
    
    self.binaryOutChangedBlock(@(_makeOutSwitch.isOn),_cellindex);
}


@end
