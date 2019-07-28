//
//  BD_QuickTestIECParamCell2.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestIECParamCell2.h"
#import "UITextField+Extension.h"
@interface BD_QuickTestIECParamCell2()<UITextFieldDelegate>
@end

@implementation BD_QuickTestIECParamCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;

    
    _cellTitle.textColor = White;
    [_PTvoltage1 setDefaultSetting];
    [_PTvoltage2 setDefaultSetting];
    [_CTcurrent1 setDefaultSetting];
    [_CTcurrent2 setDefaultSetting];
    
    _PTvoltage1.clearButtonMode = UITextFieldViewModeNever;
    _PTvoltage2.clearButtonMode = UITextFieldViewModeNever;
    _CTcurrent1.clearButtonMode = UITextFieldViewModeNever;
    _CTcurrent2.clearButtonMode = UITextFieldViewModeNever;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
