//
//  BD_QuickTestComParamVarCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestComParamVarCell.h"

@implementation BD_QuickTestComParamVarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.backgroundColor = MainBgColor;
    self.contentView.backgroundColor = ClearColor;
    
    self.contentView.layer.borderColor = Black.CGColor;
    self.contentView.layer.borderWidth = 1.0;
    [_containerView setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [_containerView setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    _cellLabel.textColor = White;
    _valueBtn1.layer.borderWidth = 1.0;
    _valueBtn1.layer.cornerRadius = 5;
    _valueBtn1.layer.masksToBounds = YES;
    _valueBtn1.layer.borderColor = White.CGColor;
    [_valueBtn1 setTitleColor:White forState:UIControlStateNormal];
    
    _valueBtn2.layer.borderWidth = 1.0;
    _valueBtn2.layer.cornerRadius = 5;
    _valueBtn2.layer.masksToBounds = YES;
    _valueBtn2.layer.borderColor = White.CGColor;
    [_valueBtn2 setTitleColor:White forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)valueBtn1Click:(id)sender {
    self.passagewayGroupBlock(_valueBtn1);
}
- (IBAction)valueBtn2Click:(id)sender {
    self.passagewayVarValueBlock(_valueBtn2);
}

@end
