//
//  UITextField+Extension.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField(Extension)
-(void)setDefaultSetting{
//    self.clearsOnBeginEditing = YES;//设置获取焦点，清空内容
    self.clearButtonMode = UITextFieldViewModeAlways;//设置textfield右侧的清除按钮
    self.keyboardType = UIKeyboardTypeDecimalPad;//设置只能输入数字键盘
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = White.CGColor;
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = ClearColor;
    self.textColor = White;
}
-(void)setIECTFDefaultSetting{
    //    self.clearsOnBeginEditing = YES;//设置获取焦点，清空内容
    self.clearButtonMode = UITextFieldViewModeAlways;//设置textfield右侧的清除按钮
    self.keyboardType = UIKeyboardTypeDefault;//设置只能输入数字键盘
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = White.CGColor;
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = ClearColor;
    self.textColor = White;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
