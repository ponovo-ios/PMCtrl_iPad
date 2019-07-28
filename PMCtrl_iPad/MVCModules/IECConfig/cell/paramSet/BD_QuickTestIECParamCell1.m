//
//  BD_QuickTestIECParamCell1.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestIECParamCell1.h"
#import "UITextField+Extension.h"
@interface BD_QuickTestIECParamCell1()<UITextFieldDelegate>

@end

@implementation BD_QuickTestIECParamCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;
    [[BD_Utils shared]setLabelColors:@[_title1,_title2,_unit1,_unit2] withColor:White];
    
    [_value1 setDefaultSetting];
    [_value2 setDefaultSetting];
    
    _value2.delegate = self;
    _value1.delegate = self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)exportSelect:(id)sender {
//    if ([_delegate respondsToSelector:@selector(valueBtn1Click)]) {
//        [self.delegate valueBtn1Click];
//    }
    self.value1BtnClickBlock(_value1);
    
}


- (IBAction)weakVoltage:(id)sender {
    self.value1BtnClickBlock(_value2);
//    if ([_delegate respondsToSelector:@selector(valueBtn2Click)]) {
//        [self.delegate valueBtn2Click];
//    }

}


@end
