//
//  BD_HarmDataSettingCell.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDataSettingCell.h"
#import "UITextField+Extension.h"

@interface BD_HarmDataSettingCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *passageVoltageLabel;

@end

@implementation BD_HarmDataSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.amplitudeTF setDefaultSetting];
    [self.containingRateTF setDefaultSetting];
    [self.phaseTF setDefaultSetting];
    self.containingRateTF.text = @"";
    self.amplitudeTF.text = @"";
    self.phaseTF.text = @"";
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.containingRateTF]) {
        self.amplitudeTF.text = @"";
    } else if ([textField isEqual:self.amplitudeTF]){
        self.containingRateTF.text = @"";
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string{
    //获取变化后的字符串
    NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if([textField isEqual:self.phaseTF]){
        //相位
        if (newText.floatValue>180){
            textField.text = @"180.000";
            return NO;
        } else if (newText.floatValue<-180){
            textField.text = @"-180.000";
            return NO;
        }
    } else {
        if (newText.floatValue>99999){
            textField.text = @"99999.000";
            return NO;
        } else if (newText.floatValue<0.000){
            textField.text = @"0.000";
            return NO;
        }
    }
    
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%.3f", textField.text.floatValue];
    DLog(@"%zd -- %@", textField.tag, textField.text);
    [self.delegate changeValue:textField.tag text:textField.text];
}

-(void)changePassageWay:(NSString *)passageWay{
    if ([passageWay hasPrefix:@"U"]) {
        self.passageVoltageLabel.text = @"通道幅值(V)";
    } else {
         self.passageVoltageLabel.text = @"通道幅值(A)";
    }
}

@end
